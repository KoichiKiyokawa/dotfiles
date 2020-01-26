" ----------------------------------------------------------------------
" 基本設定
" ----------------------------------------------------------------------
"文字コードをUFT-8に設定
set fenc=utf-8
" バックアップファイルを作らない
set nobackup
" スワップファイルを作らない
set noswapfile
" 編集中のファイルが変更されたら自動で読み直す
set autoread
" バッファが編集中でもその他のファイルを開けるように
set hidden
" 入力中のコマンドをステータスに表示する
set showcmd
" マウスを有効にする
set mouse=a
" クリップボードにヤンク
set clipboard+=unnamed
" 検索結果をQuickFixで開くようにする
autocmd QuickFixCmdPost *grep* cwindow
" 対応するHTMLタグに%でジャンプできるようにする
source $VIMRUNTIME/macros/matchit.vim

" ----------------------------------------------------------------------
" 見た目系
" ----------------------------------------------------------------------
" 行番号を表示
set number
" 現在の行を強調表示
set cursorline
" 現在の行を強調表示（縦）
set cursorcolumn
" 行末の1文字先までカーソルを移動できるように
set virtualedit=onemore
" インデントはスマートインデント
set smartindent
" ビープ音を可視化
set visualbell
" 括弧入力時の対応する括弧を表示
set showmatch
" ステータスラインを常に表示
set laststatus=2
" コマンドラインの補完
set wildmode=list:longest
" ターミナルの色設定
set termguicolors
" 折り返し時に表示行単位での移動できるようにする
nnoremap j gj
nnoremap k gk
" シンタックスハイライトの有効化
syntax enable
" Statusline
set laststatus=2

" ----------------------------------------------------------------------
" Tab系
" ----------------------------------------------------------------------
" 不可視文字を可視化(タブが「▸-」と表示される)
set list listchars=tab:\▸\-
" Tab文字を半角スペースにする
set expandtab
" 行頭以外のTab文字の表示幅（スペースいくつ分）
set tabstop=2
" 行頭でのTab文字の表示幅
set shiftwidth=2

" ----------------------------------------------------------------------
" 検索系
" ----------------------------------------------------------------------
" 検索文字列が小文字の場合は大文字小文字を区別なく検索する
set ignorecase
" 検索文字列に大文字が含まれている場合は区別して検索する
set smartcase
" 検索文字列入力時に順次対象文字列にヒットさせる
set incsearch
" 検索時に最後まで行ったら最初に戻る
set wrapscan
" 検索語をハイライト表示
set hlsearch
" ESC連打でハイライト解除
nmap <Esc><Esc> :nohlsearch<CR><Esc>
" *で単語検索したときに、次の単語にジャンプせずにとどまる
nnoremap <silent> * *``

" ----------------------------------------------------------------------
"  特定条件でヤンクしないように
" ----------------------------------------------------------------------
nnoremap c "_c
vnoremap c "_c
nnoremap C "_C
vnoremap C "_C
nnoremap d "_d
vnoremap d "_d
nnoremap D "_D
vnoremap D "_D
vnoremap p "_dP

" ----------------------------------------------------------------------
" キーバインド
" ----------------------------------------------------------------------
" mでマクロ
nnoremap m q
" 0で行頭
noremap 0 ^
" qで行末
noremap q $
" 選択範囲を検索し、その単語にとどまる
vnoremap * "zy:let @/ = @z<CR>nN
" 選択範囲を置換
vnoremap # *:%s///cg<Left><Left><Left>
nmap # viw#
" タブの移動
nnoremap <C-t> gt
nnoremap <C-g> gT

inoremap <C-b> <Left>
inoremap <C-f> <Right>
inoremap <C-d> <Right><BS>
inoremap jj <Esc>

" ----------------------------------------------------------------------
" プラグイン
" ----------------------------------------------------------------------
call plug#begin('~/.local/share/nvim/plugged')

" Syntax checker
Plug 'w0rp/ale'

" statusline plugin
Plug 'itchyny/lightline.vim'

" カッコの補完
Plug 'cohama/lexima.vim'

Plug 'tpope/vim-surround'
vmap ' S'
vmap " S"
vmap ` S`
vmap ( S)
vmap { S}
vmap [ S]

" open file by filename
Plug 'ctrlpvim/ctrlp.vim'
" .gitignoreに設定されているファイルは無視する
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']

" show diff
Plug 'airblade/vim-gitgutter'

" replace all files
Plug 'thinca/vim-qfreplace'

" tree
Plug 'scrooloose/nerdtree'
" NERDTreeでdotfilesを表示
let NERDTreeShowHidden=1
noremap <F6> :NERDTreeFind<CR>

" NERDTreeをタブ間で共有
Plug 'jistr/vim-nerdtree-tabs'
map <C-b> <plug>NERDTreeTabsToggle<CR>

" git in vim
Plug 'tpope/vim-fugitive'

Plug 'tomtom/tcomment_vim'

" オートセーブ
Plug 'vim-scripts/vim-auto-save'
" インサートモードでは自動保存しない(インデントが消されてしまうため)
let g:auto_save = 1
let g:auto_save_in_insert_mode = 0

Plug 'neoclide/coc.nvim', { 'branch': 'release' }
map <silent> <F2> <Plug>(coc-rename)

Plug 'Chiel92/vim-autoformat'
noremap <F3> :Autoformat<CR>

Plug 'rking/ag.vim'

Plug 'rhysd/conflict-marker.vim'

Plug 'terryma/vim-multiple-cursors'

" move line
Plug 'matze/vim-move'
let g:move_key_modifier = 'C'

Plug 'easymotion/vim-easymotion'
nmap s <Plug>(easymotion-s2)

Plug 'mattn/emmet-vim', { 'for': ['html', 'vue', 'jsx', 'tsx'] }

Plug 'tpope/vim-endwise', { 'for': ['ruby'] }

Plug 'fatih/vim-go', { 'for': ['go'] }
" 保存時にgo importを走らせる
let g:go_fmt_command = "goimports"

Plug 'posva/vim-vue', { 'for': ['vue'] }

Plug 'slim-template/vim-slim', { 'for': ['slim'] }

Plug 'leafgarland/typescript-vim', { 'for': ['typescript'] }

Plug 'peitalin/vim-jsx-typescript', { 'for': ['jsx', 'tsx'] }

Plug 'tomasiser/vim-code-dark'

call plug#end()

colorscheme codedark

