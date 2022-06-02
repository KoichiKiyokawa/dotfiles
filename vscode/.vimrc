" -----------------------------------------------------------------------------
" Keymaps
" -----------------------------------------------------------------------------
" m : macro
noremap m q
" q : move to end of the line
noremap q $
" H : move to top of the line
noremap H ^

" for us keyboard
noremap ; :

" avoid yank
nnoremap c "_c
nnoremap C "_C
nnoremap d "_d
nnoremap D "_D
vnoremap c "_c
vnoremap C "_C
vnoremap d "_d
vnoremap D "_D
vnoremap p pgvy

" serach selected without moving next matched word
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
nmap cw ciw
nmap ct cit
nmap c( ci(
nmap c{ ci{
nmap c[ ci[
nmap c' ci'
nmap c" ci"
nmap c` ci`

nmap dw diw
nmap dt dit
nmap d( di(
nmap d{ di{
nmap d[ di[
nmap d' di'
nmap d" di"
nmap d` di`

nmap vw viw
nmap vt vit
nmap v( vi(
nmap v{ vi{
nmap v[ vi[
nmap v' vi'
nmap v" vi"
nmap v` vi`

nmap yw yiw
nmap yt yit
nmap y( yi(
nmap y{ yi{
nmap y[ yi[
nmap y' yi'
nmap y" yi"
nmap y` yi`

" e.g. foo bar baz -> 'foo', 'bar', 'baz'
nmap <Space>' V<Space>'
nmap <Space>" V<Space>"
" e.g. foo bar baz -> :foo, :bar, :baz
vnoremap <silent> <Space>: "zx:execute ":normal i" . join(map(split(@z), '":" . v:val'), ", ")<CR>
nmap <silent> <Space>: V<Space>:
" add comma to the end of selected lines
vmap <Space>, :s/\n/,\r/g<Enter>
" nnoremap <Space>g :tabnew<CR>:term lazygit<CR>i
nnoremap <Space>y viwy
nnoremap <Space>p viw"_dP

" surround the word
nmap gs ysiw

" for vscode
nnoremap <C-k> editor.action.moveLinesUpAction
nnoremap <C-j> editor.action.moveLinesDownAction
nnoremap gi editor.action.goToImplementation

" vim easymotion
nnoremap s <leader><leader>2s

