" vimrc with annotations
"
" This is our VIM configuration file with annotations for newcomers.
"
" This file is generally organized like this:
"
"   * Basics: text, tab, search, window, bell, etc.
"   * Interactions: terminals, mice, colors, etc.
"   * Files: read/write, fle type handlers, etc.
"   * Externals: spell check, mutt mail, etc.
"   * Maps
"
" Thanks:
"   * http://www.stat.rice.edu/~helpdesk/dotfiles/.vimrc.html
"   * http://www.oualline.com/vim/10/vimrc.html


" DO ME FIRST

" We want VIM features, not VI compatible features.
set nocompatible


" TEXT SETTINGS

" Use Unicode text encoding.
set encoding=utf-8

" Maximum width of text that is being inserted. A longer line will be broken. Zero disables this.
set textwidth=72

" Backspace over indent, eol, start
set backspace=2

" Do not insert two spaces after a '.', '?' and '!' with a join command
set nojoinspaces

" Don't append carriage returns
set notextmode

" Turn on syntax highlighting
:syntax on

" Turn on automatic indentation. This copies the indent from the current line when starting a new line.
set autoindent


" TAB SETTINGS

" tabstop: the width of a hard tabstop measured in "spaces" -- effectively the (maximum) width of an actual tab character.
set tabstop=2

" shiftwidth: the size of an "indent". It's also measured in spaces, so if your code base indents with tab characters then you want shiftwidth to equal the number of tab characters times tabstop. This is also used by things like the =, > and < commands.
set shiftwidth=2

" softtabstop: makes the tab key (in insert mode) insert a combination of spaces (and possibly tabs) to simulate tab stops at this width. We prefer the default.
set softtabstop=0

" expandtab: enabling this will make the tab key (in insert mode) insert spaces instead of tab characters. This also affects the behavior of the retab command. We prefer the default.
set noexpandtab

" smarttab: Enabling this will make the tab key (in insert mode) insert spaces or tabs to go to the next indent of the next tabstop when the cursor is at the beginning of a line (ie: the only preceding characters are whitespace).
set smarttab


" SEARCH SETTINGS

" Do incremental search. Beware! Only for fast terminals.
:set incsearch

" Highlight the target of a search.
:set hlsearch

" Ignore case in search patterns.
set ignorecase


" WINDOW SETTINGS

" Allow to switch between buffers/windows when the buffer was modified
set hidden


" BELL SETTINGS

" Disable the visual bell blinker because it’s distracting.
set novisualbell

" Disable the audio bell sound because it’s distracting.
set noerrorbells


" TERMINALS, MICE, COLORS

" Indicates a fast terminal connection
set ttyfast

" Use mouse in all modes, plus hit-return
set mouse=ar

" Set beahviour to xterm, not mswin
behave xterm

if has("gui_running")
"   set background=Black

else

   if (&term =~ "term") || (&term =~ "rxvt") || (&term =~ "vt100") || (&term =~ "screen")
      " Use the clipboard register '*' for all yank, delete and put operations.
      " This allows to use mouse for copy/paste in local xterm,
      " but prevents to save the unnamed register between sessions
      set clipboard=unnamed

      if has ("terminfo")
"        set t_Co=8
"        set t_Sf=^[[3%p1%dm
"        set t_Sb=^[[4%p1%dm
         set t_Co=16
         set t_AF=^[[%?%p1%{8}%<%t3%p1%d%e%p1%{22}%+%d;1%;m
         set t_AB=^[[%?%p1%{8}%<%t4%p1%d%e%p1%{32}%+%d;1%;m
         "        ^ this must be real Escape
      else
        set t_Co=8
        set t_Sf=^[[3%dm
        set t_Sb=^[[4%dm
      endif
   endif

   " Set background to dark to have nicer syntax highlighting.
   set background=dark

endif

" And of course, the ever important syntax highlighting
" This has to go after the stuff above
syntax on


" Status line is bright white on blue; please note fg/bg is reverse for term mode
" highlight StatusLine cterm=bold ctermfg=white ctermbg=blue


" SAVE SETTINGS

" Automatically write files as needed.
:set autowrite

" Do not make a backup before overwriting a file
:set nobackup


" FILE TYPE SETTINGS

" For all files:
"   * set the format options
"   * turn of C indentation
"   * set the comments option to the default
:autocmd FileType *      set formatoptions=tcql nocindent comments&

" For all C and C++ files:
"   * set the format options
"   * turn on C indentation
"   * set the comments option.
:autocmd FileType c,cpp  set formatoptions=croql cindent comments=sr:/*,mb:*,ex:*/,://


" NETRW DIRECTORY BROWSER

" Make netrw behave like NERDtree
" http://ellengummesson.com/blog/2014/02/22/make-vim-really-behave-like-netrw/

" Omit the top banner because we
" prefer content to the banner info
let g:netrw_banner = 0

" How to show the file list:
"  * 0 = thin
"  * 1 = long
"  * 2 = wide
"  * 3 = tree
let g:netrw_liststyle = 3

" How to open files:
"   * 1 = open files in a new horizontal split
"   * 2 = open files in a new vertical split
"   * 3 = open files in a new tab
"   * 4 = open in previous window
let g:netrw_browse_split = 4

" Set the width of the file browser
" to a percentage of the page
let g:netrw_winsize = 25

" When a file is opened, split the window vertically
" with the new window and cursor at the right
let g:netrw_altv = 1

" Inherit any custom wildignore
let g:netrw_list_hide = &wildignore

" Launch when you start vi, by mapping the
" command to the VimEnter autocommand
augroup ProjectDrawer
  autocmd!
  autocmd VimEnter * :Vexplore
augroup END


" EXTERNAL SPELL CHECK

source ~/.vim.ispell

map <C-k>   :let @_=SpellCheck()<cr>
map! <C-k>  <ESC>:let @_=SpellCheck()<cr>i


" EXTERNAL PROGRAMS

" Connect to mutt email reader
autocmd BufRead /tmp/mutt* :source ~/.vim.mail


" MAP SETTINGS

" Make # keep it's normal indentation so it works as a comment
inoremap # X^H#

" Add emacs-style navigation for home, end, suspend.
map <C-A> <Home>
map <C-E> <End>
map <C-Z> :shell<CR>

" F2: write
map    <F2>   :w<CR>
map!   <F2>   <ESC>:w<CR>i

" F3: exit
map    <F3>   ZZ
map!   <F3>   <ESC>ZZ

" F4: quit
map    <F4>   :q!<CR>
map!   <F4>   <ESC>:q!<CR>


" Make shift-insert work like in Xterm
" map <S-Insert> <MiddleMouse>
" map! <S-Insert> <MiddleMouse>

if has("gui_running")
   " Send current file to a browser
   map ,b :!mozilla -remote 'openURL(file://%:p,new-window)'<Bar><Bar>mozilla 'file://%:p'&<CR>
   " Send visual block to a browser
   vmap ,B "*y:!mozilla -remote 'openURL(<C-R>*)'<Bar><Bar>mozilla '<C-R>*'&<CR>
else
   " send current file to links
   map ,b :set isk+=:,/,.,~<cr>:!links %<cr>:set isk-=:,/,.,~<cr>
   " send link to links
   map ,B :set isk+=:,/,.,~<cr>:!links <cword><cr>:set isk-=:,/,.,~<cr>
endif



"””” TODO: Annotate everything below into our preferred usage "”””

" Generic/interface settings
set showbread=+\   " Precede continued screen lines
set comments=b:#,:%,fb:-,n:>,n:)b:\"n:: " Comments may start with these chars: #%>":
set noendofline    " No <EOL> will be written for the last line in the file
set equalprg=fmt   " External program to use for "=" command
set formatoptions=tcrq " How to do automatic formatting
set keywordprg=man\ -k " Display man entries for `K' lookup
"set lazyredraw    " Do not update screen while executing macros
set list listchars=tab:>_,trail:_,extends:+ " ,eol:$ " Show tabs, trailing spaces, long lines
set matchpairs=(:),{:},[:],<:> " Matching pair characters
set shortmess=ato " Overwrite message for writing a file with subsequent message
set showmatch     " When a bracket is inserted, briefly jump to the matching one
set sidescroll=1  " The minimal number of columns to scroll horizontally
set nostartofline " Keep cursosr's column
set suffixes=     " Set a priority between files with almost the same name
set timeout timeoutlen=3000 " Set timeout on mappings/keycodes to 3 seconds
set viminfo='10   " Maximum number of previously edited files for which the marks are remembered
set whichwrap=b,s,h,l,<,>,[,] " Wrap to the previous/next line on all keys
set wildmenu      " Command-line completion operates in an enhanced mode
set wildmode=longest,list,list:full " Bash-vim wildcard behavior
set nowrap        " Do not visually wrap long lines  - do not make it look like there are line breaks where there aren't
set esckeys       " show escape
set hidden
set fo=cqrt
set ls=2
set textwidth=72


" Windows/buffers settings
set laststatus=2   " Always show status line
set ruler          " Show the line and column number of the cursor position
set showcmd        " Show (partial) command in status line
set splitbelow     " Put the new window below the current one
set title          " Set title to the value of 'titlestring' or to "VIM - filename"
set winheight=4    " At least 4 lines for current window
set winminheight=0 " Allow zero-height windows
set ts=4


" TODO
set ttymouse=xterm " Use mouse
set number         " Set number of lines.


" TODO
:set notextmode
:set notextauto

" Set the width of text to 70 characters.
:set textwidth=70




" for 2html
let html_number_lines = 0
let html_use_css = 1
" Comment: Run from a Unix shell
" Comment:
"   for f in *.[ch]; do gvim -f +"syn on" +"run! syntax/2html.vim" +"wq" +"q" $f; done


" AUTOCOMMANDS

" enable filetype detection
filetype on

" Remove all autocommands
"autocmd!

" When editing a file, always jump to the last cursor position
autocmd BufReadPost * if line("'\"") | exe "normal `\"" | endif

" Set options for python files
autocmd FileType python set autoindent smartindent
   \ cinwords=class,def,elif,else,except,finally,for,if,try,while
   \ makeprg=compyle4vim.py
   \ errorformat=%E\ \ File\ \"%f\"\\,\ line\ %l\\,\ column\ %c,%C%m |
   \ execute "autocmd BufWritePost " . expand("%") . " call DoPython()"

" Compile (clearing *.cgi[co] files after compilation)
" and if it is script, make it executable
function DoPython()
   !compyle %
   if expand("%:e") != "py"
      !rm -f %[co]
   endif
   if getline(1) =~ "^#!"
      !chmod +x %
   endif
endfunction

" Set options for text/html files
autocmd BufReadPre *.txt,*README*,*.htm*,/tmp/pico.*,mutt-* set textwidth=75
autocmd BufReadPre /tmp/pico.*,mutt-* set filetype=mail
autocmd FileType css set smartindent


" Makefiles:
"   * Must use tabs, so don't expand tabs to spaces.
"   * Have indentation at 8 chars to be sure that all indents are tabs, despite the mappings later.
autocmd FileType make set noexpandtab shiftwidth=8

" I like highlighting strings inside C comments
let c_comment_strings=1


augroup gzip
" Remove all gzip autocommands
   au!

   " Enable editing of gzipped files
   "   read: set binary mode before reading the file
   "     uncompress text in buffer after reading
   "  write: compress file after writing
   "  append: uncompress file, append, compress file
   autocmd BufReadPre,FileReadPre    *.gz set bin
   autocmd BufReadPost,FileReadPost  *.gz let ch_save = &ch|set ch=2
   autocmd BufReadPost,FileReadPost  *.gz '[,']!gunzip
   autocmd BufReadPost,FileReadPost  *.gz set nobin
   autocmd BufReadPost,FileReadPost  *.gz let &ch = ch_save|unlet ch_save
   autocmd BufReadPost,FileReadPost  *.gz execute ":doautocmd BufReadPost " . expand("%:r")

   autocmd BufWritePost,FileWritePost    *.gz !mv <afile> <afile>:r
   autocmd BufWritePost,FileWritePost    *.gz !gzip <afile>:r

   autocmd FileAppendPre         *.gz !gunzip <afile>
   autocmd FileAppendPre         *.gz !mv <afile>:r <afile>
   autocmd FileAppendPost        *.gz !mv <afile> <afile>:r
   autocmd FileAppendPost        *.gz !gzip <afile>:r
augroup END

augroup bzip2
" Remove all bzip2 autocommands
   au!

   " Enable editing of bzipped files
   "   read: set binary mode before reading the file
   "     uncompress text in buffer after reading
   "  write: compress file after writing
   "  append: uncompress file, append, compress file
   autocmd BufReadPre,FileReadPre    *.bz2 set bin
   autocmd BufReadPost,FileReadPost  *.bz2 let ch_save = &ch|set ch=2
   autocmd BufReadPost,FileReadPost  *.bz2 '[,']!bunzip2
   autocmd BufReadPost,FileReadPost  *.bz2 set nobin
   autocmd BufReadPost,FileReadPost  *.bz2 let &ch = ch_save|unlet ch_save
   autocmd BufReadPost,FileReadPost  *.bz2 execute ":doautocmd BufReadPost " . expand("%:r")

   autocmd BufWritePost,FileWritePost    *.bz2 !mv <afile> <afile>:r
   autocmd BufWritePost,FileWritePost    *.bz2 !bzip2 <afile>:r

   autocmd FileAppendPre         *.bz2 !bunzip2 <afile>
   autocmd FileAppendPre         *.bz2 !mv <afile>:r <afile>
   autocmd FileAppendPost        *.bz2 !mv <afile> <afile>:r
   autocmd FileAppendPost        *.bz2 !bzip2 <afile>:r
augroup END
