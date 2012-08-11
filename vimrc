"
" Azizul Rahman's Vim Configuration
"

"-----------------------------------------------------------------------------
" Word for the day!
"-----------------------------------------------------------------------------
echo "I was born not knowing and have had only a little time to change that here and"
echo "there.                                                                        "
echo "                                                            Richard P. Feynman"
echo "                                                                       (>^.^<)"

"-----------------------------------------------------------------------------
" Global Stuff
"-----------------------------------------------------------------------------
if has("unix")
  let $VIMHOME = '~/.vim'
  echom "Running in Linux environment!"
elseif has("pc")
  let $VIMHOME = '$VIMRUNTIME/vimfiles'
  echom "Running in Windows environment!"
endif

" Get pathogen up and running
filetype off
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

" Set filetype stuff to on
if has("autocmd")
  filetype plugin indent on 
  
  " restore cursor position
  autocmd BufReadPost *
        \ if line("'\"") > 1 && line("'\"") <= line("$") |
        \   exe "normal! g`\"" |
        \ endif
endif

if $lt_Co > 2 || has("gui_running")
  syntax on
endif
"filetype on
"filetype plugin on
"filetype indent on

" Tabstops are 4 spaces
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set autoindent

" set the search scan to wrap lines
set wrapscan

" Make command line two lines high
set ch=2

" set visual bell -- i hate that damned beeping
set vb

" Allow backspacing over indent, eol, and the start of an insert
set backspace=2

" Make sure that unsaved buffers that are to be put in the background are
" allowed to go in there (ie. the "must save first" error doesn't come up)
set hidden

" Make the 'cw' and like commands put a $ at the end instead of just deleting
" the text and replacing it
set cpoptions=ces$


" Don't update the display while executing macros
set lazyredraw

" no wrap please
set nowrap

" always show line numbers
set number

" Don't show the current command int he lower right corner. In OSX, if this is
" set and lazyredraw is set then it's slow as molasses, so we unset this
set showcmd

" Show the current mode
set showmode

" Switch on syntax highlighting.
syntax on

" Same as default except that I remove the 'u' option
set complete=.,w,b,t

" When completing by tag, show the whole tag, not just the function name
set showfulltag

" Set the textwidth to be 80 chars
set textwidth=80

" get rid of the silly characters in separators
set fillchars = ""

" Add the unnamed register to the clipboard
set clipboard+=unnamed

" Automatically read a file that has changed on disk
set autoread

" This is the timeout used while waiting for user input on a multi-keyed macro
" or while just sitting and waiting for another key to be pressed measured
" in milliseconds.
"
" i.e. for the ",d" command, there is a "timeoutlen" wait period between the
" "," key and the "d" key. If the "d" key isn't pressed before the
" timeout expires, one of two things happens: The "," command is executed
" if there is one (which there isn't) or the command aborts.
set timeoutlen=500


" Allow the cursor to go in to "invalid" places
set virtualedit=all

" Disable encryption (:X)
set key=

" Wipe out all buffers
nmap <silent> ,wa :1,9000bwipeout<cr>

" Toggle paste mode
nmap <silent> ,p :set invpaste<CR>:set paste?<CR>

" Syntax coloring lines that are too long just slows down the world
set synmaxcol=2048
"-----------------------------------------------------------------------------
" status line
"-----------------------------------------------------------------------------
" Set the status line the way i like it
set stl=%f\ %m\ %r%{fugitive#statusline()}\ Line:%l/%L[%p%%]\ Col:%v\ Buf:#%n\ [%b][0x%B]

" tell VIM to always put a status line in, even if there is only one window
set laststatus=2

"-----------------------------------------------------------------------------
" gui real estate
"-----------------------------------------------------------------------------
" Hide the mouse pointer while typing
set mousehide

" Set up the gui cursor to look nice
set guicursor=n-v-c:block-Cursor-blinkon0,ve:ver35-Cursor,o:hor50-Cursor,i-ci:ver25-Cursor,r-cr:hor20-Cursor,sm:block-Cursor-blinkwait175-blinkoff150-blinkon175

" set the gui options the way I like
set guioptions-=T

"-----------------------------------------------------------------------------
" search
"-----------------------------------------------------------------------------
set ignorecase

" increment search
set incsearch

" highlight search
set nohlsearch

" Search the current file for what's currently in the search register and
" display matches
nmap <silent> ,gs :vimgrep /<C-r>// %<CR>:ccl<CR>:cwin<CR><C-W>J:nohls<CR>

" Search the current file for the word under the cursor and display matches
nmap <silent> ,gw :vimgrep /<C-r><C-w>/ %<CR>:ccl<CR>:cwin<CR><C-W>J:nohls<CR>

" Search the current file for the WORD under the cursor and display matches
nmap <silent> ,gW :vimgrep /<C-r><C-a>/ %<CR>:ccl<CR>:cwin<CR><C-W>J:nohls<CR>

"-----------------------------------------------------------------------------
" Leader
"-----------------------------------------------------------------------------
let mapleader = ","

" Edit the vimrc file
nmap <silent> <leader>ev :e $MYVIMRC<CR>
nmap <silent> <leader>sv :so $MYVIMRC<CR>

"-----------------------------------------------------------------------------
" navigation
"-----------------------------------------------------------------------------
" window
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" tab
nmap <Tab> gt
nmap <S-Tab> gT

" esc when inserting mode, fast key.
inoremap jk <esc>
inoremap <esc> <nop>

" add soft right & left "going to beginning & to end"
nmap <leader>f ^
nmap <leader>h g_

" Make the command-line completion better
set wildmenu
set wildignore=*.o,*.obj,*~ "stuff to ignore when tab completing

" When the page starts to scroll, keep the cursor 8 lines from the top and 8
" lines from the bottom
set scrolloff=8

" Make horizontal scrolling easier
nmap <silent> <C-o> 10zl
nmap <silent> <C-i> 10zh

" cd to the directory containing the file in the buffer
nmap <silent> ,cd :lcd %:h<CR>

"-----------------------------------------------------------------------------
" useful macro
"-----------------------------------------------------------------------------
" Underline the current line with '='
nmap <silent> ,u= :t.\|s/./=/g\|:nohls<cr>
nmap <silent> ,u- :t.\|s/./-/g\|:nohls<cr>

" single text bubbling
nmap <C-up> [e
nmap <C-down> ]e

" multiple text bubbling
vmap <C-up> [egv
vmap <C-down> ]egv
"-----------------------------------------------------------------------------
" abbreviation
"-----------------------------------------------------------------------------

"-----------------------------------------------------------------------------
" NERD Tree Plugin Settings
"-----------------------------------------------------------------------------
" Toggle the NERD Tree on an off with F7
nmap <F7> :NERDTreeToggle<CR>

" Close the NERD Tree with Shift-F7
nmap <S-F7> :NERDTreeClose<CR>

" Show the bookmarks table on startup
let NERDTreeShowBookmarks=1

" Don't display these kinds of files
let NERDTreeIgnore=[ '\.ncb$', '\.suo$', '\.vcproj\.RIMNET', '\.obj$',
                   \ '\.ilk$', '^BuildLog.htm$', '\.pdb$', '\.idb$',
                   \ '\.embed\.manifest$', '\.embed\.manifest.res$',
                   \ '\.intermediate\.manifest$', '^mt.dep$' ]

"-----------------------------------------------------------------------------
" FuzzyFinder Settings
"-----------------------------------------------------------------------------
let g:fuf_file_exclude = '\v\~$|\.(o|exe|dll|bak|class|meta|lock|orig|jar|swp)$|/test/data\.|(^|[/\\])\.(hg|git|bzr)($|[/\\])'
let g:fuf_splitPathMatching = 0
let g:fuf_maxMenuWidth = 110
let g:fuf_timeFormat = ''
nmap <silent> ,fv :FufFile ~/.vim/<cr>
nmap <silent> ,fb :FufBuffer<cr>
nmap <silent> ,ff :FufFile<cr>
nmap <silent> ,fc :FufMruCmd<cr>
nmap <silent> ,fm :FufMruFile<cr>
nmap <silent> ,fp :FufFile ~/git/*<cr>

"-----------------------------------------------------------------------------
" taglist Settings
"-----------------------------------------------------------------------------
nnoremap <silent> <F8> :TlistToggle<CR>

"-----------------------------------------------------------------------------
" gundo Settings
"-----------------------------------------------------------------------------
nnoremap <F5> :GundoToggle<cr>

"-----------------------------------------------------------------------------
" Snipmate Settings
"-----------------------------------------------------------------------------
try
  source $VIMHOME/snippets/support_functions.vim
catch
  source ~/vimfiles/snippets/support_functions.vim
endtry
autocmd vimenter * call s:SetupSnippets()
function! s:SetupSnippets()

    "if we're in a rails env then read in the rails snippets
    if filereadable("./config/environment.rb")
      try
        call ExtractSnips("~/.vim/snippets/ruby-rails", "ruby")
        call ExtractSnips("~/.vim/snippets/eruby-rails", "eruby")
      catch
        call ExtractSnips("~/vimfiles/snippets/ruby-rails", "ruby")
        call ExtractSnips("~/vimfiles/snippets/eruby-rails", "eruby")
      endtry
    endif

    try
      call ExtractSnips("~/.vim/snippets/html", "eruby")
      call ExtractSnips("~/.vim/snippets/html", "xhtml")
      call ExtractSnips("~/.vim/snippets/html", "php")
    catch
      call ExtractSnips("~/vimfiles/snippets/html", "eruby")
      call ExtractSnips("~/vimfiles/snippets/html", "xhtml")
      call ExtractSnips("~/vimfiles/snippets/html", "php")
    endtry
endfunction

"-----------------------------------------------------------------------------
" colorscheme
"-----------------------------------------------------------------------------
colorscheme wombat 
