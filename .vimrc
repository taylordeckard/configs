" OPTIONS {{{
set runtimepath+=~/.vim_runtime
set number
set relativenumber
set statusline+=%#warningmsg#
set statusline+=%*
" set colorscheme
set t_Co=256
" make clickable
set mouse=a
" set column limit
set colorcolumn=100
set switchbuf=usetab
set splitright
set splitbelow
" maintain undo history between sessions
set undofile
set undodir=~/.vim_undodir
" }}}
" IMPORTS {{{
source ~/basic.vim
source ~/filetypes.vim
" }}}
" FUNCTIONS {{{
function! Eatchar(pat)
    let c = nr2char(getchar(0))
    return (c =~ a:pat) ? '' : c
endfunction
"function! ConcealFn()
"   syn match RightArrow /\(\w\)\@<!=>\(\w\)\@!/ conceal cchar=⇨
"	syn match Sigma /\(\w\)\@<!sigma\(\w\)\@!/ conceal cchar=Σ
"	syn match Phi /\(\w\)\@<!phi\(\w\)\@!/ conceal cchar=Φ
"	syn match Omega /\(\w\)\@<!omega\(\w\)\@!/ conceal cchar=Ω
"	syn match GreaterThanEqual /\(\w\)\@<!>=\(\w\)\@!/ conceal cchar=≥
"	syn match LessThanEqual /\(\w\)\@<!<=\(\w\)\@!/ conceal cchar=≤
"	syn match Pi /\(\w\)\@<!pi\(\w\)\@!/ conceal cchar=π
"endfunction
" }}}
" PATHOGEN INIT {{{
" Add plugins
filetype on
call pathogen#infect()
call pathogen#helptags()
"execute pathogen#infect()
filetype plugin indent on
" }}}
" AUTOCMDS {{{
"augroup NERDTree
"    " Open NERDTree on startup and focus on file edit window
"    autocmd!
"    autocmd VimEnter * NERDTree | wincmd p
"augroup END
augroup copen_bottom
    " copen panel open at bottom
    autocmd!
    autocmd FileType qf wincmd J
augroup END
"augroup NERDTreeClose
"    " close NERDTree if it's the last thing open
"    autocmd!
"    autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
"augroup END
augroup filetype_vim
    " add folding to vimscript files
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker
augroup END
augroup vimfold
    " create a vimscript fold
    autocmd!
    autocmd FileType vim :vnoremap <buffer> gc xO" }}}<esc>PO" {{{<esc>hhi
augroup END
augroup closetag
    " closetag.vim
    autocmd!
    autocmd Filetype html,xml,xsl source ~/.vim/scripts/closetag.vim
augroup END
augroup typescript_folds
    " sets folding level on typescript files
    autocmd!
    autocmd Filetype typescript set foldnestmax=2 | set foldmethod=syntax | set foldlevel=1
augroup END
augroup vue_cfg
    " sets folding level on typescript files
    autocmd!
    autocmd BufEnter,BufNew *.vue set tabstop=8 softtabstop=0 expandtab shiftwidth=2 smarttab
augroup END
"augroup concealment
"    autocmd!
"    autocmd Filetype javascript,typescript :call ConcealFn()
"augroup END
" }}}
" PLUGIN LETS {{{
" auto pairs config
let g:AutoPairsFlyMode = 1
let g:AutoPairsShortcutBackInsert = '<M-b>'
" open nerdtree on tab open
" let g:nerdtree_tabs_open_on_console_startup=1
" let NERDTreeShowHidden=1
let g:tsuquyomi_disable_quickfix = 1
" ALE
let g:ale_linters = {
            \	'javascript': ['eslint'],
            \	'typescript': ['tslint', 'tsserver'],
			\   'python': ['flake8'],
            \	'html': []
            \}
let g:airline#extensions#ale#enabled = 1
" Tsuquyomi
let g:tsuquyomi_shortest_import_path = 1
let g:tsuquyomi_single_quote_import = 1
" You Complete Me
if !exists("g:ycm_semantic_triggers")
    let g:ycm_semantic_triggers = {}
endif
let g:ycm_semantic_triggers['typescript'] = ['.']
" the silver searcher
let g:ackprg = 'ag --vimgrep'
" remove netrw banner
let g:netrw_banner = 0
" set bash aliases
" let $BASH_ENV = "~/.alias.sh"
" }}}
" COMMANDS {{{
" pretty print json command
command! PrettyJson %!python -m json.tool
" pretty print js command
command! PrettyJs call JsBeautify()
" }}}
" MAPPINGS {{{
" incsearch
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)
" map gundo to F5
" nnoremap <F5> :GundoToggle<CR>
" Tsuquyomi map TsuImport
nmap <C-k> :TsuImport <CR>
" fzf
map <C-F> :GFiles <CR>
" replay macro with Q
nnoremap Q @@
" toggle case of word in edit mode
inoremap <C-u> g~iwwa
nnoremap <leader>ev :tabe $MYVIMRC<cr>
nnoremap <leader>sv :so $MYVIMRC<cr>
" exit -- INSERT -- mode with jk
inoremap jk <esc>
" toggle syntax highlighting (turn off to speed up)
nnoremap <leader>st :if exists("g:syntax_on") <Bar>
	\ syntax off <Bar>
	\ else <Bar>
	\ syntax enable <Bar>
	\ endif <CR>
" open netrw (file finder)
nnoremap <C-n> :Explore<cr>
" cycle forward through buffers
nnoremap <Tab> :bn<cr>
" cycle backward through buffers
nnoremap <S-Tab> :bp<cr>
" show buffers
nnoremap <C-b> :ls<cr>
" open a new tab
nnoremap T :tabe .<cr>
" }}}
" DISABLED DEFAULTS {{{
" unmap arrow keys
nnoremap OD <nop>
nnoremap OC <nop>
nnoremap OA <nop>
nnoremap OB <nop>
vnoremap OD <nop>
vnoremap OC <nop>
vnoremap OA <nop>
vnoremap OB <nop>
inoremap OD <nop>
inoremap OC <nop>
inoremap OA <nop>
inoremap OB <nop>
" unmap esc and ctrl-c
inoremap <c-c> <nop>
vnoremap <esc> <nop>
inoremap <esc> <nop>
" }}}
" COLORSCHEME {{{
" colorscheme industry
colorscheme twilight256
highlight ColorColumn ctermfg=NONE ctermbg=72
highlight Folded ctermfg=119 ctermbg=22
highlight IncSearch ctermfg=63 ctermbg=77
highlight LineNr ctermfg=110 ctermbg=NONE
highlight FoldColumn ctermfg=153 ctermbg=30
highlight CursorLineNr ctermfg=119 ctermbg=25
highlight Cursor ctermfg=132 ctermbg=55
highlight Search ctermfg=123 ctermbg=29
highlight Visual ctermfg=24 ctermbg=41
highlight Conceal ctermfg=6 ctermbg=NONE
highlight TabLine ctermfg=15 ctermbg=8
highlight TabLineFill ctermfg=16 ctermbg=NONE
highlight TabLineSel ctermfg=14 ctermbg=98
"
" " }}}
" YCM COLORS {{{
highlight Pmenu ctermfg=47 ctermbg=242 guifg=#00ff5f guibg=#666666
highlight PmenuSel ctermfg=0 ctermbg=154 guifg=#000000 guibg=#afff00
" }}}
" TABS vs SPACES {{{
" convert tabs to 4 spaces
" set tabstop=8 softtabstop=0 expandtab shiftwidth=4 smarttab
" convert tabs to 2 spaces
" set tabstop=4 softtabstop=0 expandtab shiftwidth=2 smarttab
" use tabs
set tabstop=4 noexpandtab shiftwidth=4 softtabstop=4
" " }}}
" HELPERS SCRIPT {{{
source ~/.vim/scripts/helpers.vim
" " }}}
" {{{ CONCEAL
"set conceallevel=2
"set concealcursor=nc
" " }}}
