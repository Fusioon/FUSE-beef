using System;
using System.Interop;

namespace FUSE.fuse;

typealias fuse_uid_t = uint32;
typealias fuse_gid_t = uint32;
typealias fuse_pid_t = int32;
typealias fuse_dev_t = uint32;
typealias fuse_ino_t = uint64;
typealias fuse_mode_t = uint32;
typealias fuse_nlink_t = uint16;
typealias fuse_off_t = int64;

typealias fuse_fsblkcnt_t = uint;
typealias fuse_fsfilcnt_t = uint;

typealias fuse_blksize_t = int32;
typealias fuse_blkcnt_t = int64;

typealias uid_t = fuse_uid_t;
typealias gid_t = fuse_gid_t;
typealias pid_t = fuse_pid_t;
typealias dev_t = fuse_dev_t;
typealias ino_t = fuse_ino_t;
typealias mode_t = fuse_mode_t;
typealias nlink_t = fuse_nlink_t;
typealias off_t = fuse_off_t;
typealias fsblkcnt_t = fuse_fsblkcnt_t;
typealias fsfilcnt_t = fuse_fsfilcnt_t;
typealias blksize_t = fuse_blksize_t;
typealias blkcnt_t = fuse_blkcnt_t;
/*typealias utimbuf = fuse_utimbuf;
typealias timespec = fuse_timespec;*/

[CRepr]
struct fuse_utimbuf
{
    public int actime;
    public int modtime;
}

[CRepr]
struct fuse_timespec
{
    public int tv_sec;
    public int tv_nsec;

	public static Self Now() => FromDateTimeOffset(DateTimeOffset.Now);

	public static Self FromDateTimeOffset(DateTimeOffset off)
	{
		let msec = off.ToUnixTimeMilliseconds();
		let sec = msec / 1000;
		let nsec = (msec % 1000) * 1'000'000;
		return .(){ tv_sec = sec, tv_nsec = nsec  };
	}

	public static Self FromDateTime(DateTime dt) => FromDateTimeOffset(DateTimeOffset(dt));
}

[CRepr]
struct fuse_stat
{
	public fuse_dev_t st_dev;                  
	public fuse_ino_t st_ino;                  
	public fuse_mode_t st_mode;                
	public fuse_nlink_t st_nlink;              
	public fuse_uid_t st_uid;                  
	public fuse_gid_t st_gid;                  
	public fuse_dev_t st_rdev;                 
	public fuse_off_t st_size;                 
	public fuse_timespec st_atim;       
	public fuse_timespec st_mtim;       
	public fuse_timespec st_ctim;       
	public fuse_blksize_t st_blksize;          
	public fuse_blkcnt_t st_blocks;            
	public fuse_timespec st_birthtim;
}

[CRepr]
struct fuse_stat_ex
{
	public using fuse_stat stat;
	public uint32 st_flags;
	public uint32[3] st_reserved32;
	public uint64[2] st_reserved64;
}

[CRepr]
struct fuse_statvfs
{
    public uint f_bsize;
    public uint f_frsize;
    public fuse_fsblkcnt_t f_blocks;
    public fuse_fsblkcnt_t f_bfree;
    public fuse_fsblkcnt_t f_bavail;
    public fuse_fsfilcnt_t f_files;
    public fuse_fsfilcnt_t f_ffree;
    public fuse_fsfilcnt_t f_favail;
    public uint f_fsid;
    public uint f_flag;
    public uint f_namemax;
}

[CRepr]
struct fuse_flock
{
    public int16 l_type;
    public int16 l_whence;
    public fuse_off_t l_start;
    public fuse_off_t l_len;
    public fuse_pid_t l_pid;
}

public function c_int fuse_fill_dir_t(void *buf, c_char* name, fuse_stat* stbuf, fuse_off_t off);

struct fuse_dirhandle;
typealias fuse_dirh_t = fuse_dirhandle*;

public function c_int fuse_dirfil_t(fuse_dirh_t h, c_char* name, c_int type, fuse_ino_t ino);


[CRepr]
struct fuse_operations
{
	/* S - supported by WinFsp */
	/* S */ public function c_int (c_char* path, fuse_stat *stbuf) getattr;
	/* S */ public function c_int (c_char* path, fuse_dirh_t h, fuse_dirfil_t filler) getdir;
	/* S */ public function c_int (c_char* path, c_char *buf, c_size size) readlink;
	/* S */ public function c_int (c_char* path, fuse_mode_t mode, fuse_dev_t dev) mknod;
	/* S */ public function c_int (c_char* path, fuse_mode_t mode) mkdir;
	/* S */ public function c_int (c_char* path) unlink;
	/* S */ public function c_int (c_char* path) rmdir;
	/* S */ public function c_int (c_char* dstpath, c_char* srcpath) symlink;
	/* S */ public function c_int (c_char* oldpath, c_char* newpath) rename;
	/* _ */ public function c_int (c_char* srcpath, c_char* dstpath) link;
	/* S */ public function c_int (c_char* path, fuse_mode_t mode) chmod;
	/* S */ public function c_int (c_char* path, fuse_uid_t uid, fuse_gid_t gid) chown;
	/* S */ public function c_int (c_char* path, fuse_off_t size) truncate;
	/* S */ public function c_int (c_char* path, fuse_utimbuf *timbuf) utime;
	/* S */ public function c_int (c_char* path, fuse_file_info *fi) open;
	/* S */ public function c_int (c_char* path, c_char *buf, c_size size, fuse_off_t off, fuse_file_info *fi) read;
	/* S */ public function c_int (c_char* path, c_char* buf, c_size size, fuse_off_t off, fuse_file_info *fi) write;
	/* S */ public function c_int (c_char* path, fuse_statvfs *stbuf) statfs;
	/* S */ public function c_int (c_char* path, fuse_file_info *fi) flush;
	/* S */ public function c_int (c_char* path, fuse_file_info *fi) release;
	/* S */ public function c_int (c_char* path, c_int datasync, fuse_file_info *fi) fsync;
	/* S */ public function c_int (c_char* path, c_char* name, c_char* value, c_size size, c_int flags) setxattr;
	/* S */ public function c_int (c_char* path, c_char* name, c_char *value, c_size size) getxattr;
	/* S */ public function c_int (c_char* path, c_char *namebuf, c_size size) listxattr;
	/* S */ public function c_int (c_char* path, c_char* name) removexattr;
	/* S */ public function c_int (c_char* path, fuse_file_info *fi) opendir;
	/* S */ public function c_int (c_char* path, void *buf, fuse_fill_dir_t filler, fuse_off_t off, fuse_file_info *fi) readdir;
	/* S */ public function c_int (c_char* path, fuse_file_info *fi) releasedir;
	/* S */ public function c_int (c_char* path, c_int datasync, fuse_file_info *fi) fsyncdir;
	/* S */ public function void *(fuse_conn_info *conn) init;
	/* S */ public function void (void *data) destroy;
	/* S */ public function c_int (c_char* path, c_int mask) access;
	/* S */ public function c_int (c_char* path, fuse_mode_t mode, fuse_file_info *fi) create;
	/* S */ public function c_int (c_char* path, fuse_off_t off, fuse_file_info *fi) ftruncate;
	/* S */ public function c_int (c_char* path, fuse_stat *stbuf, fuse_file_info *fi) fgetattr;
	/* _ */ public function c_int (c_char* path, fuse_file_info *fi, c_int cmd, fuse_flock *lock) lock;
	/* S */ public function c_int (c_char* path, fuse_timespec[2] tv) utimens;
	/* _ */ public function c_int (c_char* path, c_size blocksize, uint64 *idx) bmap;
	// /* _ */ unsigned c_int flag_nullpath_ok:1;
	// /* _ */ unsigned c_int flag_nopath:1;
	// /* _ */ unsigned c_int flag_utime_omit_ok:1;
	// /* _ */ unsigned c_int flag_reserved:29;
	[Bitfield<bool>(.Public, .Bits(1), "flag_nullpath_ok", .Read)]
	[Bitfield<bool>(.Public, .Bits(1), "flag_nopath", .Read)]
	[Bitfield<bool>(.Public, .Bits(1), "flag_utime_omit_ok", .Read)]
	c_int _flagsData;
	/* S */ public function c_int (c_char* path, c_int cmd, void *arg, fuse_file_info *fi, c_uint flags, void *data) ioctl;
	/* _ */ public function c_int (c_char* path, fuse_file_info *fi, fuse_pollhandle *ph, c_uint *reventsp) poll;
	/* FUSE 2.9 */
	/* _ */ public function c_int (c_char* path, fuse_bufvec *buf, fuse_off_t off, fuse_file_info *fi) write_buf;
	/* _ */ public function c_int (c_char* path, fuse_bufvec **bufp, c_size size, fuse_off_t off, fuse_file_info *fi) read_buf;
	/* _ */ public function c_int (c_char* path, fuse_file_info *, c_int op) flock;
	/* _ */ public function c_int (c_char* path, c_int mode, fuse_off_t off, fuse_off_t len, fuse_file_info *fi) fallocate;
	/* WinFsp */
	/* S */ public function c_int getpath(c_char* path, c_char *buf, c_size size, fuse_file_info *fi);
	/* OSXFUSE */
	/* _ */ public function c_int () reserved01;
	/* _ */ public function c_int () reserved02;
	/* _ */ public function c_int (c_char* path, fuse_statfs *stbuf) statfs_x;
	/* _ */ public function c_int (c_char* volname) setvolname;
	/* _ */ public function c_int (c_char* oldpath, c_char* newpath, c_ulong flags) exchange;
	/* _ */ public function c_int (c_char* path, fuse_timespec *bkuptime, fuse_timespec *crtime) getxtimes;
	/* _ */ public function c_int (c_char* path, fuse_timespec *tv) setbkuptime;
	/* S */ public function c_int (c_char* path, fuse_timespec *tv) setchgtime;
	/* S */ public function c_int (c_char* path, fuse_timespec *tv) setcrtime;
	/* S */ public function c_int (c_char* path, uint32 flags) chflags;
	/* _ */ public function c_int (c_char* path, fuse_setattr_x *attr) setattr_x;
	/* _ */ public function c_int (c_char* path, fuse_setattr_x *attr, fuse_file_info *fi) fsetattr_x;
}

public struct fuse;

[CRepr]
struct fuse_context
{
    public fuse* fuse;
    public fuse_uid_t uid;
    public fuse_gid_t gid;
    public fuse_pid_t pid;
    public void* private_data;
    public fuse_mode_t umask;
}

public function c_int PFN_fuse_main_real(c_int argc, c_char **argv, fuse_operations *ops, c_size opsize, void *data);
public function c_int PFN_fuse_is_lib_option(c_char *opt);
public function fuse *PFN_fuse_new(fuse_chan *ch, fuse_args *args, fuse_operations *ops, c_size opsize, void *data);
public function void PFN_fuse_destroy(fuse *f);
public function c_int PFN_fuse_loop(fuse *f);
public function c_int PFN_fuse_loop_mt(fuse *f);
public function void PFN_fuse_exit(fuse *f);
public function c_int PFN_fuse_exited(fuse *f);
public function c_int PFN_fuse_notify(fuse *f, c_char *path, uint32 action);
public function fuse_context *PFN_fuse_get_context();
public function c_int PFN_fuse_getgroups(c_int size, fuse_gid_t* list);
public function c_int PFN_fuse_interrupted();
public function c_int PFN_fuse_invalidate(fuse *f, c_char *path);
public function c_int PFN_fuse_notify_poll(fuse_pollhandle *ph);
public function fuse_session *PFN_fuse_get_session(fuse *f);


public static
{
#if FUSE_STATIC
	[CLink]
	public static extern c_int fuse_main_real(c_int argc, c_char **argv, fuse_operations *ops, c_size opsize, void *data);
	[CLink]
	public static extern c_int fuse_is_lib_option(c_char *opt);
	[CLink]
	public static extern fuse *fuse_new(fuse_chan *ch, fuse_args *args, fuse_operations *ops, c_size opsize, void *data);
	[CLink]
	public static extern void fuse_destroy(fuse *f);
	[CLink]
	public static extern c_int fuse_loop(fuse *f);
	[CLink]
	public static extern c_int fuse_loop_mt(fuse *f);
	[CLink]
	public static extern void fuse_exit(fuse *f);
	[CLink]
	public static extern c_int fuse_exited(fuse *f);
	[CLink]
	public static extern c_int fuse_notify(fuse *f, c_char *path, uint32 action);
	[CLink]
	public static extern fuse_context *fuse_get_context();
	[CLink]
	public static extern c_int fuse_getgroups(c_int size, fuse_gid_t* list);
	[CLink]
	public static extern c_int fuse_interrupted();
	[CLink]
	public static extern c_int fuse_invalidate(fuse *f, c_char *path);
	[CLink]
	public static extern c_int fuse_notify_poll(fuse_pollhandle *ph);
	[CLink]
	public static extern fuse_session *fuse_get_session(fuse *f);
#else
	public static PFN_fuse_main_real fuse_main_real;
	public static PFN_fuse_is_lib_option fuse_is_lib_option;
	public static PFN_fuse_new fuse_new;
	public static PFN_fuse_destroy fuse_destroy;
	public static PFN_fuse_loop fuse_loop;
	public static PFN_fuse_loop_mt fuse_loop_mt;
	public static PFN_fuse_exit fuse_exit;
	public static PFN_fuse_exited fuse_exited;
	public static PFN_fuse_notify fuse_notify;
	public static PFN_fuse_get_context fuse_get_context;
	public static PFN_fuse_getgroups fuse_getgroups;
	public static PFN_fuse_interrupted fuse_interrupted;
	public static PFN_fuse_invalidate fuse_invalidate;
	public static PFN_fuse_notify_poll fuse_notify_poll;
	public static PFN_fuse_get_session fuse_get_session;
#endif
	
}
