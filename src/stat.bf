namespace FUSE;

static
{
	public const int S_IFMT = 0xF000; // File type mask
	public const int S_IFDIR = 0x4000; // Directory
	public const int S_IFCHR = 0x2000; // Character special
	public const int S_IFIFO = 0x1000; // Pipe
	public const int S_IFREG = 0x8000; // Regular
	public const int S_IREAD = 0x0100; // Read permission, owner
	public const int S_IWRITE = 0x0080; // Write permission, owner
	public const int S_IEXEC = 0x0040; // Execute/search permission, owner
}