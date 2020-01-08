runtime! bundles/dein/dein.vim

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
vmap # *:%s///cg<Left><Left><Left>
nmap # viw#
" タブの移動
nnoremap t1 1gt
nnoremap t2 2gt
nnoremap t3 3gt
nnoremap t4 4gt
nnoremap t5 5gt
nnoremap t6 6gt
nnoremap t7 7gt
nnoremap t8 8gt
nnoremap t9 9gt


inoremap <C-b> <Left>
inoremap <C-f> <Right>
inoremap <C-d> <Right><BS>
inoremap <C-q> <Esc>

