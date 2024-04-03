using System;
using System.Interop;

namespace FUSE.fuse;

[CRepr]
struct fsp_fuse_env
{
	public c_uint environment;
	public function void* (c_size) memalloc;
	public function void (void*) memfree;
	public function c_int (c_int) daemonize;
	public function c_int (void*) set_signal_handlers;
	public function c_char* (c_char*) conv_to_win_path;
	public function fuse_pid_t (uint32) winpid_to_pid;
	public function void ()[2] reserved;
}

