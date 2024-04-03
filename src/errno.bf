// C Error Codes in Linux
namespace FUSE;

static
{
	/* Operation not permitted */
	public const int EPERM = 1;
	/* No such file or directory */
	public const int ENOENT = 2;
	/* No such process */
	public const int ESRCH = 3;
	/* Interrupted system call */
	public const int EINTR = 4;
	/* I/O error */
	public const int EIO = 5;
	/* No such device or address */
	public const int ENXIO = 6;
	/* Argument list too long */
	public const int E2BIG = 7;
	/* Exec format error */
	public const int ENOEXEC = 8;
	/* Bad file number */
	public const int EBADF = 9;
	/* No child processes */
	public const int ECHILD = 10;
	/* Try again */
	public const int EAGAIN = 11;
	/* Out of memory */
	public const int ENOMEM = 12;
	/* Permission denied */
	public const int EACCES = 13;
	/* Bad address */
	public const int EFAULT = 14;
	/* Block device required */
	public const int ENOTBLK = 15;
	/* Device or resource busy */
	public const int EBUSY = 16;
	/* File exists */
	public const int EEXIST = 17;
	/* Cross-device link */
	public const int EXDEV = 18;
	/* No such device */
	public const int ENODEV = 19;
	/* Not a directory */
	public const int ENOTDIR = 20;
	/* Is a directory */
	public const int EISDIR = 21;
	/* Invalid argument */
	public const int EINVAL = 22;
	/* File table overflow */
	public const int ENFILE = 23;
	/* Too many open files */
	public const int EMFILE = 24;
	/* Not a typewriter */
	public const int ENOTTY = 25;
	/* Text file busy */
	public const int ETXTBSY = 26;
	/* File too large */
	public const int EFBIG = 27;
	/* No space left on device */
	public const int ENOSPC = 28;
	/* Illegal seek */
	public const int ESPIPE = 29;
	/* Read-only file system */
	public const int EROFS = 30;
	/* Too many links */
	public const int EMLINK = 31;
	/* Broken pipe */
	public const int EPIPE = 32;
	/* Math argument out of domain of func */
	public const int EDOM = 33;
	/* Math result not representable */
	public const int ERANGE = 34;
	/* Resource deadlock would occur */
	public const int EDEADLK = 35;
	/* File name too long */
	public const int ENAMETOOLONG = 36;
	/* No record locks available */
	public const int ENOLCK = 37;
	/* Function not implemented */
	public const int ENOSYS = 38;
	/* Directory not empty */
	public const int ENOTEMPTY = 39;
	/* Too many symbolic links encountered */
	public const int ELOOP = 40;
	/* No message of desired type */
	public const int ENOMSG = 42;
	/* Identifier removed */
	public const int EIDRM = 43;
	/* Channel number out of range */
	public const int ECHRNG = 44;
	/* Level 2 not synchronized */
	public const int EL2NSYNC = 45;
	/* Level 3 halted */
	public const int EL3HLT = 46;
	/* Level 3 reset */
	public const int EL3RST = 47;
	/* Link number out of range */
	public const int ELNRNG = 48;
	/* Protocol driver not attached */
	public const int EUNATCH = 49;
	/* No CSI structure available */
	public const int ENOCSI = 50;
	/* Level 2 halted */
	public const int EL2HLT = 51;
	/* Invalid exchange */
	public const int EBADE = 52;
	/* Invalid request descriptor */
	public const int EBADR = 53;
	/* Exchange full */
	public const int EXFULL = 54;
	/* No anode */
	public const int ENOANO = 55;
	/* Invalid request code */
	public const int EBADRQC = 56;
	/* Invalid slot */
	public const int EBADSLT = 57;
	/* Bad font file format */
	public const int EBFONT = 59;
	/* Device not a stream */
	public const int ENOSTR = 60;
	/* No data available */
	public const int ENODATA = 61;
	/* Timer expired */
	public const int ETIME = 62;
	/* Out of streams resources */
	public const int ENOSR = 63;
	/* Machine is not on the network */
	public const int ENONET = 64;
	/* Package not installed */
	public const int ENOPKG = 65;
	/* Object is remote */
	public const int EREMOTE = 66;
	/* Link has been severed */
	public const int ENOLINK = 67;
	/* Advertise error */
	public const int EADV = 68;
	/* Srmount error */
	public const int ESRMNT = 69;
	/* Communication error on send */
	public const int ECOMM = 70;
	/* Protocol error */
	public const int EPROTO = 71;
	/* Multihop attempted */
	public const int EMULTIHOP = 72;
	/* RFS specific error */
	public const int EDOTDOT = 73;
	/* Not a data message */
	public const int EBADMSG = 74;
	/* Value too large for defined data type */
	public const int EOVERFLOW = 75;
	/* Name not unique on network */
	public const int ENOTUNIQ = 76;
	/* File descriptor in bad state */
	public const int EBADFD = 77;
	/* Remote address changed */
	public const int EREMCHG = 78;
	/* Can not access a needed shared library */
	public const int ELIBACC = 79;
	/* Accessing a corrupted shared library */
	public const int ELIBBAD = 80;
	/* .lib section in a.out corrupted */
	public const int ELIBSCN = 81;
	/* Attempting to link in too many shared libraries */
	public const int ELIBMAX = 82;
	/* Cannot exec a shared library directly */
	public const int ELIBEXEC = 83;
	/* Illegal byte sequence */
	public const int EILSEQ = 84;
	/* Interrupted system call should be restarted */
	public const int ERESTART = 85;
	/* Streams pipe error */
	public const int ESTRPIPE = 86;
	/* Too many users */
	public const int EUSERS = 87;
	/* Socket operation on non-socket */
	public const int ENOTSOCK = 88;
	/* Destination address required */
	public const int EDESTADDRREQ = 89;
	/* Message too long */
	public const int EMSGSIZE = 90;
	/* Protocol wrong type for socket */
	public const int EPROTOTYPE = 91;
	/* Protocol not available */
	public const int ENOPROTOOPT = 92;
	/* Protocol not supported */
	public const int EPROTONOSUPPORT = 93;
	/* Socket type not supported */
	public const int ESOCKTNOSUPPORT = 94;
	/* Operation not supported on transport endpoint */
	public const int EOPNOTSUPP = 95;
	/* Protocol family not supported */
	public const int EPFNOSUPPORT = 96;
	/* Address family not supported by protocol */
	public const int EAFNOSUPPORT = 97;
	/* Address already in use */
	public const int EADDRINUSE = 98;
	/* Cannot assign requested address */
	public const int EADDRNOTAVAIL = 99;
	/* Network is down */
	public const int ENETDOWN = 100;
	/* Network is unreachable */
	public const int ENETUNREACH = 101;
	/* Network dropped connection because of reset */
	public const int ENETRESET = 102;
	/* Software caused connection abort */
	public const int ECONNABORTED = 103;
	/* Connection reset by peer */
	public const int ECONNRESET = 104;
	/* No buffer space available */
	public const int ENOBUFS = 105;
	/* Transport endpoint is already connected */
	public const int EISCONN = 106;
	/* Transport endpoint is not connected */
	public const int ENOTCONN = 107;
	/* Cannot send after transport endpoint shutdown */
	public const int ESHUTDOWN = 108;
	/* Too many references: cannot splice */
	public const int ETOOMANYREFS = 109;
	/* Connection timed out */
	public const int ETIMEDOUT = 110;
	/* Connection refused */
	public const int ECONNREFUSED = 111;
	/* Host is down */
	public const int EHOSTDOWN = 112;
	/* No route to host */
	public const int EHOSTUNREACH = 113;
	/* Operation already in progress */
	public const int EALREADY = 114;
	/* Operation now in progress */
	public const int EINPROGRESS = 115;
	/* Stale NFS file handle */
	public const int ESTALE = 116;
	/* Structure needs cleaning */
	public const int EUCLEAN = 117;
	/* Not a XENIX named type file */
	public const int ENOTNAM = 118;
	/* No XENIX semaphores available */
	public const int ENAVAIL = 119;
	/* Is a named type file */
	public const int EISNAM = 120;
	/* Remote I/O error */
	public const int EREMOTEIO = 121;
	/* Quota exceeded */
	public const int EDQUOT = 122;
	/* No medium found */
	public const int ENOMEDIUM = 123;
	/* Wrong medium type */
	public const int EMEDIUMTYPE = 124;
	/* Operation Canceled */
	public const int ECANCELED = 125;
	/* Required key not available */
	public const int ENOKEY = 126;
	/* Key has expired */
	public const int EKEYEXPIRED = 127;
	/* Key has been revoked */
	public const int EKEYREVOKED = 128;
	/* Key was rejected by service */
	public const int EKEYREJECTED = 129;
	/* Owner died */
	public const int EOWNERDEAD = 130;
	/* State not recoverable */
	public const int ENOTRECOVERABLE = 131;

}