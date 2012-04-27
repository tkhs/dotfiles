" for macvim-kaoriya http://code.google.com/p/macvim-kaoriya/

set nocompatible " vim の機能を使う
		" 元から入ってるvimなら~/.vimrcがあれば自動で有効になるらしいけど
		" kaoriyaだとそれが無いっぽい

" vundle
filetype off

set rtp+=~/.vim/vundle.git/
call vundle#rc()

" vim-scripts リポジトリ (1)
Bundle "rails.vim"
" github の任意のリポジトリ (2)
Bundle "tpope/vim-fugitive"
" github 以外のリポジトリ (3)
Bundle "git://git.wincent.com/command-t.git"

filetype plugin indent on


" <status line>
set laststatus=2 " 常にステータスラインを表示
set statusline=%<%F\ %r%h%w%y%{'['.(&fenc!=''?&fenc:&enc).'\|'.&ff.']'}\ \ %l/%L\ (%P)%m%=%{strftime(\"%Y/%m/%d\ %H:%M\")}

" <encoding>
set encoding=utf-8
set fileencodings=euc-jp,cp932,iso-2022-jp

" <basic>
syntax on
colorscheme desert
let mapleader = ","            " キーマップリーダー 
set nobackup                   " バックアップ取らない
set hidden                     " 編集中でも他のファイルを開けるようにする
set formatoptions=lmoq         " テキスト整形オプション，マルチバイト系を追加
set vb t_vb=                   " ビープをならさない
set backspace=indent,eol,start " バックスペースでなんでも消せるように
set autoread                   " 他で書き換えられたら自動で読み直す
set whichwrap=b,s,h,l,<,>,[,]  " カーソルを行頭、行末で止まらないようにする
set scrolloff=5                " スクロール時の余白確保
set clipboard+=unnamed

" <display>
set showmatch         " 括弧の対応をハイライト
set number            " 行番号表示
set list              " 不可視文字表示
" 不可視文字の表現設定
set listchars=tab:>-,trail:-
",eol:<

" <indent>
" set expandtab     " tab をスペースに展開
" set shiftwidth=2  " 自動インデントの幅

" <search>
set wrapscan     " 最後まで検索したら先頭へ戻る
set ignorecase   " 大文字小文字無視
set smartcase    " 大文字ではじめたら大文字小文字無視しない
set noincsearch  " インクリメンタルサーチOFF
set hlsearch     " 検索文字をハイライト

" <completion>
set wildmenu           " コマンド補完を強化
set wildmode=list:full " リスト表示，最長マッチ
set history=1000       " コマンド・検索パターンの履歴数

" <keymapping>
" 行単位で移動(1行が長い場合に便利)
nnoremap j gj
nnoremap k gk

" Esc2回押しでハイライト解除
nmap <ESC><ESC> ;nohlsearch<CR><ESC>

map! <C-a> <Home>
map! <C-e> <End>

" nnoremap <Space>. :<C-u>edit $MYVIMRC<CR>
" nnoremap <Space>s. :<C-u>source $MYVIMRC<CR> :<C-u>source $MYGVIMRC<CR>
" nnoremap <Space>w :write<CR>
" nnoremap <Space>d :bd<CR>
" nnoremap <Space>q :q<CR>

" ヘルプ
nnoremap <C-h> :<C-u>help<Space>
nnoremap <C-h><C-h> :<C-u>help<Space><C-r><C-w><CR>

" US配列向け
nnoremap ; :
nnoremap : ;

" yank, paste with os clipboard http://relaxedcolumn.blog8.fc2.com/blog-entry-125.html
noremap <Space>y "+y
noremap <Space>p "+p

inoremap <C-d> <Delete>
inoremap <C-f> <Right>
inoremap <C-b> <Left>
inoremap <C-j> <Down>
inoremap <C-k> <Up>

" 対応するカッコに移動
nnoremap [ %
nnoremap ] %

" Ctrl-hjklでウィンドウ移動
nnoremap <C-h> ;<C-h>j
nnoremap <C-j> ;<C-w>j
nnoremap <C-k> ;<C-k>j
nnoremap <C-l> ;<C-l>j

" F2で前のバッファ
map <F2> <ESC>;bp<CR>
" F3で次のバッファ
map <F3> <ESC>;bn<CR>
" F4でバッファを削除する
map <F4> <ESC>;bw<CR>

" <command>
" insert mode
" \date で日付
inoremap <Leader>date <C-R>=strftime('%Y/%m/%d (%a)')<CR>

" <autocommand>
""augroup BufferAu
""    autocmd!
""    " カレントディレクトリを自動的に移動
""    autocmd BufNewFile,BufRead,BufEnter * if isdirectory(expand("%:p:h")) && bufname("%") !~ "NERD_tree" | cd %:p:h | endif
""augroup END

""augroup Chalow
""  autocmd!
""  autocmd BufWritePost $HOME/var/log/changelog/Changelog silent :!$HOME/bin/chalow
""augroup END

" <plugins>
" BufExplorer
""nnoremap <C-l> :BufExplorer<CR>

" FuzzyFinder
""nnoremap <silent> fb :<C-u>FuzzyFinderBuffer!<CR>
""nnoremap <silent> ff :<C-u>FuzzyFinderFile! <C-r>=expand('%:~:.')[:-1-len(expand('%:~:.:t'))]<CR><CR>
""nnoremap <silent> fm :<C-u>FuzzyFinderMruFile!<CR>
""nnoremap <silent> fc :<C-u>FuzzyFinderMruCmd<CR>

" Vim/Ruby
" http://blog.blueblack.net/item_133
" Rubyのオムニ補完を設定(ft-ruby-omni)
""let g:rubycomplete_buffer_loading = 1
""let g:rubycomplete_classes_in_global = 1
""let g:rubycomplete_rails = 1

" rails.vim
""let g:rails_level = 4
""let g:rails_devalut_database = 'mysql'

" vimwiki
""let g:vimwiki_list = [{'path': '~/var/vimwiki/', 'path_html': '~/Sites/vimwiki/'}]
