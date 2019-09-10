set nocp
syntax enable
"set number
set hls
set nobackup
set nowritebackup
set foldmethod=indent
set foldlevel=99
set ts=2
set softtabstop=2
set shiftwidth=2
set expandtab
set relativenumber
"set textwidth=80
let g:load_doxygen_syntax=1

filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'gmarik/Vundle.vim'
Plugin 'tmhedberg/SimpylFold'
Plugin 'vim-scripts/indentpython.vim'
Bundle 'Valloric/YouCompleteMe'
Plugin 'vim-syntastic/syntastic'
Plugin 'scrooloose/nerdtree'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'}
call vundle#end()

let g:SimpylFold_docstring_preview=1
let python_highlight_all=1
let NERDTreeIgnore=['\.pyc$', '\~$'] "ignore files in NERDTree
let g:ctrlp_max_files=0
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn)$',
  \ 'file': '\v\.(exe|so|dll|pyc)$',
  \ }
set laststatus=2

filetype on

highlight BadWhitespace ctermbg=green

au BufNewFile,BufRead *.py
	\ set sts=4 |
	\ set tabstop=4 |
	\ set shiftwidth=4 |
	\ set textwidth=0 |
	\ set expandtab |
	\ set autoindent |
	\ set fileformat=unix |
	\ set encoding=utf-8 |
	\ match BadWhitespace /\s\+$/

let g:ycm_autoclose_preview_window_after_completion=1
map <silent> \g  :YcmCompleter GoToDefinitionElseDeclaration<CR>
map <silent> \t  :NERDTreeToggle<CR>

"Change to current working directory
"set autochdir
map <silent> ,cd :cd %:p:h<CR>

noremap <silent> ,zr :set foldlevel=3<CR>

map <silent> ,f :set foldmethod=syntax<CR>

noremap \c :s:^://:<CR>:nohls<CR>
noremap \u :s:^//::<CR>:nohls<CR>
noremap \i :call InlineComment()<CR>

"map function to a key sequence in visual mode
vnoremap \( :call Parenthesize()<CR>

set history=200

nnoremap <S-Left> :tabprevious<CR>
nnoremap <S-Right> :tabnext<CR>

function! Parenthesize()
	"yank current visual selection to reg x
	normal gv"xy
	"put new string value in reg x
	"would do your processing here in actual script
	let @x = '(' . @x . ')'
	"re-select area and delete
	normal gvd
	"paste new string value back in
	normal "xP
endfunction

function! InlineComment()
	"yank current visual selection to reg x
	normal gv"xy
	"put new string value in reg x
	"would do your processing here in actual script
	let @x = '/* ' . @x . ' */'
	"re-select area and delete
	normal gvd
	"paste new string value back in
	normal "xP
endfunction

function! SwitchSourceHeader()
    let dest = ''
    let ext = expand('%:e')
    let current = expand('%:t:r')
    let root = expand('%:p:h')
    if ext == 'h'
        for source_ext in ['.cpp', '.cc', '.c']
            let dest = root . '/' . current . source_ext
            if filereadable(dest)
               break 
            endif
            let dest = ''
        endfor
    elseif ext == 'cpp' || ext == 'cc' || ext == 'c'
        let dest = root . '/' . current . '.h'
    endif
    if dest != ''
        execute 'edit' dest
    else
        echoerr 'Complementary file not found'
    endif
endfunction
