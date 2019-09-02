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

export GIT_EDITOR=vim
export PS1=" "'$(__git_ps1 "(%s)")'" \w \$ "
export PATH=~/Rootfs/usr/bin:$PATH
export PATH=~/Rootfs/bin:$PATH
export PATH=$PATH:~/WorkSpace/github/clang/bin
export LD_LIBRARY_PATH=~/Rootfs/usr/lib

path_remove "/opt/xm_toolchain/arm-xm-linux/usr/bin"
path_remove "/opt/GrainMedia_linux/toolchain_gnueabi-4.9.x_CA7/usr/bin"
path_remove "/opt/arm/arm-ca53-linux-uclibcgnueabihf-6.4/usr/bin"

if [[ -z "$TMUX" ]] && [ "$SSH_CONNECTION" != "" ]; then
    tmux attach -t WorkSpace || tmux new -s WorkSpace
fi

stty -ixon
