using System;
using System.Interop;
namespace FUSE.fuse;

public static
{
	public const int FUSE_MAJOR_VERSION = 2;
	public const int FUSE_MINOR_VERSION = 8;

	public static int FUSE_MAKE_VERSION(int maj, int min) => (maj *10 ) + min;
	public const int FUSE_VERSIOn = FUSE_MAKE_VERSION(FUSE_MAJOR_VERSION, FUSE_MINOR_VERSION);

	public const int FSP_FUSE_UF_HIDDEN = 0x00008000;
	public const int FSP_FUSE_UF_READONLY = 0x00001000;
	public const int FSP_FUSE_UF_SYSTEM = 0x00000080;
	public const int FSP_FUSE_UF_ARCHIVE = 0x00000800;

	public const int UF_HIDDEN = FSP_FUSE_UF_HIDDEN;
	public const int UF_READONLY = FSP_FUSE_UF_READONLY;
	public const int UF_SYSTEM = FSP_FUSE_UF_SYSTEM;
	public const int UF_ARCHIVE = FSP_FUSE_UF_ARCHIVE;

	public const int FSP_FUSE_DELETE_OK = 0x40000000;
	public const int FSP_FUSE_HAS_GETPATH = 1;
}

enum FuseCap : c_uint
{
	ASYNC_READ = (1 << 0),
	POSIX_LOCKS = (1 << 1),
	ATOMIC_O_TRUNC = (1 << 3),
	EXPORT_SUPPORT = (1 << 4),
	BIG_WRITES = (1 << 5),
	DONT_MASK = (1 << 6),
	ALLOCATE = (1 << 27),   /* reserved (OSXFUSE) */
	EXCHANGE_DATA = (1 << 28),   /* reserved (OSXFUSE) */
	CASE_INSENSITIVE = (1 << 29),   /* file system is case insensitive */
	VOL_RENAME = (1 << 30),   /* reserved (OSXFUSE) */
	XTIMES = (1 << 31),   /* reserved (OSXFUSE) */

	FSP_READDIR_PLUS = (1 << 21),   /* file system supports enhanced readdir */
	FSP_READ_ONLY = (1 << 22),   /* file system is marked read-only */
	FSP_STAT_EX = (1 << 23),   /* file system supports fuse_stat_ex */
	FSP_DELETE_ACCESS = (1 << 24),   /* file system supports access with DELETE_OK */
	#unwarn
	FSP_CASE_INSENSITIVE = .CASE_INSENSITIVE,
}

enum fuse_IOCTL
{
	Compat = (1 << 0),
	Unrestricted = (1 << 1),
	Retry = (1 << 2),
	MaxIOV = 256
}

enum fuse_notify : c_int
{
	MKDIR = 0x0001,
	RMDIR = 0x0002,
	CREATE = 0x0004,
	UNLINK = 0x0008,
	CHMOD = 0x0010,
	CHOWN = 0x0020,
	UTIME = 0x0040,
	CHFLAGS = 0x0080,
	TRUNCATE = 0x0100,
}

[CRepr]
struct fuse_file_info
{
    public c_int flags;
    public c_uint fh_old;
    public c_int writepage;
    /*unsigned int direct_io:1;
    unsigned int keep_cache:1;
    unsigned int flush:1;
    unsigned int nonseekable:1;
    unsigned int padding:28;*/
	[Bitfield<bool>(.Public, .Bits(1), "direct_io", .Read)]
	[Bitfield<bool>(.Public, .Bits(1), "keep_cache", .Read)]
	[Bitfield<bool>(.Public, .Bits(1), "flush", .Read)]
	[Bitfield<bool>(.Public, .Bits(1), "nonseekable", .Read)]
	c_uint _data;

    public uint64 fh;
    public uint64 lock_owner;
}

[CRepr]
struct fuse_conn_info
{
    public c_uint proto_major;
    public c_uint proto_minor;
    public c_uint async_read;
    public c_uint max_write;
    public c_uint max_readahead;
    public c_uint capable;
    public c_uint want;
    public c_uint[25] reserved;
}

struct fuse_session;
struct fuse_chan;
struct fuse_pollhandle;
struct fuse_bufvec;
struct fuse_statfs;
struct fuse_setattr_x;

function c_int PFN_fuse_version();
function fuse_chan* PFN_fuse_mount(c_char* mountpoint, fuse_args* args);
function void PFN_fuse_unmount(c_char* mountpoint, fuse_chan* ch);
function c_int PFN_fuse_parse_cmdline(fuse_args* args, c_char** mountpoint, c_int* multithreaded, c_int* foreground);
function void PFN_fuse_pollhandle_destroy(fuse_pollhandle* ph);
function c_int PFN_fuse_daemonize(c_int foreground);
function c_int PFN_fuse_set_signal_handlers(fuse_session* se);
function void PFN_fuse_remove_signal_handlers(fuse_session* se);

public static
{
#if FUSE_STATIC
	[CLink]
	public static extern c_int fuse_version();
	[CLink]
	public static extern fuse_chan* fuse_mount(c_char* mountpoint, fuse_args* args);
	[CLink]
	public static extern void fuse_unmount(c_char* mountpoint, fuse_chan* ch);
	[CLink]
	public static extern c_int fuse_parse_cmdline(fuse_args* args, c_char** mountpoint, c_int* multithreaded, c_int* foreground);
	[CLink]
	public static extern void fuse_pollhandle_destroy(fuse_pollhandle* ph);
	[CLink]
	public static extern c_int fuse_daemonize(c_int foreground);
	[CLink]
	public static extern c_int fuse_set_signal_handlers(fuse_session* se);
	[CLink]
	public static extern void fuse_remove_signal_handlers(fuse_session* se);
#else
	public static PFN_fuse_version fuse_version;
	public static PFN_fuse_mount fuse_mount;
	public static PFN_fuse_unmount fuse_unmount;
	public static PFN_fuse_parse_cmdline fuse_parse_cmdline;
	public static PFN_fuse_pollhandle_destroy fuse_pollhandle_destroy;
	public static PFN_fuse_daemonize fuse_daemonize;
	public static PFN_fuse_set_signal_handlers fuse_set_signal_handlers;
	public static PFN_fuse_remove_signal_handlers fuse_remove_signal_handlers;
#endif
}
