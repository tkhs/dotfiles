bindkey -e

#autoload -U colors
#colors

autoload -U compinit
compinit

# 予測補完
#autoload predict-on
#predict-on

# エディタ
#autoload zed

#PS1='$ %F{green}'
#preexec(){ print -nP '%f' }

zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z} r:|[-_.]=**'

#
# プロンプト
#
## PROMPT内で変数展開・コマンド置換・算術演算を実行する。
setopt prompt_subst
## PROMPT内で「%」文字から始まる置換機能を有効にする。
#setopt prompt_percent
## コピペしやすいようにコマンド実行後は右プロンプトを消す。
setopt transient_rprompt

case ${UID} in
0)
	PROMPT='%n@%m:%~# '
	PROMPT2="%n@%m:%_# "
	[ -n "${REMOTEHOST}${SSH_CONNECTION}" ] && 
		PROMPT="%{[37m%}${PROMPT}%{[m%}"
	;;
*)
	PROMPT='%n@%m:%~$ '
	PROMPT2='%n@%m:%_$ '
	[ -n "${REMOTEHOST}${SSH_CONNECTION}" ] && 
		PROMPT="%{[37m%}${PROMPT}%{[m%}"
	;;
esac

# cd を入力しなくてもディレクトリに遷移
setopt auto_cd
# cd -[tab]で履歴表示
setopt auto_pushd
# auto_pushdで重複ディレクトリを追加しないように
setopt pushd_ignore_dups

# コマンドのスペルチェック
#setopt correct
# サスペンド中のプロセスと同じコマンド名を実行したらリジューム
#setopt auto_resume
# 補完可能な一覧を表示
setopt auto_list
# 補完候補一覧でファイルの種別を記号で表示（ls -Fと同じ記号）
setopt list_types
# ディレクトリ名の補完で末尾に / を自動付加
setopt auto_param_slash

# 補完キー連打で補完候補を自動補充
setopt auto_menu
# aliasを補完候補に含める
setopt complete_aliases
# --PREFIX=/USRなどの=以降でも補完できる
setopt magic_equal_subst
# コマンド名に / が含まれているときPATHの中のサブディレクトリを探す
setopt path_dirs

# 直前のコマンドと同じ場合は履歴に追加しない
#setopt hist_ignore_dups
# 先頭にスペースがある行は履歴に追加しない
#setopt hist_ignore_space
# 余分な空白は詰める
setopt hist_reduce_blanks

# 補完候補をできるだけ詰めて表示
setopt list_packed
# 数字を数値として解釈してソート
setopt numeric_glob_sort
# 複数のリダイレクトやパイプなど、必要に応じて tee や cat の機能が使われる
setopt multios
# ファイル名の展開でディレクトリにマッチした場合は末尾に / を自動付加
setopt mark_dirs
setopt long_list_jobs

# 補完候補リストの日本語を適正表示
setopt print_eight_bit

# no beep
setopt no_beep
setopt nolistbeep

# 戻り値が 0 以外の場合終了コードを表示する
#setopt print_exit_value

# =COMMANDでCOMMANDのパス名に展開
setopt equals
# FOR, REPEAT, SELECT, IF, FUNCTIONなどで簡略文法が使えるようになる
setopt short_loops

# 履歴
HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=10000

#function cd() {builtin cd $@ && ls -v -F --color=auto}

# cd時に自動ls
#function chpwd() { ls -v -F }

#
# extract http://d.hatena.ne.jp/jeneshicc/20110215/1297778049
#
extract () {
  if [ -f $1 ] ; then
      case $1 in
          *.tar.bz2) tar xvjf $1 ;;
          *.tar.gz) tar xvzf $1 ;;
          *.tar.xz) tar xvJf $1 ;;
          *.bz2) bunzip2 $1 ;;
          *.rar) unrar x $1 ;;
          *.gz) gunzip $1 ;;
          *.tar) tar xvf $1 ;;
          *.tbz2) tar xvjf $1 ;;
          *.tgz) tar xvzf $1 ;;
          *.zip) unzip $1 ;;
          *.Z) uncompress $1 ;;
          *.7z) 7z x $1 ;;
          *.lzma) lzma -dv $1 ;;
          *.xz) xz -dv $1 ;;
          *) echo "don't know how to extract '$1'..." ;;
      esac
  else
      echo "'$1' is not a valid file!"
  fi
}
alias ex='extract'

# http://blog.monoweb.info/article/2011120320.html
# sudo vim
sudo() {
  local args
  case $1 in
    vi|vim)
      args=()
      for arg in $@[2,-1]
      do
        if [ $arg[1] = '-' ]; then
          args[$(( 1+$#args ))]=$arg
        else
          args[$(( 1+$#args ))]="sudo:$arg"
        fi
      done
      command vim $args
      ;;
    *)
      command sudo $@
      ;;
  esac
}

# http://www.commandlinefu.com/commands/view/10889/hourglass
# hourglass 5
hourglass() {
	trap 'tput cnorm' EXIT INT;
	local s=$(($SECONDS +$1));
	(
		tput civis;
		while [[ $SECONDS -lt $s ]];
			do for f in '|' '\' '-' '/';
				do echo -n "$f" && sleep .2s && echo -n $'\b';
			done;
		done;
	);
	tput cnorm;
}

