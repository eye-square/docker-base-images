filetype plugin indent on

" settings
" -------------------------------------------------------------
filetype plugin indent on
set autoread
set background=dark
set clipboard+=unnamedplus
set complete=.,w,b,u,t,i,kspell
set foldmethod=indent
set hidden
set ignorecase
set laststatus=2
set list
set listchars=tab:\|\ ,trail:·
set mouse=a
set noexpandtab
set nofoldenable
set noshowmode
set noswapfile
set number
set path+=**
set shiftwidth=3
set shortmess+=I
set smartcase
set smartindent
set spelllang=en
set splitbelow
set splitright
set t_Co=256
set tabstop=3
set termguicolors
set updatetime=300
set wildignore+=**/node_modules/** 
set wildmenu
if has('nvim')
set inccommand=nosplit
set diffopt+=vertical
endif


let g:netrw_banner = 0
let g:netrw_winsize = 25
let g:netrw_liststyle = 3
let g:netrw_altv = 1

" general bindings
" -------------------------------------------------------------
tnoremap jk <C-\><C-n>
inoremap qq <Esc>
inoremap jj <Esc>
" inoremap <c-i> <c-k>
inoremap jl <Right>
inoremap j[ ${}<Left>
inoremap >> =>
map ; :
" noremap ;; ;
nnoremap S J
vnoremap < <gv
vnoremap > >gv


" vimium bindings
" -------------------------------------------------------------
nnoremap K :bn<cr>
nnoremap J :bp<cr>
noremap <c-d> 5j
noremap <c-u> 5k
nnoremap co :CloseOtherBufs<cr>


" g bindings
" -------------------------------------------------------------
nnoremap gl L
nnoremap gm M
nnoremap gh H


" q bindings
" -------------------------------------------------------------
vnoremap q; q:
nnoremap q; q:


" window
" -------------------------------------------------------------
nnoremap qww <C-w>w
nnoremap qwo <C-w>o
nnoremap qw/ :vsp<cr>
nnoremap qw- :sp<cr>
nnoremap qwz :call ZoomToggle()<cr>


" leader bindings
" -------------------------------------------------------------
nmap , `
vmap , `
let mapleader="'"
nmap <leader>; @:
vmap <leader>; @:
nmap <leader>a ggVG
nmap <expr> <leader>d 
	\ getbufvar(bufname(), '&buftype') == "" && bufname() != '[Command Line]'
	\ ? ':bdelete<cr>'
	\ : ':close<cr>'
vmap <leader>f "vy:Rg <c-r>=escape(@v, '[].')<cr><cr>
nmap <leader>g :G<cr>
nmap <leader>f :Rg 
nmap <leader>h :noh<cr>
nmap <leader>i mb"vyiw`b:Rg <c-r>=escape(@v, '[].')<cr><cr>
nmap <leader>j mbvip"by`b:exec '!cd %:p:h && node -e' shellescape(@b, 1)<cr>
xmap <leader>j mb"by`b:exec '!cd %:p:h && node -e' shellescape(@b, 1)<cr>
nmap <leader>l yiwoconsole.log()i"pla, pA;
nmap <leader>n *
nmap <leader>o o<Esc>
vmap <leader>p "_dP
nmap <leader>q @q
xmap <leader>q : norm @q<cr>
nmap <leader>w :w<cr>
nmap <leader>z mbvip"by`b:exec '!cd %:p:h && zsh -c ' shellescape(@b, 1)<cr>
xmap <leader>z mb"by`b:exec '!cd %:p:h && zsh -c ' shellescape(@b, 1)<cr>


" inner as default for text objects, omit shift for common keys
" -------------------------------------------------------------
let movements = {
\ '4': '$', 'l': '$',
\ '9': 'i(', '0': 'i)', 'p': 'ap', 'q': 'i"',
\ '<space>': 't<space>', ',': 't,', ';': 't;', ':': 't:', '.': 't.',
\ '=': 't=',
\ 'n': 'i{', 'rb': '])', 'rB': ']]'
\ }
for [key, value] in items(movements)
	execute 'nnoremap d'.key.' d'.value
	execute 'nnoremap c'.key.' c'.value
	execute 'nnoremap v'.key.' v'.value
	execute 'nnoremap y'.key.' y'.value
endfor
for char in [ 'w', 'B', '(', ')', '{', '}', '[', ']', '"', "'", '/' ]
	execute 'nnoremap d'.char.' di'.char
	execute 'nnoremap c'.char.' ci'.char
	execute 'nnoremap v'.char.' vi'.char
	execute 'nnoremap y'.char.' yi'.char
endfor
nnoremap vp vip


" extra pseudo objects
" -------------------------------------------------------------
for char in [ '_', '.', ':', ',', ';', '<bar>', '/', '<bslash>', '*', '+', '-', '#' ]
	execute 'xnoremap i' . char . ' :<C-u>normal! T' . char . 'vt' . char . '<CR>'
	execute 'onoremap i' . char . ' :normal vi' . char . '<CR>'
	execute 'xnoremap a' . char . ' :<C-u>normal! F' . char . 'vf' . char . '<CR>'
	execute 'onoremap a' . char . ' :normal va' . char . '<CR>'
endfor


" experimental
" -------------------------------------------------------------
function! NearestTextObject(action, items)
	let selection = ''
	let shortest = 0
	exe 'norm mb'
	for x in split(a:items)
		let @b = ''
		silent exe 'norm "byi'.x.'`b'
		let length = strlen(@b)
		if length != 0 && (shortest == 0 || length < shortest)
			let selection = x
			let shortest = length
		endif
	endfor
	if selection != ''
		call feedkeys(a:action.selection)
	endif 
endfunction
for [key, items] in items({ 'b': "( [ {", 'q': "\\\" ' `" })
	for action in ['d', 'c', 'v', 'y']
		exe 'nnoremap '.action.key.' :call NearestTextObject("'.action.'i", "'.items.'")<cr>'
		exe 'nnoremap '.action.'a'.key.' :call NearestTextObject("'.action.'a", "'.items.'")<cr>'
		exe 'nnoremap '.action.'i'.key.' :call NearestTextObject("'.action.'i", "'.items.'")<cr>'
	endfor
endfor


" pane zooming
" -------------------------------------------------------------
function! ZoomToggle() abort
	if exists('t:zoomed') && t:zoomed
		execute t:zoom_winrestcmd
		let t:zoomed = 0
	else
		let t:zoom_winrestcmd = winrestcmd()
		resize
		vertical resize
		let t:zoomed = 1
	endif
endfunction


" misc
" -------------------------------------------------------------
command! LogVar exe 'norm mbyiwoconsole.log()<Esc>i"<Esc>pla, <Esc>pA;<Esc>`b'
command! CloseOtherBufs exe 'norm mb' | silent! exe "%bd|e#|bd#" | exe 'norm `b'
command! TmuxVerticalSplit exe "silent !tmux split-window -h -c ".expand('%:p:h')
command! TmuxHorizontalSplit exe "silent !tmux split-window -c ".expand('%:p:h')
cnoreabbrev sjs set filetype=javascript syntax=javascript
cnoreabbrev sjson set filetype=json syntax=json

