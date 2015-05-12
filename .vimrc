" If you are confused by not seeing a lot of text, push zi
" For more info, see :help folding. Read General Notes section to learn.
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plugins
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" {{{

" Plugins
"""""""""
" {{{

" On Windows with cmd.exe use vimfiles, else use normal unix .vim folder
let g:win_shell = (has('win32') || has('win64')) && &shellcmdflag =~ '/'
let g:cygwin_shell = has('win32unix')
let s:prefix = has('nvim') ? 'nvim' : 'vim'
let g:vim_dir = printf(g:win_shell ? '$HOME/%sfiles' : '$HOME/.%s', s:prefix)

try
  call plug#begin(expand(g:vim_dir . '/plugged'))

  " Completion
  if !g:win_shell && !g:cygwin_shell &&
      \  (has('nvim') || (v:version >= 704 || (v:version == 703 && has('patch584'))))
    Plug 'Valloric/YouCompleteMe', { 'do': function('hooks#YCMInstall') }
  elseif has('lua')
    Plug 'Shougo/neocomplete.vim'
  endif
  Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets' "Default snippets

  " UI
  Plug 'bling/vim-airline'
  Plug 'edkolev/tmuxline.vim'
  Plug 'junegunn/goyo.vim'
  Plug 'Konfekt/FastFold'
  Plug 'kshenoy/vim-togglelist'
  Plug 'majutsushi/tagbar'
  Plug 'mhinz/vim-signify'
  Plug 'rhysd/committia.vim'
  Plug 'scrooloose/syntastic'
  Plug 'sjl/gundo.vim'
  Plug 'vim-scripts/taghighlight'

  " Movement
  Plug 'edsono/vim-matchit'
  Plug 'justinmk/vim-sneak'
  Plug 'MattesGroeger/vim-bookmarks'
  Plug 'vim-scripts/a.vim'
  Plug 'vim-scripts/tasklist.vim'

  " Editting
  Plug 'bkad/CamelCaseMotion'
  Plug 'godlygeek/tabular'
  Plug 'gorkunov/smartpairs.vim'
  Plug 'scrooloose/nerdcommenter'
  Plug 'tpope/vim-abolish'
  Plug 'tpope/vim-speeddating'
  Plug 'tpope/vim-surround'
  Plug 'vim-scripts/argtextobj.vim'
  Plug 'vim-scripts/DeleteTrailingWhitespace'
  if !has('nvim')
    Plug 'ConradIrwin/vim-bracketed-paste'
  endif

  " Searching & Files
  Plug 'ctrlpvim/ctrlp.vim' | Plug 'FelikZ/ctrlp-py-matcher'
  Plug 'gabesoft/vim-ags'
  Plug 'ludovicchabant/vim-lawrencium'
  "Plug 'mileszs/ack.vim'
  "Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
  Plug 'tpope/vim-fugitive'
  Plug 'zhaocai/DirDiff.vim'

  " Misc Functions
  Plug 'embear/vim-localvimrc'
  Plug 'jaxbot/github-issues.vim'
  Plug 'kopischke/vim-fetch'
  "Plug 'ludovicchabant/vim-gutentags'
  Plug 'mhinz/vim-hugefile'
  Plug 'tpope/vim-dispatch'
  Plug 'tpope/vim-sleuth'
  Plug 'tyru/open-browser.vim'

  " Syntax / File Specific
  Plug 'chrisbra/csv.vim'
  Plug 'clones/vim-zsh'
  Plug 'elzr/vim-json'
  "Plug 'fatih/vim-go'
  Plug 'hdima/python-syntax'
  Plug 'junegunn/vader.vim' "Testing vim scripts
  Plug 'justinmk/vim-syntax-extra'
  " Very large, enable when needed
  "Plug 'LaTeX-Box-Team/LaTeX-Box'
  Plug 'plasticboy/vim-markdown'
  Plug 'tfnico/vim-gradle'
  Plug 'tomswartz07/vim-todo'
  "Plug 'tpope/vim-markdown'
  " Linux Kernel style plugin
  "Plug 'vivien/vim-addon-linux-coding-style'
  Plug 'zaiste/tmux.vim'

  " Web Programming
  "Plug 'othree/html5.vim'
  "Plug 'ap/vim-css-color'
  "Plug 'hail2u/vim-css3-syntax'
  "Plug 'kchmck/vim-coffee-script'
  "Plug 'pangloss/vim-javascript'
  "Plug 'vim-scripts/jQuery'
  "Plug 'Shutnik/jshint2.vim'
  "Plug 'StanAngeloff/php.vim'
  "Plug 'vim-ruby/vim-ruby'

  " Color Schemes I like
  Plug 'morhetz/gruvbox'
  Plug 'nanotech/jellybeans.vim'
  Plug 'tomasr/molokai'
  Plug 'w0ng/vim-hybrid'
  " Nice Alternatives
  "Plug 'chriskempson/vim-tomorrow-theme'
  "Plug 'Lokaltog/vim-distinguished'
  "Plug 'tpope/vim-vividchalk'
  "Plug 'vim-scripts/desert256.vim'
  " Large Selection to sample
  "Plug 'flazz/vim-colorschemes'

  call plug#end()
catch
  echomsg 'Run command `Bootstrap`. After restart run command `pi'
endtry

" }}}
" Plugin Configuration
""""""""""""""""""""""
" {{{

" YouCompleteMe
"""""""""""""""
" Global fall back if no config present
let g:ycm_global_ycm_extra_conf = '~/.ycm_extra_conf.py'

" Allow completion of identifiers in comments too
let g:ycm_complete_in_comments = 1

" Allow ctags for identifier help
"let g:ycm_collect_identifiers_from_tags_files = 1

" Use next line to disable ultisnips completion
"let g:ycm_use_ultisnips_completer = 0

" Use the following to whitelist dirs for .ycm_extra_conf.py
let g:ycm_extra_conf_globlist = [
    \ '~/programming/*' ]

" Neocomplete
"""""""""""""
" Enable neocomplete at startup
let g:neocomplete#enable_at_startup = 1

" Use smartcase
let g:neocomplete#enable_smart_case = 1

" Automatically select first option
let g:neocomplete#enable_auto_select = 1

" Eclim
"""""""
" For eclim, YCM will query for completion
let g:EclimCompletionMethod = 'omnifunc'

" Fix for signs
let g:EclimShowQuickfixSigns = 0

" Syntastic
"""""""""""
" Set what chechers are active or passive
let g:syntastic_mode_map = {
    \ 'mode': 'active',
    \ 'active_filetypes': ['c', 'cpp', 'java', 'lisp', 'python', 'perl', 'ruby',
    \                      'sh', 'xml', 'json', 'xhtml', 'html', 'css', 'javascript']
\ }

" Check syntax on file open
"let g:syntastic_check_on_open = 1

" Show errors in the line numbers to left
let g:syntastic_enable_signs = 1

" Format the syntastic message
let g:syntastic_stl_format = '[%E{Err: %fe #%e}%B{, }%W{Warn: %fw #%w}]'

" List of files to ignore checking, may be useful later
let g:syntastic_ignore_files = [ '\m^/usr/include/' ]

" Always use location list
let g:syntastic_always_populate_loc_list = 1

" Override, don't think I'll run any unsecure perl files
let g:syntastic_enable_perl_checker = 1

" Manually set important checkers:
let g:syntastic_python_checkers = ['python', 'pylint', 'flake8']
let g:syntastic_perl_checkers = ['perl', 'perlcritic']

" Options to pass to above checkers take form:
" syntastic_filetype_checker_argtype = ''
" Command Run: <exe> <args> <fname> <post_args> <tail>
let g:syntastic_python_flake8_args = "--max-complexity 10"

" UltiSnips
"""""""""""
" Set dir to .vim section
let g:UltiSnipsSnippetsDir = expand(g:vim_dir . '/snippets')

" Force a version of python
"let g:UltiSnipsUsePythonVersion = 2

" Sneak
"""""""
" Allows quick motion when more than 2 matches
let g:sneak#streak = 1

" Allows smart case usage of sneak
let g:sneak#use_ic_scs = 1

" Toggle to allow or prevent sneak in netrw
" When enabled, moves old s binding to <Leader>s/S
let g:sneak#map_netrw = 1

" CtrlP
"""""""
" Using user command speeds up but means have to change command for options
" like hidden or ignores
if executable('ag')
  let &grepprg = 'ag --nogroup --nocolor'
  let s:ctrlp_fallback = 'ag %s
      \ --nocolor --nogroup --depth 5
      \ --hidden --follow --smart-case
      \ --ignore .bazaar
      \ --ignore .bzr
      \ --ignore .git
      \ --ignore .hg
      \ --ignore .svn
      \ --ignore .ccache
      \ --ignore .DS_Store
      \ --ignore .opt1
      \ --ignore .pylint.d
      \ --ignore .shell
      \ --ignore .wine
      \ --ignore .wine-pipelight
      \ --ignore "**/*.pyc"
      \ --ignore "**/*.class"
      \ --ignore "**/*.o"
      \ -g ""'
elseif g:win_shell
  let s:ctrlp_fallback = 'dir %s /-n /b /s /a-d'
else
  let s:ctrlp_fallback = 'find %s -type f'
endif

let g:ctrlp_user_command = {
    \ 'types': {
      \ 1: ['.git', 'cd %s && git ls-files . --cached --others --exclude-standard'],
      \ 2: ['.hg', 'hg --cwd %s locate -I .'],
    \ },
    \ 'fallback': s:ctrlp_fallback
\ }

" Faster matcher
if has('python')
  let g:ctrlp_match_func = { 'match': 'pymatcher#PyMatch' }
endif

" TagBar
""""""""
" Close on selecting an option
let g:tagbar_autoclose = 1

" Focus on open
let g:tagbar_autofocus = 1

" Compact the menu
let g:tagbar_compact = 1

" Nerdtree
"""""""""""""
" Show hidden files by default
let g:NERDTreeShowHidden = 1

" Don't need window after selecting file
let g:NERDTreeQuitOnOpen = 1

" Classic theme with |'s instead of >'s
let g:NERDTreeDirArrows = 0

" Width of window
let g:NERDTreeWinSize = 40

" Don't replace netrw (i.e. :e directory), defualt is 1
"let g:NERDTreeHijackNetrw = 0

" DeleteTrailingWhitespace
""""""""""""""""""""""""""
" Always delete trailing whitespace from lines on save
"let g:DeleteTrailingWhitespace = 1
"let g:DeleteTrailingWhitespace_Action = 'delete'

" Ack.vim
"""""""""
" Options when using ack
let g:ack_default_options = ' -s -H --nocolor --nogroup --column --sort-files --smart-case --follow'

" Ag (Silver Searcher)
""""""""""""""""""""""
" Options to use when searching with ag
let g:agprg = 'ag --column --smart-case --follow'

" OpenBrowser
"""""""""""""
" Default engine to duckduck
let g:openbrowser_default_search = 'duckduckgo'

" TmuxLine
""""""""""
" Preset for my tmux line
let g:tmuxline_preset = {
    \'a'       : '#h',
    \'b'       : '#(curl icanhazip.com)',
    \'win'     : '#I #W',
    \'cwin'    : '#I #W',
    \'y'       : ['#S', '#I', '#P'],
    \'z'       : ['%d %b %Y', '%H:%M:%S'],
    \'options' : {'status-justify': 'left'}
\ }

" Unused options to display other addrs
    "\'c'    : ['#(ifconfig en0 | grep "inet " | awk {print "en0" $2})',
    "\       '#(ifconfig en1 | grep "inet " | awk {print "en1" $2})',
    "\       '#(ifconfig tun0 | grep "inet " | awk {print "vpn" $2})'],

" Bookmarks
"""""""""""
" Center on jumping to bookmark
let g:bookmark_center = 1

" When jumping from quicklist, close it
let g:bookmark_auto_close = 1

" LargeFile
"""""""""""
" The size a file is considered large, in MiB. Manual -> HugefileToggle
"let g:hugefile_trigger_size = 2

" Github Issues
"""""""""""""""
" On forks, find issues from upstream ONLY
"let g:github_upstream_issues = 1

" Goyo.vim
""""""""""
" Hooks that run on enter/exit of Goyo command
function s:goyo_enter()
endfunction

function s:goyo_leave()
  " Hack to fix airline bug
  split
  redraw
  quit
endfunction

autocmd! User GoyoEnter
autocmd! User GoyoLeave
autocmd  User GoyoEnter nested call <SID>goyo_enter()
autocmd  User GoyoLeave nested call <SID>goyo_leave()

" LocalVimrc
""""""""""""
" Allow non-sandbox
let g:localvimrc_sandbox = 0

" Store decisions on Y/N/A in file
let g:localvimrc_persistent = 1
let g:localvimrc_persistence_file = expand(g:vim_dir . '/.lvimrc_persist')

" }}}

" }}}
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Status Line
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" {{{

" vim-Airline
"""""""""""""
" Enable syntastic integration
let g:airline#extensions#syntastic#enabled = 1

" Enable a smart tab top
let g:airline#extensions#tabline#enabled = 1

" Enable powerline fonts
let g:airline_powerline_fonts = 1

" Regular Status Line
"""""""""""""""""""""
" Syntastic modification to line, only if installed
let s:syn_status = ''
if exists(':Plug') && filereadable(expand(g:vim_dir . '/plugged/syntastic/LICENCE'))
  let s:syn_status .= ' || %{SyntasticStatuslineFlag()}'
endif

" Not prettiest, but functional
let &statusline  = '%<%1* %t%m %y || %{&fenc?&fenc:&enc}[%{&ff}] ' . s:syn_status
let &statusline .= '%= %b(0x%B) || buf: %n || %p%% %l,%c %0*'
set laststatus=2

" }}}
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Key Mappings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" {{{

" For custom key combos, use leader
let mapleader = ","

" Apparently used for buffer/filetype specific bindings
let maplocalleader = '\\'

" Never use ex mode
nnoremap Q <Nop>

" Save your left pinky
"nnoremap ; :

" Faster binding to escape insert/visual
inoremap jk <Esc>
vnoremap i  <Esc>
"inoremap <esc> <nop>

" Aliasing some commands to make tabs/buffers easy to manage
" Some of these exist, I put them here to remember
" Note with hidden set, buffers and tabs are largely the same
cnoreabbrev bn bnext
cnoreabbrev bp bprevious
cnoreabbrev tn tabn
cnoreabbrev tp tabp
cnoreabbrev te tabe
cnoreabbrev td tabclose

" I always forget for explore, make some shortcuts, Ev for v split, Et for tab
cnoreabbrev E Explore
cnoreabbrev Et Texplore
cnoreabbrev Ev Sexplore!

" Shortcuts for plugin management
cnoreabbrev pi PlugInstall
cnoreabbrev pu PlugUpdate
cnoreabbrev pc PlugClean

" Arrow keys to move through buffers/tabs
nnoremap <Right> :bnext<CR>
nnoremap <Left>  :bprevious<CR>
nnoremap <Up>    :tabn<CR>
nnoremap <Down>  :tabp<CR>

" Remap Space + direction to move between split windows
nnoremap <silent> <Space>k :wincmd k<CR>
nnoremap <silent> <Space>j :wincmd j<CR>
nnoremap <silent> <Space>h :wincmd h<CR>
nnoremap <silent> <Space>l :wincmd l<CR>

" Change window down (<C-W>j) then maximize buffer height (<C-W>_)
nnoremap <C-J> <C-W>j<C-W>_
nnoremap <C-K> <C-W>k<C-W>_
" Change window right (<C-W>l) then maximize buffer width (<C-W>|)
nnoremap <silent> <C-L> <C-W>l:vertical resize<CR>:AirlineToggle<CR>:AirlineToggle<CR>
nnoremap <silent> <C-H> <C-W>h:vertical resize<CR>:AirlineToggle<CR>:AirlineToggle<CR>

" Toggles for the location and quickfix
nnoremap <silent> <Leader>q :ToggleQF<CR>
nnoremap <silent> <Leader>l :ToggleLL<CR>

" Make all windows equal in size
"nnoremap <Leader>q <C-W>=

" Open netrw in current buffer
nnoremap <silent> <Leader>e :Explore<CR>

" Open netrw vertically or horizontally
nnoremap <silent> <Leader>v :call Vex.Toggle()<CR>
"nnoremap <silent> <Leader>h :Hexplore!<CR>

" To open NERDTree when used
nnoremap <silent> <Leader>n :NERDTreeToggle<CR>

" Find the current file in the source tree
nnoremap <silent> <Leader>nf :NERDTreeFind<CR>

" Signify binding to jump between hunks
nmap <Leader>hj <Plug>(signify-next-hunk)
nmap <Leader>hk <Plug>(signify-prev-hunk)

" Sneak explicit mappings
nmap ; <Plug>SneakNext
xmap ; <Plug>SneakNext
nmap ' <Plug>SneakPrevious
xmap ' <Plug>SneakPrevious

" Key bindings for UltiSnips, all of these are ctrl + key
let g:UltiSnipsExpandTrigger       = '<C-J>'
let g:UltiSnipsListSnippets        = '<C-L>'
let g:UltiSnipsJumpForwardTrigger  = '<C-J>'
let g:UltiSnipsJumpBackwardTrigger = '<C-K>'

" Open the filetype specific file
nnoremap <Leader>ft :FTOpen<CR>

" Binding for extra search modes
nnoremap <C-P>m :CtrlPMRUFiles<CR>
nnoremap <C-P>b :CtrlPBuffer<CR>
nnoremap <C-T> :CtrlPTag<CR>
nnoremap <C-T>>a :CtrlPBufTagAll<CR>

" Add shortcut to jump to definition/declaration of c file
nnoremap <Leader>j :YcmCompleter GoTo<CR>

" For smart TAB completion
function! s:check_back_space()
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction
inoremap <expr><TAB>  pumvisible() ? "\<C-N>" :
    \ <SID>check_back_space() ? "\<TAB>" :
    \ neocomplete#start_manual_complete()

" Shortcut to swap to header file, horizontal split
nnoremap <Leader>a :AS<CR>

" Shortcut to swap to header file, vertical split
nnoremap <Leader>av :AV<CR>

" Mappings for vim-dispatch
"nnoremap <Leader>m  :Make!<CR>
"nnoremap <Leader>di :Dispatch!<CR>

" Hex editting command on x
nnoremap <Leader>x :%!xxd<CR>
nnoremap <Leader>X :%!xxd -r<CR>

" Fix oneline json files
nnoremap <Leader>jq :%!jq .<CR>
nnoremap <Leader>jQ :%!jq . -c<CR>

" Paste toggle button, disables indents. No longer needed?
"set pastetoggle=<F1>

" Toggle line numbers
nnoremap <silent> <F1> :set number!<CR>:sign unplace *<CR>
inoremap <silent> <F1> <Esc>:call feedkeys("\<F1>i")<CR>

" Shortcut for tagbar outline of file
nnoremap <silent> <F2> :TagbarToggle<CR>
inoremap <silent> <F2> <Esc>:call feedkeys("\<F2>")<CR>

" Shortcut for gundo sidebar
nnoremap <silent> <F3> :GundoToggle<CR>
inoremap <silent> <F3> <Esc>:call feedkeys("\<F3>")<CR>

" Toggle showing whitespace
nnoremap <silent> <F5> :set list!<CR>
inoremap <silent> <F5> <Esc>:call feedkeys("\<F5>i")<CR>

" Shortcut to remember how to reindent file
nnoremap <F12> mzgg=G'z

if has('nvim')
  tnoremap <C-J> <C-\><C-n>
endif

" }}}
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General Options & Features
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" {{{

" Ensure backspace works as you'd expect, over lines/indents
set backspace=indent,eol,start

" This is the timeout on key combos and map commands
set timeout
set timeoutlen=500

" Set to auto read when a file is changed from the outside
set autoread

" Allow hiding of files, when using standard :e filename option
set hidden

" Set UTF-8 for file enconding
set encoding=utf8

" Folding method, for most code use indent, no need to clutter source
set foldmethod=syntax
set foldminlines=6
set foldnestmax=2

" Enable folding at the syntax level
let g:javaScript_fold    = 1
let g:php_folding        = 1
let g:r_syntax_folding   = 1
let g:ruby_fold          = 1
let g:sh_fold_enabled    = 1
let g:vimsyn_folding     = 'af'
let g:xml_syntax_folding = 1

" Sets how many lines of history & undo VIM has to remember
set history=1000
set undolevels=1000

" Keep a persistent backup file, preserves undo history between edit sessions
if has('persistent_undo')
  let &undodir = expand(g:vim_dir . '/undo')
  try
    call mkdir(&undodir, 'p')
  catch
  endtry
  set undofile
endif

" Autocomplete feature for command mode (i.e. :command)
set wildmenu
set wildmode=longest,list,full

" Turn backup off, since most files in a VCS
set nobackup
set nowritebackup
set noswapfile

" No annoying sound on errors
set noerrorbells
set visualbell
set t_vb=

" }}}
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VIM User Interface & Search
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" {{{

" Set minimum screen size for GVim, on console just fill
if has('gui_running')
  set lines=80 columns=140
endif

" Enable the mouse in all modes of operation
"set mouse=a

" Show end of line and tabs on screen
"set list
set listchars=eol:$,tab:→→,trail:✘

" Set line numbering on left
set number

" Set position indicator on bottom right
set ruler

" Show command in last line, usually on by default
set showcmd

" Highlight current line in number side
set cursorline

" Minimum number of lines that will always be above/below cursor
set scrolloff=10

" Highlight search results
set hlsearch

" Incrementally highlight first matching word as you type a search
set incsearch

" Show matching brackets when text indicator is over them
set showmatch
" How many tenths of a second to blink when matching brackets
set matchtime=1

" For regular expressions turn magic on, don't need to \* in regex
set magic

" When searching ignore case unless contains a capital
" Override with \c/\C flag in regex -- /\cword
set ignorecase
set smartcase

" More intiutive when new splits at right and bottom
set splitbelow
set splitright

" }}}
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors & Fonts
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" {{{

syntax off

" Set dark background before, else colors off
set background=dark
try
  if &diff && (has('gui_running') || &t_Co > 255)
    colorscheme jellybeans
  elseif has('gui_running') || &t_Co > 255
    colorscheme molokai
    " Molokai CursorLine isn't bright enough
    hi CursorLine  ctermbg=236
  else
    colorscheme gruvbox
  endif
catch
  colorscheme desert
endtry

syntax on

highlight ColorColumn ctermbg=238
function s:match_col_no()
  let col_no = exists('b:match_column_no') ? b:match_column_no : 100
  call matchadd('ColorColumn', '\%>' . col_no . 'v', 100)
endfunction

" Set font when using gui version
if has('gui_running')
  if has('gui_gtk2')
    set guifont=DejaVu\ Sans\ Mono\ for\ Powerline\ 10
  elseif has('gui_win32')
    set guifont=DejaVu_Sans_Mono_for_Powerline:h10:cANSI
  endif
endif

" }}}
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Tab & Indents
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" {{{

" 1 tab == 4 spaces
set softtabstop=4
set shiftwidth=4
set tabstop=4

" When using `<<` or `>>`, round to nearest multiple of shiftwidth
set shiftround

" Use spaces instead of tabs
set expandtab

" When push tab in insert shift by tabstop, when backspace delete tabstop amount
set smarttab

" Copy indent at current when inserting new line
set autoindent

" Wrap lines when hit right side, doesn't affect buffer
set nowrap

" When wrapping, respect the indent of original line
if exists('&breakindent')
  set breakindent
endif

" Makes smarter decisions about what stays on wrapped line
set linebreak

" When inserting text, force a line break at this amount
" Set to 0 to disable
"set textwidth=150
set textwidth=0

" }}}
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => NETRW File Explorer & File Ignore
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" {{{

" Customize netrw use a tree style and ignore some extensions
let g:netrw_liststyle = 3

" Set the explorer sorting to case insensitive
let g:netrw_sort_options = 'i'

" Controls what happens when you push enter over file, default open in buffer
let g:netrw_browse_split = 0

" This list is used to build the strings for wildignore and netrw_list_hide
" Any file ending in one of these extensions will be ignored in command completion & netrw browser
let s:hide_exts =  ['jpg', 'jpeg', 'png', 'svg', 'bmp', 'gif', 'xpm', 'so', 'dll', 'exe', 'o', 'a']
let s:hide_exts += ['pyc', 'class', 'com', 'rar', 'zip', 'gz', 'bz2', '7z', 'iso', 'jar', 'dmg']
let s:hide_exts += ['deb', 'pdf']

" Add to ignore docs
"let s:hide_exts += ['doc', 'docx', 'odt', 'xls', 'xlsx', 'ods', 'ppt', 'pptx', 'odp']

" Processing here to build the large regexp
let s:wild_regex = ''
let s:netrw_regex = ''

for ext in s:hide_exts
  let s:wild_regex .= '*.' . ext . ','
  let s:netrw_regex .= ext . '\|'
endfor

" Don't leave trailing separator
let s:wild_regex = s:wild_regex[:-2]
let s:netrw_regex = s:netrw_regex[:-3]

" Hide VCS folders in this list
let s:vcs_hide = '\.git/,\.hg/,\.svn/,\.bzr/'

" When using autocomplete tab, ignore all matching strings
let &wildignore = s:wild_regex . ',' . s:vcs_hide

" When browsing with netrw, ignore all matching files to this regex
let g:netrw_list_hide = '\w\+\.\(' . s:netrw_regex . '\)\*\?$\c,' . s:vcs_hide
let g:NERDTreeIgnore = split(g:netrw_list_hide, ',')

" Sort by extensions commonly found
let s:sort_exts =  ['h', 'hh', 'hpp', 'hxx', 'c', 'cc', 'cpp', 'cxx', 'java']
let s:sort_exts += ['py', 'pl', 'rb', 'html', 'css', 'js', 'xml', 'json']

let g:netrw_sort_sequence = '[\/]$,\<core\%(\.\d\+\)\=\>,'
for ext in s:sort_exts
  let g:netrw_sort_sequence .= '\.' . ext . '$,'
endfor
let g:netrw_sort_sequence .= '*,\.info$,\.swp$,\.bak$,\~$'
let g:NERDTreeSortOrder = split(g:netrw_sort_sequence, ',')

" }}}
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Autocommands & Filetype Specific
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" {{{

" Protection against older Vim versions. Gvim reports falsely augroup = 0 sometimes.
if has('autocmd')
  if has('gui')
    augroup gui_cmds
      autocmd!
      " Stop bell on gvim
      autocmd GuiEnter * set visualbell t_vb=
    augroup END
  endif

  augroup buf_cmds
    autocmd!
    " Prevent undo files in some paths
    autocmd BufWritePre /tmp/* setlocal noundofile
    " All .md files should be markdown
    autocmd BufRead,BufNewFile *.md set filetype=markdown
    " When change vimrc, reload it on write
    "autocmd BufWritePost $MYVIMRC source $MYVIMRC
    " When leaving window, save state to a file. Restore on return
    " Includes cursor position, fold states,
    "au BufWinLeave *.* silent! mkview
    "au BufWinEnter *.* silent! loadview
    autocmd BufRead * call Vex.Off()

    "Highlight when I exceed a column limit
    autocmd BufEnter * call s:match_col_no()
    "Highlight the region
    autocmd BufWinEnter plug.vim syn region vimPythonRegion fold matchgroup=vimScriptDelim start=+execute\s*py_exe\s*"<<\s*EOF"*+ end=+^EOF$+	contains=@vimPythonScript
  augroup END

  " Register funcs with filetype load
  augroup ftype_cmds
    autocmd!
    " missing keywords for bash statement syntax
    autocmd FileType sh exec 'syntax keyword shStatement source shopt'
  augroup END

  augroup netrw_cmds
    autocmd!
    autocmd FileType netrw nmap <buffer> <Leader>x gh
    autocmd FileType netrw nmap <buffer> <silent> <Leader>z :call <SID>ShowSyms()<CR>
    autocmd FileType netrw nmap <buffer> <silent> q :call Vex.Close()<CR>
    autocmd FileType netrw nmap <buffer> <silent> o :call Vex.Action('new')<CR>
    autocmd FileType netrw nunmap <buffer> <C-L>
  augroup END
endif

" }}}
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Useful Functions & Commands
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" {{{

" A simple colorscheme function to test colors for a buffer
" Allow both cycling choosing by name
command! -nargs=0 SchemeNext call Color.Next()
command! -nargs=0 SchemeBack call Color.Prev()
command! -nargs=0 SchemePick call Color.Pick()

let g:Color = {}
function! Color.Init(remDefaults)
  " Populate list
  let schemes = split(globpath(&rtp, 'colors/*.vim'), '\n')
  if a:remDefaults == 1
    let pattern = g:win_shell ? 'vim7.4withLua' : 'share/vim'
    let schemes = filter(schemes, "v:val !~ pattern")
  endif
  let self.list = sort(map(schemes, "fnamemodify(v:val, ':t')[0:-5]"))

  " Find current index
  let self.cur = 0
  for scheme in schemes
    if scheme ==? g:colors_name
      break
    endif
    let self.cur += 1
  endfor
  let self.default = self.cur + 1

  if (len(self.list) > 26)
    echomsg 'too many schemes, listing first 26'
    return
  endif
endfunction

" Returns a string with anchors for confirm dialog
function! Color.Choices()
  let msg = ""
  let char = "A"
  for s in self.list
    let msg .= "&" . char . s . "\n"
    let char = nr2char(char2nr(char) + 1)
    " Stop at 26th
    if char == "["
      break
    endif
  endfor
  return msg[0:-2]
endfunction

function! Color.Set()
  " Set new scheme
  syntax off
  set background=dark
  exec 'colorscheme ' . self.list[self.cur]
  syntax on
  echomsg 'colorscheme is now: ' . g:colors_name
endfunction

function! Color.Next()
  let self.cur = (self.cur + 1) % len(self.list)
  call self.Set()
endfunction

function! Color.Prev()
  let self.cur = (self.cur - 1) % len(self.list)
  call self.Set()
endfunction

function! Color.Pick()
  " Returns cur of 1 - n choices
  let self.cur = confirm("Pick Scheme From:", self.Choices(), self.default) - 1
  call self.Set()
endfunction
call Color.Init(1)

" For a block of lines change spacing from old tab size to new tab size
command! -nargs=+ -range=% ChangeSpace call s:ChangeSpace(<line1>, <line2>, <f-args>)
function! s:ChangeSpace(line1, line2, old_tab, new_tab)
  let l:rtab_cmd = printf('%s,%sretab', a:line1, a:line2)

  exec printf('set ts=%s sts=%s sw=%s noet', a:old_tab, a:old_tab, a:old_tab)
  exec l:rtab_cmd . '!'

  exec printf('set ts=%s sts=%s sw=%s et', a:new_tab, a:new_tab, a:new_tab)
  exec l:rtab_cmd
endfunction

" Open the ftplugin file for current buffer
command! -nargs=0 FTOpen call s:FTOpen()
function! s:FTOpen()
  let l:file = printf('%s/ftplugin/%s.vim', g:vim_dir, &ft)
  exec 'sp ' . l:file
endfunction

" Given a netrw buffer, extract filename on line
function! s:ExtractFullPath(line)
  let l:left = 0
  let l:right = len(a:line) - 1

  let l:char = a:line[l:left]
  while l:char == ' ' || l:char == '|'
    let l:left += 1
    let l:char = a:line[l:left]
  endwhile

  let char = a:line[l:right]
  while l:char =~ '[/*|@=]$'
    let right -= 1
    let char = a:line[l:right]
  endwhile

  let l:link = strpart(a:line, l:left, l:right - l:left + 1)

  if exists('s:max_link') && len(l:link) > s:max_link
    let s:max_link = len(l:link)
  endif

  return [l:link, resolve(getcwd() . "/" . l:link)]
endfunction

" Shows in an echo the target of links
" New netrw >= 153 seems to support it via display
function! s:ShowSyms()
  let l:count = 1
  let l:files = []
  let s:max_link = 0

  for l:line in getline(1, '$')
    if l:line =~ '@$'
      let l:files  += [[l:count] + s:ExtractFullPath(l:line)]
    endif

    let l:count += 1
  endfor

  let l:output = ""
  let l:fmt = "ln: %5d %" . s:max_link . "s -> %s\n"
  for l:entry in l:files
    let l:output .= printf(l:fmt, l:entry[0], l:entry[1], l:entry[2])
  endfor
  echo l:output
endfunction

" Make a NERDTree like side buffer
let g:Vex = {}
function! Vex.Toggle()
  if exists('t:vex')
    call self.Close()
  else
    call self.Open()
  endif
endfunction

function! Vex.Off()
  if exists('t:vex')
    call self.Close()
  endif
endfunction

function! Vex.Open()
  let t:vex = {'orig_buf': winnr(), 'orig_bsplit': g:netrw_browse_split}
  let g:netrw_browse_split = 4

  topleft vnew
  wincmd H
  execute 'vertical resize ' . g:NERDTreeWinSize
  Explore

  let t:vex.new_buf = bufnr('%')
endfunction

function! Vex.Close()
  let vex_buf = bufwinnr(t:vex.new_buf)

  if vex_buf != -1
    execute vex_buf . ' wincmd w'
    close
    execute t:vex.orig_buf . ' wincmd w'
  endif

  let g:netrw_browse_split = t:vex.orig_bsplit
  unlet t:vex
endfunction

function! Vex.Action(action)
  let l:orig_win = winnr()
  wincmd l
  execute a:action
  let t:vex.orig_buf = winnr()
  execute l:orig_win . ' wincmd w'
  call feedkeys("\<CR>", 't')
endfunction

command! -nargs=+ FileFetch call g:FileFetch(<f-args>)
function! g:FileFetch(src, dst)
  let l:dst_dir = fnamemodify(a:dst, ':h')
  if !isdirectory(l:dst_dir)
    call mkdir(l:dst_dir, 'p')
  endif
  if has('python')
    call s:fetch_python(a:src, a:dst)
  elseif has('ruby')
    call s:fetch_ruby(a:src, a:dst)
  elseif executable('curl')
    silent execute printf('!curl -fLo %s %s >/dev/null 2>&1', a:dst, a:src)
  elseif executable('wget')
    silent execute printf('!wget -O %s %s >/dev/null 2>&1', a:dst, a:src)
  else
    echoerr 'No supported file download method.'
  endif
  echomsg 'File ' . fnamemodify(a:src, ':t') . ' written to ' . a:dst . '.'
  redraw!
endfunction

function! s:fetch_python(src, dst)
python << EOF
import urllib
import vim
urllib.urlretrieve(vim.eval('a:src'), vim.eval('a:dst'))
EOF
endfunction

function! s:fetch_ruby(src, dst)
ruby << EOF
require 'open-uri'
File.open(VIM::evaluate('a:dst'), 'w') do |f|
f << open(VIM::evaluate('a:src')).read
end
EOF
endfunction

command! -nargs=0 Bootstrap call s:bootstrap()
function! s:bootstrap()
  let plug_src = 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  let plug_dst = expand(g:vim_dir . '/autoload/plug.vim')
  call g:FileFetch(plug_src, plug_dst)
  echo 'Done, please restart and run `PlugInstall`.'
endfunction

command! -nargs=0 VimrcUpdate call s:vimrc_update()
function! s:vimrc_update()
  let src = 'https://raw.githubusercontent.com/starcraftman/.my_scripts/master/dot_files/.vimrc'
  call g:FileFetch(src, $MYVIMRC)
endfunction

" Bundle env variables, vimrc & .vim folders for remote deploy
command! -nargs=0 BundleVim call s:bundle_vim()
function! s:bundle_vim()
  let src = 'https://raw.githubusercontent.com/junegunn/myvim/master/myvim'
  let dst = 'myvim'
  call g:FileFetch(src, dst)
  execute '!bash ' . dst
  call delete(dst)
endfunction
" }}}
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General Notes
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" {{{

" Quick Links
"""""""""""""
" {{{

" * To Learn Vim: vimtutor
"       The vim tutor is an introductory programs, useful for beginners
"
" * Vim Cheatsheet and Tutorial:
"       http://www.viemu.com/a_vi_vim_graphical_cheat_sheet_tutorial.html
"
" * Vim regex:
"       http://www.vimregex.com/
"
" * Vim Script: Learn to make plugins and contructs like loops, vars and commands
"       http://learnvimscriptthehardway.stevelosh.com/
"
" * Vim Syntax/Indent Files:
"       http://robots.thoughtbot.com/writing-vim-syntax-plugins
"
" * Vim NETRW remote editting
"       http://www.vim.org/scripts/script.php?script_id=1075
"
" * Explore plugins at:
"       http://vimawesome.com/

" * For detailed breakdown of basic vim options, I started by looking at this one:
"       http://amix.dk/vim/vimrc.html
"
" * For color schemes:
"       Large selection of schemes: https://github.com/flazz/vim-colorschemes
"       Put schemes in ~/.vim/colors or use a plugin manager
"       Favourites In Order:
"           molokai, jellybeans, desert256, wombat256mod, mrkn256, xoria256, twilight256
"
" }}}
" Installation Procedure
""""""""""""""""""""""""
" {{{

"   1) Install Vim 7.4 with Python, Lua & Signs:
"     a) Automated Build
"       BuildSrc.py vim
"
"     b) Manual Build
"       https://github.com/Valloric/YouCompleteMe/wiki/Building-Vim-from-source
"
"     b) Windows
"       Download and extract:
"       http://tuxproject.de/projects/vim/complete-x86.7z
"       Put the lua52.dll in the root project
"       http://sourceforge.net/projects/luabinaries/files/5.2/Windows%20Libraries/Dynamic/"
"
"     c) Windows Babun (Cygwin)
"       https://github.com/babun/babun
"
"   2) Check Support for features:
"       :echo has('lua') && has('python') && has('signs')
"
"   3) Next setup config fils (.vim, .vimrc and so on)
"     a) Python Script
"       SysInstall home
"           Symbolically links .vim & .vimrc to home
"           Bootstraps vim plugin manager
"           Sets up powerline fonts for airline
"
"     b) Manually link/copy/download above. See ~/.my_scripts/dot_files
"       Link from ~/.my_scripts/dot_files to $HOME
"       Get Manager:
"           vim +Bootstrap +qa
"       Powerline Fonts:
"           See steps at:
"           http://powerline.readthedocs.org/en/latest/installation.html
"
"   4) Open vim and install plugins
"       :PluginInstall
"
"   5) Further Config:
"       Plug            : Requires nvim/python/ruby for parallel install
"       YouCompleteMe   : Requires cpp compilation, done on hook for *nix
"       vim-airline     : Powerline fonts optional, see SysInstall.py home
"       TagBar          : Requires exhuberant tags, see BuildSrc.py ctags
"       taghighlight    : Same as above.
"       vim-ags/ack.vim : Ag/Ack on system, see BuildSrc.py dev
"       eclim           : See manual steps from site

" }}}
" Plugin Information
""""""""""""""""""""
" {{{

"   Plug:
"       Minimal new plugin manager with parallelism, nvim/python/ruby
"       PlugUpdate only does bundles, PlugUpgrade for manager
"       https://github.com/junegunn/vim-plug
"   neocomplete:
"       Fairly complete YCM replacement for on Windows
"       https://github.com/Shougo/neocomplete.vim
"   YouCompleteMe:
"       Very good autocomplete, includes path completion,
"       automatic function indexing and clang checking with syntastic
"       Info at url below or use ycm_compile.py in my repo
"       https://github.com/Valloric/YouCompleteMe
"   Syntastic:
"       Syntax checking without running code usually on buffer write
"       https://github.com/scrooloose/syntastic
"       Extra Info: http://blog.jpalardy.com/posts/how-to-configure-syntastic/
"   vim-signify:
"       Shows the diff of file being eddited to left of numbers, i.e. 'gutter'
"       https://github.com/mhinz/vim-signify
"   vim-airline:
"       Plugin that gives nice colored status line
"       https://github.com/bling/vim-airline
"       See :help airline and AirlineToggle
"       NB: Be sure to patch ~/.fonts with powerline-fonts
"       See: https://powerline.readthedocs.org/en/latest/installation/linux.html#font-installation
"   tmuxline.vim:
"       Copy airline scheme onto tmux on vim startup
"       https://github.com/jedkolev/tmuxline.vim
"   ultisnips:
"       Same as SnipMate, seems that project may be unmaintained
"       https://github.com/SirVer/ultisnips
"       Required default snippets now externalized to below
"       https://github.com/honza/vim-snippets
"   vim-sneak:
"       Provies quick motion for cursor
"       Keys:
"           s<char><char> - search for word
"           ; - next word
"           ' - prev word match
"           ctrl + o - back to start
"       https://github.com/justinmk/vim-sneak
"   CtrlP:
"       Fuzzy file finding that is a bit easier than CtrlT
"       Searches under root, looks for .hg/.git or so to define top
"       Use Ctrl+P to access
"       Original:
"       https://github.com/kien/ctrlp.vim
"       Fork: Original no longer updating
"       https://github.com/ctrlpvim/ctrlp.vim
"       Faster Matching:
"       https://github.com/'FelikZ/ctrlp-py-matcher
"   TagBar:
"       A outline of the files contents
"       Uses exuberant ctags, not GNU ctags
"       See info at: https://github.com/majutsushi/tagbar
"   taghighlight:
"       Allow highlighting types based on ctags
"       https://github.com/vim-scripts/taghighlight
"   Gundo:
"       Graphical tree like explorer for visualizing undo history
"       Project: https://github.com/sjl/gundo.vim
"       Usage: http://sjl.bitbucket.org/gundo.vim/#Usage
"   NERDComment:
"       Bunch of comment commands. Mainly <Leader>ci to comment line
"       https://github.com/scrooloose/nerdcommenter
"   NERDTree:
"       Plugin that is a pretty NETRW replacement. I'm not sure I want it, but may re-evaluate
"       Open with :NERDTree command
"       https://github.com/scrooloose/nerdtree
"   vim-abolish:
"       Help for renaming, has easy syntax alternative to regexp
"       https://github.com/tpope/vim-abolish
"   vim-fugitive:
"       Provides git integration
"       https://github.com/tpope/vim-fugitive
"   vim-sleuth:
"       Detects the right whitespace useage based on file detection
"       https://github.com/tpope/vim-sleuth
"   vim-speeddating:
"       Make <C-A>, <C-X> work for dates
"       https://github.com/tpope/vim-speeddating'
"   vim-surround:
"       Modify the tags or brackets of code
"       https://github.com/tpope/vim-surround
"   vim-lawrencium:
"       Provides hg integration
"       https://github.com/ludovicchabant/vim-lawrencium
"   vim-ags:
"       Excellent ag integration
"       https;//github.com/gabesoft/vim-ags
"   ack.vim:
"       Same as ag.vim, though based on ack-grep a perl file
"       https://github.com/mileszs/ack.vim
"   FastFold:
"       Make folding much faster
"       https://github.com/zaiste/tmux.vim
"   Tabular:
"       Align text easily with regex patterns
"       https://github.com/godlygeek/tabular
"   vim-bookmarks:
"       Easier bookmarks, with or without annotation
"       verbose map m
"       https://github.com/MattesGroeger/vim-bookmarks
"   committia:
"       Display diff in the vim commit box
"       https://github.com/rhysd/committia.vim
"   DirDiff:
"       Diffs two dirs with vim: DirDiff dir1 dir2
"       https://github.com/zhaocai/DirDiff.vim
"   CamelCaseMotion:
"       Defines ,w/,b/,e text objects for maipulating camelCase or snake_case
"       Example: v3i,w - visual select 3 subsections to w
"       https://github.com/bkad/CamelCaseMotion
"   argtextobj.vim:
"       Defines aa/ia text object for modifying functions
"       Example: cia - change first argument, leaves comma after
"       https://github.com/vim-scripts/argtextobj.vim
"   smartpairs.vim:
"       Easy visual selections, use vv to select on matching pair
"       https://github.com/gorkunov/smartpairs.vim
"   github-issues.vim:
"       Github integration inside commit windows
"       https://github.com/jaxbot/github-issues.vim
"   vim-fetch:
"       Do immediate line/col jumps to a file, i.e. :e file:20:44
"       https://github.com/kopischke/vim-fetch
"   vim-matchit:
"       Extends the % command to jump to matching xml or if/fi tags
"       https://github.com/edsono/vim-matchit
"   A.vim:
"       Swap between a c source and header file with :A
"       https://github.com/vim-scripts/a.vim
"   DeleteTrailingWhitespace:
"       Use [Range]DeleteTrailingWhitespace, where range is an optional line range
"       https://github.com/vim-scripts/DeleteTrailingWhitespace
"   vim-localvimrc:
"       Allows project specific settings with .lvimrc files
"       https://github.com/embear/vim-localvimrc
"   vim-markdown:
"       Adds support for markdown syntax
"       https://github.com/plasticboy/vim-markdown/
"   open-browser:
"       OpenBrowserSearch - Search for term in default browser
"       https://github.com/tyru/open-browser.vim
"   vim-togglelist:
"       Provides simple keystroke to toggle lists
"       https://github.com/kshenoy/vim-togglelist
"   tmux.vim:
"       Syntax highlighting for .tmux.conf files
"       https://github.com/zaiste/tmux.vim
"   vim-zsh:
"       Better syntax highlighting for zsh
"       https://github.com/clones/vim-zsh
"   python-syntax:
"       Much better syntax highlighting
"       https://github.com/hdima/python-syntax
"   csv.vim:
"       Whole suite to make editting csv easier
"       https://github.com/chrisbra/csv.vim
"   LaTeX-Box:
"       Better highlighting and functions for LaTeX
"       https://github.com/LaTeX-Box-Team/LaTeX-Box
"   hugefile:
"       For very large files, turn off some features
"       https://github.com/mhinz/vim-hugefile
"   Vader.vim:
"       Testing framework for vim, no dependencies
"       Execute .vader files with Vader file.vader
"       https://github.com/junegunn/vader.vim
"   vim-tasklist:
"       <Leader>t -> quickfix with todos/fixmes
"       https://github.com/vim-scripts/tasklist.vim
"   vim-bracketed-paste:
"       No more paste toggle before pasting
"       https://github.com/ConradIrwin/vim-bracketed-paste
"   goyo.vim:
"       Distraction free writing/reading
"       https://github.com/junegunn/goyo.vim
"   vim-syntax-extra:
"       Extra syntax goodness for c, flex, bison
"       https://github.com/justinmk/vim-syntax-extra
"   vim-todo
"       Simple todo with highlighting
"       https://github.com/tomswartz07/vim-todo
" }}}
" Less Used Plugins
"""""""""""""""""""
" {{{

"   Vundle:
"       Very good plugin manager, only supports git
"       Need to look into revision support, doesn't work at this time
"       https://github.com/gmarik/vundle
"   Pathogen:
"       A manual alternative to Vundle
"       https://github.com/tpope/vim-pathogen
"   vim-startify:
"       Nicer homepage with MRU files TODO
"       https://github.com/mhinz/vim-startify
"   vim-gutentags:
"       Ctags background generation & updating TODO
"       https://github.com/ludovicchabant/vim-gutentags
"   ag.vim (Silver Searcher):
"       Searches code quickly, faster than grep
"       https://github.com/rking/ag.vim
"   linux-coding-style:
"       C Files for kernel coding style
"       https://github.com/vivien/vim-addon-linux-coding-style
"   Cmd Alias:
"       Better command remapping instead of cabbr
"       http://www.vim.org/scripts/script.php?script_id=746
"       https://github.com/vim-scripts/cmdalias.vim
"   CtrlP Switcher:
"       Finds files in the tree similar to current buffer
"       https://github.com/ivan-cukic/vim-ctrlp-switcher
"   SnipMate:
"       Allows you to expand boilerplate code
"       https://github.com/msanders/snipmate.vim
"       Usage: http://www.bestofvim.com/plugin/snipmate/
"       Related: https://github.com/scrooloose/snipmate-snippets
"   EasyMotion
"       Provides alternative motion for word jumping
"       Use <Leader><Leader>w to jump then select
"       https://github.com/Lokaltog/vim-easymotion
"   Golden View:
"       Based on golden ratio for windows
"       https://github.com/zhaocai/GoldenView.vim
"   Golden Ratio:
"       Plugin that resizes windows on focus gain
"       https://github.com/roman/golden-ratio
"   html5.vim:
"       Provides better highlighting for new html5 elements
"       https://github.com/Sothree/html5.vim
"   vim-css-color:
"       Provides highlighting of color codes like hex and regular words like red
"       https://github.com/ap/vim-css-color
"   vim-css3-syntax:
"       Provides better highlighting for css3 files
"       https://github.com/hail2u/vim-css3-syntax
"   vim-javascript:
"       Has some improvements to syntax and indents
"       https://github.com/pangloss/vim-javascript
"   jshint:
"       Provides javascript checking, requires node.js and other installation steps
"       https://github.com/Shutnik/jshint2.vim
"   jQuery:
"       Plugin provides better highlighting for jQuery
"       https://github.com/vim-scripts/jQuery
"   php.vim:
"       Improved php syntax files
"       https://github.com/elzr/vim-json
"   vim-ruby:
"       Provides better syntax, indent and config for ruby dev
"       https://github.com/vim-ruby/vim-ruby/wiki/VimRubySupport

" }}}
" Notes To Remember
"""""""""""""""""""
" {{{

" * To indent:
"       5>>: Indent next 5 lines 1 tab
"       5<<: De-Indent next 5 lines 1 tab
"
" * Use :help [option|key] to get info
"   For plugins: :help syntastic, :help YCM
"
" * To override language specific settings, see ~/.vim/ftplugin for lang files
"
" * With auto indent on, need to use: set paste|nopaste or <F2> to toggle
"   paste mode that will prevent the auto indenting/format
"
" * See scrolloff value for interesting effect on vim
"   Keeps certain amount of lines always below cursor when scrolling
"
" * See list for ability to see trailing whitespace
"
" * Omni complete within file: <CTRL> + p, <CTRL> + n for previous and following identifier
"
" * To see all errors list:
"   open -> :Errors
"   close -> :lclose
"   NB: Overrides location list when called
"
" * Code comment:
"   current line -> , c c
"   block comment (with visual) -> V (select) , c c
"   toggle comment for lines: , c i
"
" * Reindent a file:
"       Whole File: ,t
"       Some Lines: <movement>=
"
" * To see folded code:
"       za
"
" * To see conflicting maps:
"       :verbose map <Leader>jd
"
" * To repeat last command (colon): `@:`, to repeat last register `@@`.
"
" * To fix tabs, see `retab`. By default, %retab!
"
" * To paste yanked text in for Command, Ctrl + R then " (double quote)
"
" * With cursor over work, push K in nmormal mode, opens manpage

" }}}

" }}}
" vim: set foldmethod=marker:
