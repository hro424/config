export CONCURRENCY_LEVEL=8
export EDITOR=/usr/bin/vim
export MINICOM='-c on'
export GDK_NATIVE_WINDOWS=1
ALTERA=/opt/altera
export PATH=$PATH

#
# ArchLinux Specific
#
config=/usr/share/doc/pkgfile/command-not-found.zsh
if [ -r $config ]; then
	. $config
fi
