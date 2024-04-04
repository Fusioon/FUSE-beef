using System;
using System.Interop;

namespace FUSE.fuse;

public static
{
	public const int FUSE_OPT_KEY_OPT = -1;
	public const int FUSE_OPT_KEY_NONOPT = -2;
	public const int FUSE_OPT_KEY_KEEP = -3;
	public const int FUSE_OPT_KEY_DISCARD = -4;
}

[CRepr]
struct fuse_opt
{
	public c_char* templ;
	public c_uint offset;
	public c_int value;
}

[CRepr]
struct fuse_args
{
	public c_int argc;
	public c_char** argv;
	public c_int allocated;
}


public function c_int fuse_opt_proc_t(void* data, c_char* args, c_int key, fuse_args* outargs);

public function c_int PFN_fuse_opt_parse(fuse_args* args, void* data, fuse_opt* opts, fuse_opt_proc_t proc);
public function c_int PFN_fuse_opt_add_arg(fuse_args* args, c_char* arg);
public function c_int PFN_fuse_opt_insert_arg(fuse_args* args, c_int pos, c_char* arg);
public function void PFN_fuse_opt_free_args(fuse_args* args);
public function c_int PFN_fuse_opt_add_opt(c_char** opts, c_char* opt);
public function c_int PFN_fuse_opt_add_opt_escaped(c_char** opts, c_char* opt);
public function c_int PFN_fuse_opt_match(fuse_opt* opts, c_char* opt);

public static
{
#if FUSE_STATIC

	[CLink] 
	public static extern c_int fuse_opt_parse(fuse_args* args, void* data, fuse_opt* opts, fuse_opt_proc_t proc);
	[CLink] 
	public static extern c_int fuse_opt_add_arg(fuse_args* args, c_char* arg);
	[CLink] 
	public static extern c_int fuse_opt_insert_arg(fuse_args* args, c_int pos, c_char* arg);
	[CLink] 
	public static extern void fuse_opt_free_args(fuse_args* args);
	[CLink] 
	public static extern c_int fuse_opt_add_opt(c_char** opts, c_char* opt);
	[CLink] 
	public static extern c_int fuse_opt_add_opt_escaped(c_char** opts, c_char* opt);
	[CLink] 
	public static extern c_int fuse_opt_match(fuse_opt* opts, c_char* opt);
#else
	public static PFN_fuse_opt_parse fuse_opt_parse;
	public static PFN_fuse_opt_add_arg fuse_opt_add_arg;
	public static PFN_fuse_opt_insert_arg fuse_opt_insert_arg;
	public static PFN_fuse_opt_free_args fuse_opt_free_args;
	public static PFN_fuse_opt_add_opt fuse_opt_add_opt;
	public static PFN_fuse_opt_add_opt_escaped fuse_opt_add_opt_escaped;
	public static PFN_fuse_opt_match fuse_opt_match;
#endif

}
