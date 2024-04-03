namespace FUSE;

static
{
	public const int O_ACCMODE = 00000003; 
	public const int O_RDONLY = 00000000; 
	public const int O_WRONLY = 00000001; 
	public const int O_RDWR = 00000002; 
	public const int O_CREAT = 00000100;         /* not fcntl */
	public const int O_EXCL = 00000200;         /* not fcntl */
	public const int O_NOCTTY = 00000400;         /* not fcntl */
	public const int O_TRUNC = 00001000;         /* not fcntl */
	public const int O_APPEND = 00002000; 
	public const int O_NONBLOCK = 00004000; 
	public const int O_SYNC = 00010000; 
	public const int FASYNC = 00020000;         /* fcntl, for BSD compatibility */
	public const int O_DIRECT = 00040000;         /* direct disk access hint */
	public const int O_LARGEFILE = 00100000; 
	public const int O_DIRECTORY = 00200000;         /* must be a directory */
	public const int O_NOFOLLOW = 00400000;         /* don't follow links */
	public const int O_NOATIME = 01000000; 
	public const int O_CLOEXEC = 02000000;         /* set close_on_exec */
	public const int O_NDELAY = O_NONBLOCK; 
	public const int F_DUPFD = 0;         /* dup */
	public const int F_GETFD = 1;         /* get close_on_exec */
	public const int F_SETFD = 2;         /* set/clear close_on_exec */
	public const int F_GETFL = 3;         /* get file->f_flags */
	public const int F_SETFL = 4;         /* set file->f_flags */
	public const int F_GETLK = 5; 
	public const int F_SETLK = 6; 
	public const int F_SETLKW = 7; 
	public const int F_SETOWN = 8;         /* for sockets. */
	public const int F_GETOWN = 9;         /* for sockets. */
	public const int F_SETSIG = 10;         /* for sockets. */
	public const int F_GETSIG = 11;         /* for sockets. */
	public const int F_GETLK64 = 12;         /*  using 'struct flock64' */
	public const int F_SETLK64 = 13; 
	public const int F_SETLKW64 = 14; 
	public const int F_SETOWN_EX = 15; 
	public const int F_GETOWN_EX = 16; 
	public const int F_OWNER_TID = 0;
	public const int F_OWNER_PID = 1; 
	public const int F_OWNER_PGRP = 2; 
	public const int FD_CLOEXEC = 1;         /* actually anything with low bit set goes */
	public const int F_RDLCK = 0; 
	public const int F_WRLCK = 1; 
	public const int F_UNLCK = 2; 
	public const int F_EXLCK = 4;         /* or 3 */
	public const int F_SHLCK = 8;         /* or 4 */
	public const int F_INPROGRESS = 16; 
	public const int LOCK_SH = 1;         /* shared lock */
	public const int LOCK_EX = 2;         /* exclusive lock */
	public const int LOCK_NB = 4; 
	public const int LOCK_UN = 8;         /* remove lock */
	public const int LOCK_MAND = 32;         /* This is a mandatory flock ... */
	public const int LOCK_READ = 64;         /* which allows concurrent read operations */
	public const int LOCK_WRITE = 128;         /* which allows concurrent write operations */
	public const int LOCK_RW = 192;         /* which allows concurrent read & write ops */

}