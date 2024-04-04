#if BF_PLATFORM_WINDOWS

using System;
using System.Interop;
using System.IO;

namespace FUSE.winfsp;

static class WinFSP_Loader
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

		size /= sizeof(char16);

		if (size > 0 && pathbuf[size - 1] == 0)
			size--;

		let dllPath = scope String(Span<char16>(&pathbuf, size));
		Path.Combine(dllPath, "bin", LIB_NAME);
		_lib = LoadLibraryA(dllPath.CStr());
		if (_lib == 0)
			return .Err;

		return .Ok;
	}

	static mixin LoadFN(var fn, char8* name)
	{
		fn = (.)GetProcAddress(name);
	}

	public static void FUSE_Load()
	{
		LoadFN!(FUSE.fuse.fuse_main_real, "fuse_main_real");
		LoadFN!(FUSE.fuse.fuse_is_lib_option, "fuse_is_lib_option");
		LoadFN!(FUSE.fuse.fuse_new, "fuse_new");
		LoadFN!(FUSE.fuse.fuse_destroy, "fuse_destroy");
		LoadFN!(FUSE.fuse.fuse_loop, "fuse_loop");
		LoadFN!(FUSE.fuse.fuse_loop_mt, "fuse_loop_mt");
		LoadFN!(FUSE.fuse.fuse_exit, "fuse_exit");
		LoadFN!(FUSE.fuse.fuse_exited, "fuse_exited");
		LoadFN!(FUSE.fuse.fuse_notify, "fuse_notify");
		LoadFN!(FUSE.fuse.fuse_get_context, "fuse_get_context");
		LoadFN!(FUSE.fuse.fuse_getgroups, "fuse_getgroups");
		LoadFN!(FUSE.fuse.fuse_interrupted, "fuse_interrupted");
		LoadFN!(FUSE.fuse.fuse_invalidate, "fuse_invalidate");
		LoadFN!(FUSE.fuse.fuse_notify_poll, "fuse_notify_poll");
		LoadFN!(FUSE.fuse.fuse_get_session, "fuse_get_session");

		LoadFN!(FUSE.fuse.fuse_version, "fuse_version");
		LoadFN!(FUSE.fuse.fuse_mount, "fuse_mount");
		LoadFN!(FUSE.fuse.fuse_unmount, "fuse_unmount");
		LoadFN!(FUSE.fuse.fuse_parse_cmdline, "fuse_parse_cmdline");
		LoadFN!(FUSE.fuse.fuse_pollhandle_destroy, "fuse_pollhandle_destroy");
		LoadFN!(FUSE.fuse.fuse_daemonize, "fuse_daemonize");
		LoadFN!(FUSE.fuse.fuse_set_signal_handlers, "fuse_set_signal_handlers");
		LoadFN!(FUSE.fuse.fuse_remove_signal_handlers, "fuse_remove_signal_handlers");
	}

	public static void FUSE_LoadOpt()
	{
		LoadFN!(FUSE.fuse.fuse_opt_parse, "fuse_opt_parse");
		LoadFN!(FUSE.fuse.fuse_opt_add_arg, "fuse_opt_add_arg");
		LoadFN!(FUSE.fuse.fuse_opt_insert_arg, "fuse_opt_insert_arg");
		LoadFN!(FUSE.fuse.fuse_opt_free_args, "fuse_opt_free_args");
		LoadFN!(FUSE.fuse.fuse_opt_add_opt, "fuse_opt_add_opt");
		LoadFN!(FUSE.fuse.fuse_opt_add_opt_escaped, "fuse_opt_add_opt_escaped");
		LoadFN!(FUSE.fuse.fuse_opt_match, "fuse_opt_match");
	}

	public static void* GetProcAddress(c_char* procName)
	{
		return GetProcAddress(_lib, procName);
	}
}

#endif