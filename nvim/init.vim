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
set isk+=- " interpret words chained by `-` as one word

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
for each_mode in ['n', 'v']
  for each_command in ['c', 'C', 'd', 'D']
    execute each_mode . 'noremap ' . each_command . ' "_' . each_command
  endfor
endfor
vnoremap p "_dP

" -----------------------------------------------------------------------------
" Keymaps
" -----------------------------------------------------------------------------
" m : macro
nnoremap m q 
" q : move to end of line
noremap q $
" serach selected without moving next matched word
vnoremap * "zy:let @/ = @z<CR>nN 
" replace selected
vmap # *:%s///cg<Left><Left><Left><C-r>/
nmap * viw*
nmap # viw#
" tab moving
nnoremap <C-t> gt
nnoremap <C-g> gT
inoremap <C-t> <Esc>gt
inoremap <C-g> <Esc>gT
nnoremap T :tabnew<CR>
" moves in insert mode
inoremap <C-a> <Home>
inoremap <C-e> <End>
inoremap <C-k> <Up>
inoremap <C-j> <Down>
inoremap <C-f> <Right>
inoremap <C-b> <Left>
inoremap <C-d> <Right><BS>
inoremap kk <Esc>
inoremap jj <Esc>
" F5 : e! command
noremap <F5> :e!<CR>
nnoremap X Vx
" push escape key twice to cancel highlight of matched word
nnoremap <silent> <Esc><Esc> :nohlsearch<CR><Esc> 
nnoremap Y ggVGy
nnoremap vq v$<Left>
nnoremap <Space>r :source ~/.config/nvim/init.vim<CR>
nnoremap <Space>q :qa!<CR>
nnoremap <M-a> ggVG
" enable to omit `i` eg. c(i)w
let surrounds = ['(', ')', '{', '}', '[', ']', '<', '"', '`', "'"]
for each_surround in add(surrounds, 'w')
  for each_command in ['c', 'd', 'v']
    execute 'nnoremap ' . each_command . each_surround . ' ' . each_command . 'i' . each_surround
  endfor
endfor
" e.g. foo bar baz -> 'foo', 'bar', 'baz'
vnoremap <Space>' "zx:execute ":normal i '" . join(split(@z), "', '") . "'"<CR>
nmap <Space>' V<Space>'
vnoremap <Space>" "zx:execute ':normal i "' . join(split(@z), '", "') . '"'<CR>
nmap <Space>" V<Space>"
" e.g. foo bar baz -> :foo, :bar, :baz
vnoremap <silent> <Space>: "zx:execute ":normal i" . join(map(split(@z), '":" . v:val'), ", ")<CR>
nmap <silent> <Space>: V<Space>:
" add comma to the end of selected lines
vnoremap <silent> <Space>, :s/\n/,\r/g<CR>:nohlsearch<CR> 

" -----------------------------------------------------------------------------
" Plugins
" -----------------------------------------------------------------------------
call plug#begin('~/.local/share/nvim/plugged')

Plug 'tomasiser/vim-code-dark' " color scheme

Plug 'w0rp/ale' " Syntax checker

Plug 'itchyny/lightline.vim' " statusline plugin

Plug 'cohama/lexima.vim' " autocomplete brackets

Plug 'tpope/vim-surround'
" enable to omit leader `S`
for each_surround in surrounds
  execute 'vmap ' . each_surround . ' ' . 'S' . each_surround
endfor

Plug 'ctrlpvim/ctrlp.vim' " open file by filename
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard'] " ignore file setted in .gitignore

Plug 'airblade/vim-gitgutter' " show diff

Plug 'thinca/vim-qfreplace' " replace all files

Plug 'scrooloose/nerdtree' " tree
let NERDTreeShowHidden=1 " show dotfiles in NERDTree
let g:NERDTreeIgnore = ['.DS_Store']
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

Plug 'ryanoasis/vim-devicons'

Plug 'osyo-manga/vim-over'
nnoremap <C-s> :OverCommandLine<CR>%s/
vnoremap <C-s> "zy:OverCommandLine<CR>%s/<C-r>z//cg<Left><Left><Left>

Plug 'mattn/emmet-vim', { 'for': ['html', 'vue', 'jsx', 'tsx'] }

Plug 'tpope/vim-endwise', { 'for': ['ruby'] }

Plug 'fatih/vim-go', { 'for': ['go'] }
let g:go_fmt_command = "goimports" " run go import when file save

Plug 'posva/vim-vue', { 'for': ['vue'] }

Plug 'slim-template/vim-slim', { 'for': ['slim'] }

Plug 'leafgarland/typescript-vim', { 'for': ['typescript'] }

Plug 'peitalin/vim-jsx-typescript', { 'for': ['jsx', 'tsx'] }

Plug 'digitaltoad/vim-pug', { 'for': 'vue' }

call plug#end()

" color
colorscheme codedark
highlight Search ctermbg=24

