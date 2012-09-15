"" http://mislav.uniqpath.com/2011/12/vim-revisited/

set nocompatible                " choose no compatibility with legacy vi
syntax enable
set encoding=utf-8
set showcmd                     " display incomplete commands
filetype plugin indent on       " load file type plugins + indentation

"" Whitespace
set nowrap                      " don't wrap lines
set tabstop=4 shiftwidth=4      " a tab is two spaces (or set this to 4)
set expandtab                   " use spaces, not tabs (optional)
set backspace=indent,eol,start  " backspace through everything in insert mode

"" Searching
set hlsearch                    " highlight matches
set incsearch                   " incremental searching
set ignorecase                  " searches are case insensitive...
set smartcase                   " ... unless they contain at least one capital letter

"" easier navigation between split windows
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l

"" http://archive09.linux.com/feature/120126
"" http://blogs.perl.org/users/su-shee/2012/04/a-little-help-in-vim.html
function! FindSub()
  let subpattern = '\(sub\|function\) \w\+'
  let subline = search(subpattern, 'bnW')
  if !subline
    return ''
  else
    return matchstr(getline(subline), subpattern)
  endif
endfunction
set statusline=%F%m%r%h%w\ \ %<%r%{FindSub()}\ \ [GIT=%{GitBranchInfoTokens()[0]}]\ \ [TYPE=%Y]\ \ [POS=%04l,%04v][%p%%]\ \ [LEN=%L]
set laststatus=2

"" disable automatic comment insertion
"" http://vim.wikia.com/wiki/Disable_automatic_comment_insertion
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

"" smaller indentation for Ruby
"" http://stackoverflow.com/questions/158968/changing-vim-indentation-behavior-by-file-type
autocmd FileType ruby setlocal shiftwidth=2 tabstop=2

