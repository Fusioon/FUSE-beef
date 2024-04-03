#if BF_PLATFORM_WINDOWS

using System;
using System.Interop;
using System.IO;

namespace FUSE.winfsp;

class WinFSP_Loader
{
	[CLink]
	static extern Windows.HModule LoadLibraryA(c_char* libName);
	[CLink]
	static extern void* GetProcAddress(Windows.HModule hModule, c_char* procName);

	[Comptime(ConstEval=true)]
	static String GetLibName()
	{
#if BF_LITTLE_ENDIAN
#if BF_32_BIT
			return "winfsp-x86.dll";
#elif BF_64_BIT
			return "winfsp-x64.dll";
#else
		#error Unsupported ARCH
#endif
#else
		return "winfsp-a64.dll";
#endif
	}

	static Windows.HModule _lib;

	public static Result<void> LoadLib()
	{
		const String LIB_NAME = GetLibName();

		_lib = LoadLibraryA(LIB_NAME.CStr());
		if (_lib != 0)
			return .Ok;

		// Dll not present in path, try lookup from registry

		char16[Windows.MAX_PATH] pathbuf = ?;

		let kname = @"Software\WinFsp".ToScopedNativeWChar!();
		if (Windows.RegOpenKeyExW(Windows.HKEY_LOCAL_MACHINE, kname, 0, Windows.KEY_READ | Windows.KEY_WOW64_32KEY, let regKey) != Windows.ERROR_SUCCESS)
			return .Err;

		defer Windows.RegCloseKey(regKey);

		let vname = "InstallDir".ToScopedNativeWChar!();
		uint32 regType = 0;
		uint32 size = sizeof(decltype(pathbuf));
		Windows.RegQueryValueExW(regKey, vname, null, &regType, &pathbuf, &size);
		if (regType != Windows.REG_SZ)
			return .Err;

		if (size > 0 && pathbuf[size/sizeof(char16) - 1] == 0)
			size -= 2;

		let dllPath = scope String(Span<char16>(&pathbuf, size / sizeof(char16)));
		Path.Combine(dllPath, "bin", LIB_NAME);
		_lib = LoadLibraryA(dllPath.CStr());
		if (_lib == 0)
			return .Err;

		return .Ok;
	}

	public static void* GetProcAddress(c_char* procName)
	{
		return GetProcAddress(_lib, procName);
	}
}

#endif