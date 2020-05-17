" -----------------------------------------------------------------------------
" Basic
" -----------------------------------------------------------------------------
set fenc=utf-8 " set file encording to UTF-8
set nobackup noswapfile " do not make buckup file or swapfile
set hidden " enable to open another file when edditing
set mouse=a " enable mouse
set clipboard+=unnamed " yank to clipboard
autocmd QuickFixCmdPost *grep* cwindow " open search result in QuickFix
source $VIMRUNTIME/macros/matchit.vim " enable to jump HTML tag by %
set isk+=- " interpret words chained by `-` as one word
set nowrap " dot not wrap long line

" -----------------------------------------------------------------------------
" Appearance
" -----------------------------------------------------------------------------
set number " show line number
" set cursorline cursorcolumn " highlighting line and column
set virtualedit=onemore " enable to move cursor to one more forward to last word of the line
set smartindent " auto indent for programming
set showmatch " show ) when input (
set wildmode=list:longest " autocomplete in command line
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
noremap m q
" q : move to end of the line
noremap q $
" serach selected without moving next matched word
vnoremap * "zy:let @/ = @z<CR>nN
" replace selected
vmap # *:%s///cg<Left><Left><Left><C-r>/
nmap * viw*
nmap # viw#
" indent
noremap <M-[> <<
noremap <M-]> >>
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

inoremap <C-o> <Esc>o
inoremap <C-l> <CR><Esc>O
" F5 : e! command
noremap <F5> :e!<CR>:CocRestart<CR><CR>
nnoremap X Vx
" push escape key twice to cancel highlight of matched word
nnoremap <silent> <Esc><Esc> :nohlsearch<CR><Esc>
nnoremap Y ggVGy
nnoremap vq v$<Left>
nnoremap <Space>r :source ~/.config/nvim/init.vim<CR>
nnoremap <Space>q :qa!<CR>
nnoremap <M-a> ggVG
" enable to omit `i` eg. c(i)w
let surrounds = ['(', ')', '{', '}', '[', ']', '<', '>', '"', '`', "'"]
for each_target in (surrounds + ['w', 't'])
  for each_command in ['c', 'd', 'v', 'y']
    execute 'nmap ' . each_command . each_target . ' ' . each_command . 'i' . each_target
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
nnoremap <Space>g :wa<CR>:tabnew<CR>:term lazygit<CR>i

" -----------------------------------------------------------------------------
" Plugins
" -----------------------------------------------------------------------------
call plug#begin('~/.local/share/nvim/plugged')

Plug 'tomasiser/vim-code-dark' " color scheme

Plug 'w0rp/ale' " Syntax checker

Plug 'bronson/vim-trailing-whitespace' " whitespace checker

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
let g:airline_powerline_fonts = 1
let g:airline_theme = 'deus'
let g:airline#extensions#tabline#enabled = 1

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
noremap <silent> <F4> :NERDTreeTabsToggle<CR>

Plug 'Xuyuanp/nerdtree-git-plugin'

Plug 'tpope/vim-fugitive' " git in vim

Plug 'tomtom/tcomment_vim'

" Plug 'vim-scripts/vim-auto-save'
" let g:auto_save = 1
" let g:auto_save_in_insert_mode = 0 " disable auto save in insert mode to avoid deleting indent

Plug 'neoclide/coc.nvim', { 'branch': 'release' }
Plug 'neoclide/coc-snippets', { 'do': 'yarn install --frozen-lockfile' }
Plug 'neoclide/coc-tsserver', { 'do': 'yarn install --frozen-lockfile' }
Plug 'neoclide/coc-solargraph', { 'do': 'yarn install --frozen-lockfile' }
Plug 'neoclide/coc-json', { 'do': 'yarn install --frozen-lockfile' }
Plug 'neoclide/coc-css', { 'do': 'yarn install --frozen-lockfile' }
Plug 'neoclide/coc-html', { 'do': 'yarn install --frozen-lockfile' }
Plug 'neoclide/coc-vetur', { 'do': 'yarn install --frozen-lockfile' }
set cmdheight=2 " Better display for messages
set updatetime=300 " You will have bad experience for diagnostic messages when it's default 4000.
set signcolumn=yes " always show signcolumns
nmap <silent> <F2> <Plug>(coc-rename)
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)
nmap <space>fi  <Plug>(coc-fix-current)
" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

Plug 'Chiel92/vim-autoformat'
noremap <F3> :Autoformat<CR>

Plug 'rking/ag.vim' " Multi file serach
nnoremap ga :Ag<Space>
vnoremap ga y:Ag<Space><C-r>0

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

Plug 'honza/vim-snippets'

Plug 'kana/vim-operator-user'
Plug 'tyru/operator-camelize.vim'
nmap <Space>c vw<Plug>(operator-camelize-toggle)bvu

Plug 'mattn/emmet-vim', { 'for': ['html', 'vue', 'javascript.jsx', 'typescript.tsx', 'svelte'] }

Plug 'tpope/vim-endwise', { 'for': ['ruby'] }

Plug 'posva/vim-vue', { 'for': ['vue'] }

Plug 'slim-template/vim-slim', { 'for': ['slim'] }

Plug 'leafgarland/typescript-vim', { 'for': ['typescript'] }

Plug 'peitalin/vim-jsx-typescript', { 'for': ['jsx', 'tsx'] }

Plug 'digitaltoad/vim-pug', { 'for': 'vue' }

Plug 'evanleck/vim-svelte', { 'for': 'svelte' }

Plug 'ElmCast/elm-vim', { 'for': 'elm' }
call plug#end()

" color
colorscheme codedark
highlight Search ctermbg=24 " hitting words
highlight IncSearch ctermbg=34 " replace target

