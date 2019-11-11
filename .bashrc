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
alias bp='rg --files -tasm -tc -tcpp | sort | uniq  > project.files'
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

export FZF_DEFAULT_COMMAND='fd --type file'
export FZF_DEFAULT_OPTS="--layout=reverse --inline-info"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export GIT_EDITOR=vim
export LD_LIBRARY_PATH=~/Rootfs/usr/lib
export PS1="\[\033[01;31m\]"'$(__git_ps1 "(%s)")'"\[\033[00m\] \[\033[01;33m\]\w\[\033[00m\] \$ "

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
