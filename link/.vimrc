execute pathogen#infect()
call pathogen#helptags()

set backspace=indent,eol,start " Make backspace behave in a sane manner.
syntax on " Enable syntax highlighting
" Enable file type detection and do language dependent indenting.
filetype plugin indent on
set number " Show line numbers
set history=100 " Increase history size to 100
set hidden " Leave hidden buffers open

autocmd BufEnter * silent! lcd %:p:h " cd's to directory of file in window
set t_Co=256
colorscheme solarized
highlight comment ctermfg=darkgray
set bg=dark

set fileformat=unix
set encoding=utf-8
set expandtab
set pastetoggle=<F6>
set shiftwidth=2
set softtabstop=2
set tabstop=2

" Enable default syntax highlighting for Markdown files
augroup markdown
    au!
    au BufNewFile,BufRead *.md,*.markdown setlocal filetype=ghmarkdown
augroup END

" vim-json disable syntax conceal
let g:vim_json_syntax_conceal = 0

" <Ctrl-l> redraws the screen and removes any search highlighting.
nnoremap <silent> <C-l> :nohl<CR><C-l>
