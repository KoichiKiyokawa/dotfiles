" -----------------------------------------------------------------------------
" Basic
" -----------------------------------------------------------------------------
set fenc=utf-8 " set file encording to UTF=-8
set nobackup noswapfile " do not make buckup file or swapfile
set hidden " enable to open another file when edditing
set mouse=a " enable mouse
set clipboard+=unnamed " yank to clipboard
autocmd QuickFixCmdPost *grep* cwindow " open search result in QuickFix
source $VIMRUNTIME/macros/matchit.vim " enable to jump HTML tag by %

" -----------------------------------------------------------------------------
" Appearance
" -----------------------------------------------------------------------------
set number " show line number
set cursorline cursorcolumn " highlighting line and column
set virtualedit=onemore " enable to move cursor to one more forward to last word of the line
set smartindent " auto indent for programming
set showmatch " show ) when input (
set wildmode=list:longest " autocomplete comand line
set laststatus=2 " show statusline

" -----------------------------------------------------------------------------
" Tab
" -----------------------------------------------------------------------------
set list listchars=tab:\▸\- " visualize tab to ▸-
set expandtab " set tab to white space
set tabstop=2 shiftwidth=2 " set Tab to two spaces

" -----------------------------------------------------------------------------
" Search
" -----------------------------------------------------------------------------
set ignorecase " search without distincting letter case when searching string is lowercase
set smartcase " search with distincting letter case when searching string includes uppercaseh
set incsearch " incremental search
set wrapscan " return to the beginning when reached the ending
set hlsearch " highlighte matched words

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
" moves in insert mode
inoremap <C-k> <Up>
inoremap <C-j> <Down>
inoremap <C-b> <Left>
inoremap <C-f> <Right>
inoremap <C-d> <Right><BS>
inoremap jj <Esc>
" F5 : e! command
noremap <F5> :e!<CR>
nnoremap X Vx
" push escape key twice to cancel highlighte matched word
nmap <silent> <Esc><Esc> :nohlsearch<CR><Esc> 
" do not move to the next matched word when searching by * key
nnoremap <silent> * *`` 

" -----------------------------------------------------------------------------
" Plugins
" -----------------------------------------------------------------------------
call plug#begin('~/.local/share/nvim/plugged')

Plug 'tomasiser/vim-code-dark' " color scheme

Plug 'w0rp/ale' " Syntax checker

Plug 'itchyny/lightline.vim' " statusline plugin

Plug 'cohama/lexima.vim' " autocomplete brackets

Plug 'tpope/vim-surround'
vmap ' S'
vmap " S"
vmap ` S`
vmap ( S)
vmap { S}
vmap [ S]

Plug 'ctrlpvim/ctrlp.vim' " open file by filename
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard'] " ignore file setted in .gitignore

Plug 'airblade/vim-gitgutter' " show diff

Plug 'thinca/vim-qfreplace' " replace all files

Plug 'scrooloose/nerdtree' " tree
let NERDTreeShowHidden=1 " show dotfiles in NERDTree
noremap <F6> :NERDTreeFind<CR>

Plug 'jistr/vim-nerdtree-tabs' " share NERDTree with other tabs
map <C-b> <plug>NERDTreeTabsToggle<CR>

Plug 'Xuyuanp/nerdtree-git-plugin'

Plug 'tpope/vim-fugitive' " git in vim

Plug 'tomtom/tcomment_vim'

Plug 'vim-scripts/vim-auto-save'
let g:auto_save = 1 
let g:auto_save_in_insert_mode = 0 " disable auto save in insert mode to avoid deleting indent

Plug 'neoclide/coc.nvim', { 'branch': 'release' }
map <silent> <F2> <Plug>(coc-rename)

Plug 'Chiel92/vim-autoformat'
noremap <F3> :Autoformat<CR>

Plug 'rking/ag.vim' " Multi file serach

Plug 'rhysd/conflict-marker.vim'

Plug 'terryma/vim-multiple-cursors'

Plug 'matze/vim-move' " move line
let g:move_key_modifier = 'C'

Plug 'easymotion/vim-easymotion'
nmap s <Plug>(easymotion-s2)

Plug 'mattn/emmet-vim', { 'for': ['html', 'vue', 'jsx', 'tsx'] }

Plug 'tpope/vim-endwise', { 'for': ['ruby'] }

Plug 'fatih/vim-go', { 'for': ['go'] }
let g:go_fmt_command = "goimports" " run go import when file save

Plug 'posva/vim-vue', { 'for': ['vue'] }

Plug 'slim-template/vim-slim', { 'for': ['slim'] }

Plug 'leafgarland/typescript-vim', { 'for': ['typescript'] }

Plug 'peitalin/vim-jsx-typescript', { 'for': ['jsx', 'tsx'] }

Plug 'ryanoasis/vim-devicons'

call plug#end()

colorscheme codedark

