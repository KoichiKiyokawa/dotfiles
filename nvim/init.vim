" -----------------------------------------------------------------------------
" Basic
" -----------------------------------------------------------------------------
" set file encording to UTF=-8
set fenc=utf-8
" do not make buckup file or swapfile
set nobackup noswapfile
" enable to open another file when edditing
set hidden
" enable mouse
set mouse=a
" yank to clipboard
set clipboard+=unnamed
" open search result in QuickFix
autocmd QuickFixCmdPost *grep* cwindow
" enable to jump HTML tag by %
source $VIMRUNTIME/macros/matchit.vim

" -----------------------------------------------------------------------------
" Appearance
" -----------------------------------------------------------------------------
" show line number
set number
" highlighting line and column
set cursorline cursorcolumn
" enable to move cursor to one more forward to last word of the line
set virtualedit=onemore
" auto indent for programming
set smartindent
" show ) when input (
set showmatch
" autocomplete comand line
set wildmode=list:longest
" show statusline
set laststatus=2

" -----------------------------------------------------------------------------
" Tab
" -----------------------------------------------------------------------------
" visualize tab to ▸-
set list listchars=tab:\▸\-
" set tab to white space
set expandtab
" set Tab to two spaces
set tabstop=2 shiftwidth=2

" -----------------------------------------------------------------------------
" Search
" -----------------------------------------------------------------------------
" search without distincting letter case when searching string is lowercase
set ignorecase
" search with distincting letter case when searching string includes uppercaseh
set smartcase
" incremental search
set incsearch
" return to the beginning when reached the ending
set wrapscan
" highlighte matched words
set hlsearch
" push escape key twice to cancel highlighte matched word
nmap <silent> <Esc><Esc> :nohlsearch<CR><Esc>
" do not move to the next matched word when searching by * key
nnoremap <silent> * *``

" -----------------------------------------------------------------------------
" Avoid yank
" -----------------------------------------------------------------------------
nnoremap c "_c
vnoremap c "_c
nnoremap C "_C
vnoremap C "_C
nnoremap d "_d
vnoremap d "_d
nnoremap D "_D
vnoremap D "_D
vnoremap p "_dP

" -----------------------------------------------------------------------------
" Kepmap
" -----------------------------------------------------------------------------
" m : macro
nnoremap m q
" 0 : move to head of line
noremap 0 ^
" q : move to end of line
noremap q $
" serach selected without moving next matched word
vnoremap * "zy:let @/ = @z<CR>nN
" replace selected
vnoremap # *:%s///cg<Left><Left><Left>
nmap # viw#
" tab moving
nnoremap <C-t> gt
nnoremap <C-g> gT
" move in insert mode
inoremap <C-k> <Up>
inoremap <C-j> <Down>
inoremap <C-b> <Left>
inoremap <C-f> <Right>
inoremap <C-d> <Right><BS>
inoremap jj <Esc>
" F5 : e! command
noremap <F5> :e!<CR>
nnoremap X Vx

" -----------------------------------------------------------------------------
" Plugins
" -----------------------------------------------------------------------------
call plug#begin('~/.local/share/nvim/plugged')

" Syntax checker
Plug 'w0rp/ale'

" statusline plugin
Plug 'itchyny/lightline.vim'

" autocomplete brackets
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
" ignore file setted in .gitignore
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']

" show diff
Plug 'airblade/vim-gitgutter'

" replace all files
Plug 'thinca/vim-qfreplace'

" tree
Plug 'scrooloose/nerdtree'
" show dotfiles in NERDTree
let NERDTreeShowHidden=1
noremap <F6> :NERDTreeFind<CR>

" share NERDTree with other tabs
Plug 'jistr/vim-nerdtree-tabs'
map <C-b> <plug>NERDTreeTabsToggle<CR>

Plug 'Xuyuanp/nerdtree-git-plugin'

" git in vim
Plug 'tpope/vim-fugitive'

Plug 'tomtom/tcomment_vim'

Plug 'vim-scripts/vim-auto-save'
" disable auto save in insert mode to avoid deleting indent
let g:auto_save = 1
let g:auto_save_in_insert_mode = 0

Plug 'neoclide/coc.nvim', { 'branch': 'release' }
map <silent> <F2> <Plug>(coc-rename)

Plug 'Chiel92/vim-autoformat'
noremap <F3> :Autoformat<CR>

" Multi file serach
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
" run go import when file save
let g:go_fmt_command = "goimports"

Plug 'posva/vim-vue', { 'for': ['vue'] }

Plug 'slim-template/vim-slim', { 'for': ['slim'] }

Plug 'leafgarland/typescript-vim', { 'for': ['typescript'] }

Plug 'peitalin/vim-jsx-typescript', { 'for': ['jsx', 'tsx'] }

Plug 'tomasiser/vim-code-dark'

Plug 'ryanoasis/vim-devicons'

call plug#end()

colorscheme codedark

