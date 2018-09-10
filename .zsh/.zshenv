
alias ...='../..'
alias ....='../../..'
alias .....='../../../..'

alias l='la'
alias la='ls -lAvF'
alias ll='ls -l'

alias tl='tmux list-sessions'

case ${OSTYPE} in
	darwin*)
		alias ls='LSCOLORS=gxfxxxxxcxxxxxxxxxxxxx ls -G'
		alias vim='/Applications/MacVim.app/Contents/MacOS/Vim "$@"'
		;;
	linux*)
		alias ls='ls -F --color=auto'
		;;
esac

[ -f $HOME/.zshenv_local ] && source $HOME/.zshenv_local

