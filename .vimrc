set nocompatible " vi互換モードを切る
				" 元から入ってるvimなら~/.vimrcがあれば自動で有効になるらしいけど
				" kaoriyaだとそれが無いっぽい？

" autocmdを初期化
autocmd!

" 環境変数
let s:iswin = has('win32') || has('win64')

" =============================================================================
" for plugin settings
" =============================================================================
" NeoBundle {{{
filetype off

if has('vim_starting')
	set rtp+=~/.vim/neobundle.vim.git
"	set runtimepath+=~/.vim/.neobundle/neobundle.vim
	call neobundle#rc( expand( '~/.vim/.neobundle' ) )
endif

"NeoBundle 'Shougo/neobundle.vim'
NeoBundle 'thinca/vim-localrc'
NeoBundle 'Shougo/vimproc'
"after install, turn shell ~/.vim/bundle/vimproc, (n,g)make -f your_machines_makefile
" $ cd ~/.vim/.neobundle/vimproc
" $ make -f make_mac.mak

" Explore/FileSystem
NeoBundle 'scrooloose/nerdtree'
NeoBundle 'Shougo/vimfiler'
"NeoBundle 'project-1.4.1'
"NeoBundle 'fholgado/minibufexpl.vim'
NeoBundle 'Shougo/vinarise'

"NeoBundle 'Shougo/vim-vcs'
NeoBundle 'vim-scripts/gtags.vim'

" Display
NeoBundle 'sjl/gundo.vim'
"NeoBundle 'buftabs'
NeoBundle 'anekos/char-counter-vim'

" Filetypes
NeoBundle 'vim-ruby/vim-ruby'
if !s:iswin
  NeoBundle 'tpope/vim-rvm'
endif
NeoBundle 'tpope/vim-rails'
NeoBundle 'tpope/vim-rake'
NeoBundle 'tpope/vim-haml'
NeoBundle 'kchmck/vim-coffee-script'
NeoBundle 'othree/html5.vim'
NeoBundle 'JavaScript-syntax'
NeoBundle 'vim-creole'

" css
NeoBundle 'skammer/vim-css-color'
NeoBundle 'hail2u/vim-css3-syntax'
"NeoBundle 'hokaccha/vim-css3-syntax'
NeoBundle 'groenewege/vim-less'

NeoBundle 'cakebaker/scss-syntax.vim'

" Syntax Check
NeoBundle 'scrooloose/syntastic'
NeoBundle 'vim-scripts/javacomplete'

" neocomplcache
NeoBundle "Shougo/neocomplcache"
NeoBundle 'Shougo/neocomplcache-snippets-complete'
NeoBundle 'ujihisa/neco-look'

" unite
NeoBundle "Shougo/unite.vim"
NeoBundle 'ujihisa/unite-colorscheme'
NeoBundle 'ujihisa/unite-font'


NeoBundle "thinca/vim-ref"
NeoBundle 'scrooloose/nerdcommenter'
NeoBundle 'vim-jp/vimdoc-ja'
NeoBundle 'Align'
"NeoBundle 'h1mesuke/vim-alignta'
NeoBundle 'sudo.vim'
NeoBundle 'othree/eregex.vim'
"NeoBundle 'kana/vim-smartchr'
"NeoBundle 'mileszs/ack.vim'

NeoBundle 'thinca/vim-fontzoom'

" colorschemes
"NeoBundle "altercation/vim-colors-solarized"
NeoBundle 'vim-scripts/Lucius'
NeoBundle 'vim-scripts/mrkn256.vim'
"NeoBundle 'jpo/vim-railscasts-theme'
NeoBundle 'vim-scripts/Railscasts-Theme-GUIand256color'

" }}}

" syntastic {{{
	let g:syntastic_mode_map = {
		\  'mode': 'active',
		\ 'active_filetypes': [ 'ruby', 'javascript' ],
		\ 'passive_filetypes': []
		\ }
" }}}

" unite.vim {{{
	"unite prefix key.
"	nnoremap [unite] <Nop>
"	nmap <Space>f [unite]

	" バッファ一覧
"	nnoremap <silent> ,ub :<C-u>Unite buffer<CR>
	nnoremap <silent> <Leader>b :<C-u>Unite buffer<CR>
	" ファイル一覧
	nnoremap <silent> <Leader>f :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
	" レジスタ一覧
	nnoremap <silent> <Leader>r :<C-u>Unite -buffer-name=register register<CR>
	" 最近使用したファイル一覧
	nnoremap <silent> <Leader>m :<C-u>Unite file_mru<CR>
	" 常用セット
	nnoremap <silent> <Leader>u :<C-u>Unite buffer file_mru<CR>
	" 全部乗せ
	nnoremap <silent> <Leader>a :<C-u>UniteWithBufferDir -buffer-name=files buffer file_mru bookmark file<CR>

	"file_mruの表示フォーマットを指定。空にすると表示スピードが高速化される
	let g:unite_source_file_mru_filename_format = ''
" }}}

" vimfiler {{{
	"vimデフォルトのエクスプローラをvimfilerで置き換える
	let g:vimfiler_as_default_explorer = 1
	"セーフモードを無効にした状態で起動する
	let g:vimfiler_safe_mode_by_default = 0
	" カレントディレクトリを自動で同期
	let g:vimfiler_enable_auto_cd = 1

	autocmd! FileType vimfiler call g:my_vimfiler_settings()
	function! g:my_vimfiler_settings()
		nmap     <buffer><S-o>         <Plug>(vimfiler_sync_with_another_vimfiler)
		nmap     <buffer>o             <Plug>(vimfiler_sync_with_another_vimfiler)
		nmap     <buffer><backspace>   <Plug>(vimfiler_switch_to_parent_directory)
		nmap     <buffer><Nul>         <Plug>(vimfiler_toggle_mark_current_line_up)
		nmap     <buffer><Left>        <Plug>(vimfiler_switch_to_other_window)
		nmap     <buffer><Right>       <Plug>(vimfiler_switch_to_other_window)
"		nmap     <buffer><expr><Cr> vimfiler#smart_cursor_map("\<Plug>(vimfiler_expand_tree)", "\<Plug>(vimfiler_edit_file)")
"		nnoremap <buffer>s          :call vimfiler#mappings#do_action('my_split')<Cr>
"		nnoremap <buffer>v          :call vimfiler#mappings#do_action('my_vsplit')<Cr>
	endfunction

	"<Leader>e で現在開いているバッファのディレクトリを開く
	nnoremap <silent> <Leader>fe :<C-u>VimFilerBufferDir<CR>
	nnoremap <silent> <Leader>fi :<C-u>VimFiler -split -simple -winwidth=35 -no-quit<CR>
	

" }}}

" NeoComplcache {{{
	" 補完ウィンドウの設定
	set completeopt=menuone
	" 起動時に有効化
	let g:neocomplcache_enable_at_startup = 1
	" 大文字が入力されるまで大文字小文字の区別を無視する
	let g:neocomplcache_enable_smart_case = 1
	" _(アンダースコア)区切りの補完を有効化
	let g:neocomplcache_enable_underbar_completion = 1
	" ポップアップメニューで表示される候補の数
	let g:neocomplcache_max_list = 20
	" シンタックスをキャッシュするときの最小文字長
	let g:neocomplcache_min_syntax_length = 3
	" 挿入モードのカーソル移動であんまり補完しないように
	let g:NeoComplCache_EnableSkipCompletion = 1
	let g:NeoComplCache_SkipInputTime = '0.5'
	inoremap <expr><Up> pumvisible() ? neocomplcache#close_popup()."\<Up>" : "\<Up>"
	inoremap <expr><Down> pumvisible() ? neocomplcache#close_popup()."\<Down>" : "\<Down>"

	" ディクショナリ定義
	let g:neocomplcache_dictionary_filetype_lists = {
		\ 'default' : '',
		\ 'ruby' : '~/.vim/dict/ruby.dict',
		\ 'nb' : '~/.vim/dict/ruby.dict',
		\ 'c' : '~/.vim/dict/c.dict',
		\ 'cpp' : '~/.vim/dict/cpp.dict',
		\ 'php' : '~/.vim/dict/php.dict',
		\ 'ctp' : '~/.vim/dict/php.dict',
		\ 'javascript' : '~/.vim/dict/javascript.dict',
		\ 'perl' : '~/.vim/dict/perl.dict',
		\ 'java' : '~/.vim/dict/java.dict',
		\ }
	
	if !exists('g:neocomplcache_keyword_patterns')
	        let g:neocomplcache_keyword_patterns = {}
	endif
	let g:neocomplcache_keyword_patterns['default'] = '\h\w*'

	" スニペット
	" 配置場所
	let g:neocomplcache_snippets_dir = '~/.vim/snippets'
	" スニペットを展開する。スニペットが関係しないところでは行末まで削除
	imap <expr><C-k> neocomplcache#sources#snippets_complete#expandable() ? "\<Plug>(neocomplcache_snippets_expand)" : "\<C-o>D"
	smap <expr><C-k> neocomplcache#sources#snippets_complete#expandable() ? "\<Plug>(neocomplcache_snippets_expand)" : "\<C-o>D"

	" TABでスニペットを展開
"	imap  neocomplcache#plugin#snippets_complete#expandable() ? "\(neocomplcache_snippets_expand)" : "\"
"	smap  (neocomplcache_snippets_expand)

	" 前回行われた補完をキャンセルします
	inoremap <expr><C-g> neocomplcache#undo_completion()
	" 補完候補のなかから、共通する部分を補完します
	inoremap <expr><C-l> neocomplcache#complete_common_string()
	" close popup and save indent
	inoremap <expr><CR> pumvisible() ? neocomplcache#close_popup() : "\<CR>"
	" completion
	inoremap <expr><TAB> pumvisible() ? "\<Down>" : "\<TAB>"
	inoremap <expr><S-TAB> pumvisible() ? "\<Up>" : "\<S-TAB>"
	" <C-h>や<BS>を押したときに確実にポップアップを削除します
	inoremap <expr><BS> neocomplcache#smart_close_popup() . "\<C-h>"
	inoremap <expr><C-h> neocomplcache#smart_close_popup() . "\<C-h>"
	" 現在選択している候補を確定します
"	inoremap <expr><C-y> neocomplcache#close_popup()
	" 現在選択している候補をキャンセルし、ポップアップを閉じます
"	inoremap <expr><C-e> neocomplcache#cancel_popup()
" }}}

" Gundo {{{
	nnoremap U :<C-u>GundoToggle<CR>
" }}}

" buftabs {{{
	"バッファタブにパスを省略してファイル名のみ表示する
	let g:buftabs_only_basename=1
	" バッファタブをステータスライン内に表示する
"	let g:buftabs_in_statusline=1
	" 現在のバッファをハイライト
	let g:buftabs_active_highlight_group="Visual"
	" ステータスライン
"	set statusline=%=\ [%{(&fenc!=''?&fenc:&enc)}/%{&ff}]\[%Y]\[%04l,%04v][%p%%]
	" ステータスラインを常に表示
"	set laststatus=2
" }}}

" NERDTree {{{
	"引数なしでvimを開いたらNERDTreeを起動、
	"引数ありならNERDTreeは起動しない、引数で渡されたファイルを開く。
"	autocmd vimenter * if !argc() | NERDTree | endif
	"他のバッファをすべて閉じた時にNERDTreeが開いていたらNERDTreeも一緒に閉じる。
	autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

	nnoremap <silent> <C-e>      :NERDTreeToggle<CR>
	vnoremap <silent> <C-e> <Esc>:NERDTreeToggle<CR>
	onoremap <silent> <C-e>      :NERDTreeToggle<CR>
	inoremap <silent> <C-e> <Esc>:NERDTreeToggle<CR>
	cnoremap <silent> <C-e> <C-u>:NERDTreeToggle<CR>

	"NERDTreeIgnore 無視するファイルを設定する。
	let g:NERDTreeIgnore = ['\.swp$', '\~$']
	"NERDTreeShowHidden 隠しファイルを表示するか？
	let g:NERDTreeShowHidden = 1
	"ブックマークや、ヘルプのショートカットをメニューに表示する。
	let g:NERDTreeMinimalUI = 1
	"NERDTreeを+|`などを使ってツリー表示をする。
	let g:NERDTreeDirArrows = 0

" }}}

" NERDCommenter {{{
	" Nerd_Commenter の基本設定
	let g:NERDCreateDefaultMappings = 0
	let NERDSpaceDelims = 1

	map <C- <Plug>NERDCommenterToggle

	nmap <Leader>/ <Plug>NERDCommenterToggle
	vmap <Leader>/ <Plug>NERDCommenterToggle

"	nmap <Leader>/a <Plug>NERDCommenterAppend
"	nmap <leader>/9 <Plug>NERDCommenterToEOL
"	vmap <Leader>/s <Plug>NERDCommenterSexy
"	vmap <Leader>/b <Plug>NERDCommenterMinimal
" }}}

" Ref.vim {{{
	let g:ref_alc_cmd = 'w3m -dump %s'
" }}}

" smartchr {{{
"	inoremap <buffer> <expr> <S-=> smartchr#loop(' + ', '++')
"	inoremap <buffer> <expr> - smartchr#loop(' - ', '--')
"	inoremap <buffer> <expr> , smartchr#loop(', ', ',,')
" }}}

"
" macros
"
source $VIMRUNTIME/macros/matchit.vim
let b:match_words = "if:endif,foreach:endforeach,\<begin\>:\<end\>"


"
" basic
"
syntax on
colorscheme default
filetype on
filetype plugin on
filetype indent on

" Rubyのタブ幅を2にする。
autocmd FileType ruby setlocal tabstop=2 shiftwidth=2
autocmd FileType eruby setlocal tabstop=2 shiftwidth=2

"let mapleader = ','
"let mapleader = '\'

set nobackup                   " バックアップ取らない
set hidden                     " 編集中でも他のファイルを開けるようにする
set formatoptions=lmoq         " テキスト整形オプション，マルチバイト系を追加
set formatoptions+=mM          " 日本語の行を連結時には空白を入力しない
set vb t_vb=                   " ビープをならさない
set backspace=indent,eol,start " バックスペースでなんでも消せるように
set autoread                   " 他で書き換えられたら自動で読み直す
set whichwrap=b,s,h,l,<,>,[,]  " カーソルを行頭、行末で止まらないようにする
set scrolloff=5                " スクロール時の余白確保
"set clipboard & clipboard+=unnamed
set clipboard+=unnamed
set matchpairs=(:),{:},[:],<:> " %で移動できる対応括弧


" https://github.com/amothic/dotfiles/blob/master/.vimrc
" キーコードはすぐにタイムアウトし、マッピングはタイムアウトしない
set notimeout ttimeout ttimeoutlen=200

" 全角記号が、半角幅で表示されるのを防ぐ
if exists('&ambiwidth')
	set ambiwidth=double
endif

" http://vim-users.jp/2009/06/hack32/
set directory-=.
" http://vim-users.jp/2010/07/hack162/
if has('persistent_undo')
  set undodir=~/.vimundo
  augroup vimrc-undofile
    autocmd!
    autocmd BufReadPre ~/* setlocal undofile
  augroup END
endif


"
" statusline
"
set cmdheight=2 " コマンド行の高さ
set laststatus=2 " 常にステータスラインを表示

" ステータスラインに日時を表示する
function! g:Date()
	return strftime("%x %H:%M")
endfunction

set statusline=%<%F\ %r%h%w%y%{'['.(&fenc!=''?&fenc:&enc).'\|'.&ff.']'}\ \ %v,%l/%L\ (%P)\ %{b:charCounterCount}%m%=%{g:Date()}
" 確認用
"set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [ASCII=\%03.3b]\ [HEX=\%02.2B]\ [POS=%04l,%04v][%p%%]\ [LEN=%L]


"
" encoding
"
set encoding=utf-8
set termencoding=utf-8
set fileencodings=ucs-bom,euc-jp,cp932,iso-2022-jp
set fileformats=unix,dos,mac


"
" display
"
"set display+=lastline " 画面最後の行をできる限り表示する
set showmatch         " 括弧の対応をハイライト
set matchtime=1       " 括弧の始めを表示する時間
set number            " 行番号表示
set list              " 不可視文字表示
set listchars=tab:>-,trail:- " 不可視文字の表現設定
"set listchars=tab:>-,trail:-,eol:<


"
" indent
"
set shiftwidth=4  " 自動インデントの幅
set tabstop=4     " タブ幅


"
" search
"
set wrapscan     " 最後まで検索したら先頭へ戻る
set ignorecase   " 大文字小文字無視
set smartcase    " 大文字ではじめたら大文字小文字無視しない
set noincsearch  " インクリメンタルサーチOFF
set hlsearch     " 検索文字をハイライト


"
" complement
"
set wildmenu           " コマンド補完を強化
set wildmode=list:full " リスト表示，最長マッチ
set history=100        " コマンド・検索パターンの履歴数


"
" keymap
"
" 行単位で移動(1行が長い場合に便利)
nnoremap j gj
nnoremap k gk
" Esc2回押しでハイライト解除
nmap <ESC><ESC> ;nohlsearch<CR><ESC>

"バッファ切り替え
noremap <silent> <Space> :bnext<CR>
"noremap <silent> <S-Space> :bprev<CR>
noremap <silent> <Tab> :bprev<CR>

" 行頭,行末移動
"map! <C-a> <Home>
"map! <C-e> <End>

"inoremap <S-CR> <End>
"map! <S-Return> <End>

" ヘルプ
nnoremap <C-h> :<C-u>help<Space>
nnoremap <C-h><C-h> :<C-u>help<Space><C-r><C-w><CR>

" US配列向け
nnoremap ; :
nnoremap : ;

" yank, paste with os clipboard http://relaxedcolumn.blog8.fc2.com/blog-entry-125.html
"noremap <Space>y "+y
"noremap <Space>p "+p

" 括弧の自動補完
"inoremap { {}<LEFT>
"inoremap [ []<LEFT>
"inoremap ( ()<LEFT>
"inoremap " ""<LEFT>
"inoremap ' ''<LEFT>
"vnoremap { "zdi^V{<C-R>z}<ESC>
"vnoremap [ "zdi^V[<C-R>z]<ESC>
"vnoremap ( "zdi^V(<C-R>z)<ESC>
"vnoremap " "zdi^V"<C-R>z^V"<ESC>
"vnoremap ' "zdi'<C-R>z'<ESC>

" 対応するカッコに移動
"nnoremap [ %
"nnoremap ] %

" Ctrl-hjklでウィンドウ移動
nnoremap <C-h> ;<C-h>j
nnoremap <C-j> ;<C-w>j
nnoremap <C-k> ;<C-k>j
nnoremap <C-l> ;<C-l>j

" F2で前のバッファ
"map <F2> <ESC>;bp<CR>
" F3で次のバッファ
"map <F3> <ESC>;bn<CR>
" F4でバッファを削除する
"map <F4> <ESC>;bw<CR>


" <command>
" 文字エンコーディングを指定して、ファイルを開く
command! Cp932 edit ++enc=cp932
command! Eucjp edit ++enc=euc-jp
command! Iso2022jp edit ++enc=iso-2022-jp
command! Utf8 edit ++enc=utf-8

command! Jis Iso2022jp
command! Sjis Cp932

" insert mode
" \date で日付
"inoremap <Leader>date <C-R>=strftime('%Y/%m/%d (%a)')<CR>

" https://github.com/ujihisa/config/blob/master/_vimrc
command! SplitNicely call s:split_nicely() " {{{
function! s:split_nicely()
  if 80*2 * 15/16 <= winwidth(0) " FIXME: threshold customization
    vsplit
  else
    split
  endif
endfunction
" }}}

