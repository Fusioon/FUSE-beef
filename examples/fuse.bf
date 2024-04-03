using System;

using FUSE;
using FUSE.fuse;
using FUSE.winfsp;

namespace FUSE.Examples;

class Program
{
	struct options
	{
		public int32 show_help;
	}

	static int Main(String[] args)
	{
		const bool USE_OPTS = false;
		const String EXAMPLE_FILENAME = "hello.txt";
		const String EXAMPLE_CONTENTS = "Hello world!";
		const String MOUNT_POINT = "X:";

		WinFSP_Loader.LoadLib();

		// Seems like fuse_arsg cannot be empty, so we have to fill in an empty value in that case
		int argCount = Math.Min(1, args.Count);
		char8**  buff = scope .[argCount]*;
		for (let i < args.Count)
			buff[i] = args[i];

		if (args.Count == 0)
		{
			buff[0] = "";
		}

		fuse_args fuseargs = .{
			argc = (.)args.Count,
			argv = buff
		};

		options opt = default;

		if (USE_OPTS)
		{
			let fuse_opt_parse = (PFN_fuse_opt_parse)WinFSP_Loader.GetProcAddress("fuse_opt_parse");

			fuse_opt[?] option_spec = .(
				.{ templ = "-h", offset = offsetof(options, show_help), value = 1 },
				.{ templ = "--help", offset = offsetof(options, show_help), value = 1 },
				default
			);

			if (fuse_opt_parse(&fuseargs, &opt, &option_spec, null) == -1)
				return -1;

			if (opt.show_help == 1)
			{
				Console.WriteLine("HELP");
				return 0;
			}
		}	
		
		fuse_operations op = default;
		op.init = (conn) => {
			Console.WriteLine("init");
			return null;
		};
		op.getattr = (conn, stbuf) => {
			StringView c = .(conn);
			Console.WriteLine($"getattr {c}");
			if (c == "/")
			{
				stbuf.st_ino = 1;
				stbuf.st_mode = S_IFDIR | 0o777;
				stbuf.st_nlink = 1;
				stbuf.st_size = 0;
				stbuf.st_uid = 0;
				stbuf.st_gid = 0;
				stbuf.st_dev = 0;

				stbuf.st_atim = stbuf.st_mtim = stbuf.st_ctim = stbuf.st_birthtim = .Now();
				return 0;
			}
			else if (c.EndsWith(EXAMPLE_FILENAME))
			{
				stbuf.st_mode = S_IFREG | 0o444;
				stbuf.st_nlink = 1;
				stbuf.st_size = EXAMPLE_CONTENTS.Length;
				stbuf.st_uid = 0;
				stbuf.st_gid = 0;
				stbuf.st_dev = 0;
				stbuf.st_atim = stbuf.st_mtim = stbuf.st_ctim = stbuf.st_birthtim = .FromDateTime(.Now - TimeSpan.FromHours(3));

				return 0;
			}

			return -ENOENT;
		};
		op.statfs = (path, stbuf) => {
			*stbuf = default;
			return 0;
		};
		op.readdir = (path, buf, filler, off, fi) => {
			StringView c = .(path);
			Console.WriteLine($"readdir {c}");

			if (c != "/")
				return -ENOENT;

			filler(buf, ".", null, 0);
			filler(buf, "..", null, 0);
			filler(buf, EXAMPLE_FILENAME, null, 0);

			return 0;
		};
		op.open = (path, fi) => {
			StringView c = .(path);
			Console.WriteLine($"open {c}");

			if (!c.EndsWith(EXAMPLE_FILENAME))
			{
				return -ENOENT;
			}

			if (fi.flags & O_ACCMODE != O_RDONLY)
				return -EACCES;

			return 0;
		};
		op.opendir = (path, fi) => {
			StringView c = .(path);
			Console.WriteLine($"opendir {c}");

			if (c != "/")
				return -ENOENT;

			return 0;
		};
		op.releasedir = (path, fi) => {
			StringView c = .(path);
			Console.WriteLine($"releasedir {c}");

			if (c != "/")
				return -ENOENT;

			return 0;
		};
		op.read = (path, buf, size, off, fi) => {
			StringView c = .(path);
			Console.WriteLine($"read {c}");

			if (!c.EndsWith(EXAMPLE_FILENAME))
			{
				return -ENOENT;
			}

			int s = 0;
			if (off < EXAMPLE_CONTENTS.Length)
			{
				if (off + (int)size > EXAMPLE_CONTENTS.Length)
				{
					s = EXAMPLE_CONTENTS.Length - off;
				}

				Internal.MemCpy(buf, EXAMPLE_CONTENTS.Ptr + off, (.)s);
			}
			else
				s = 0;

			return (.)s;

		};
		op.setxattr = (path, name, value, size, flags) => {
			Console.WriteLine("setxattr");
			return 0;
		};
		op.getxattr = (path, name, value, size) => {
			Console.WriteLine("getxattr");
			return 0;
		};
		op.removexattr = (path, name) => {
			Console.WriteLine("removexattr");
			return 0;
		};

		let fuse_mount = (PFN_fuse_mount)WinFSP_Loader.GetProcAddress("fuse_mount");
		let fuse_unmount = (PFN_fuse_unmount)WinFSP_Loader.GetProcAddress("fuse_unmount");
		let fuse_new = (PFN_fuse_new)WinFSP_Loader.GetProcAddress("fuse_new");
		let fuse_destroy = (PFN_fuse_destroy)WinFSP_Loader.GetProcAddress("fuse_destroy");

		let fuse_set_signal_handlers = (PFN_fuse_set_signal_handlers)WinFSP_Loader.GetProcAddress("fuse_set_signal_handlers");
		let fuse_get_session = (PFN_fuse_get_session)WinFSP_Loader.GetProcAddress("fuse_get_session");
		let fuse_session_loop = (PFN_fuse_loop)WinFSP_Loader.GetProcAddress("fuse_loop");

		let mount = fuse_mount(MOUNT_POINT, &fuseargs);
		if (mount == null)
			return 1;
		defer fuse_unmount(MOUNT_POINT, mount);

		let fuse = fuse_new(mount, &fuseargs, &op, sizeof(decltype(op)), null);
		if (fuse == null)
			return 1;
		defer fuse_destroy(fuse);

		let session = fuse_get_session(fuse);
		if (session == null)
			return 1;

		fuse_set_signal_handlers(session);
		fuse_session_loop(fuse);

		return 0;
	}

}