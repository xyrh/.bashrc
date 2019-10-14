if [ -f /etc/bash.bashrc ];then
. /etc/bash.bashrc
fi

if [ "$TERM" == "xterm" ] || [ "$TERM" == "xterm-256color" ]; then
	export TERMINFO=/usr/share/terminfo
	export TERM=xterm-256color
fi

path_append ()  { path_remove $1; export PATH="$PATH:$1"; }
path_prepend () { path_remove $1; export PATH="$1:$PATH"; }
path_remove ()  { export PATH=`echo -n $PATH | awk -v RS=: -v ORS=: '$0 != "'$1'"' | sed 's/:$//'`; }

alias grep='grep --color=auto'
alias life='cat ~/.bash_history | sort | uniq -c | sort -rn | head -n 10'
alias bp='find . -type f -name "*.[chsS]" | sort | uniq  > project.files'
alias bb='cat project.files | gtags -f -'
alias vi='vim'
alias vl='echo $VIM'
alias em='emacs'
alias rm='rm -i'
alias rr='rm -rf'
alias ls='ls --color'
alias zf='z -I'
alias zb='z -b'

eval "$(lua ~/WorkSpace/github/z.lua/z.lua --init bash enhanced once fzf)"

export FZF_DEFAULT_COMMAND="rg --files --hidden --glob !.svn --glob !.git"
export GIT_EDITOR=vim

if [ -z "${VIM}" ];then
	export PS1="\[\033[01;31m\]"'$(__git_ps1 "(%s)")'"\[\033[00m\] \[\033[01;33m\]\w\[\033[00m\] \[\033[01;32m\]ღ\[\033[00m\] "
else
	export PS1="\[\033[01;31m\]"'$(__git_ps1 "(%s)")'"\[\033[00m\] \[\033[01;33m\]\w\[\033[00m\] \[\033[01;31m\]ღ\[\033[00m\] "
fi

export LD_LIBRARY_PATH=~/Rootfs/usr/lib

path_remove "/opt/xm_toolchain/arm-xm-linux/usr/bin"
path_remove "/opt/GrainMedia_linux/toolchain_gnueabi-4.9.x_CA7/usr/bin"
path_remove "/opt/arm/arm-ca53-linux-uclibcgnueabihf-6.4/usr/bin"

if [[ -z "$TMUX" ]];then
	export PATH="/home/${LOGNAME}/Rootfs/usr/bin":$PATH
	export PATH="/home/${LOGNAME}/Rootfs/bin":$PATH
	export PATH=$PATH:"/home/${LOGNAME}/WorkSpace/github/clang/bin"
fi

if [[ -z "$TMUX" ]] && [ "$SSH_CONNECTION" != "" ]; then
    tmux attach -t WorkSpace || tmux new -s WorkSpace
fi

stty -ixon

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
