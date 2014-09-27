export CONCURRENCY_LEVEL=8
export EDITOR=/usr/bin/vim
export MINICOM='-c on'
export GREP_OPTIONS="--color --exclude-dir=.svn --exclude-dir=.git"
export GDK_NATIVE_WINDOWS=1

#
# ArchLinux Specific
#
config=/usr/share/doc/pkgfile/command-not-found.zsh
if [ -r $config ]; then
	. $config
fi
