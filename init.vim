" Specify a directory for plugins
call plug#begin('~/.vim/plugged')

" conquer of complition
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" NERDTree navigation
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'ryanoasis/vim-devicons'
Plug 'airblade/vim-gitgutter'
Plug 'ctrlpvim/ctrlp.vim' " fuzzy find files
Plug 'scrooloose/nerdcommenter'
Plug 'christoomey/vim-tmux-navigator'

"show line indentation
Plug 'Yggdroot/indentLine'

" the silver searcher plugin for vim
"Plug 'mileszs/ack.vim'
"see origin for dependencies: https://www.chrisatmachine.com/Neovim/08-fzf/
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'airblade/vim-rooter'

" prittier
Plug 'prettier/vim-prettier', { 'do': 'npm install' }

"smooth scrolling
Plug 'terryma/vim-smooth-scroll'

" git wrapper
Plug 'tpope/vim-fugitive'

" react snippets
Plug 'SirVer/ultisnips'
Plug 'mlaursen/vim-react-snippets'

" themes
Plug 'morhetz/gruvbox'
Plug 'joshdick/onedark.vim'
Plug 'tomasiser/vim-code-dark'
Plug 'altercation/vim-colors-solarized'
Plug 'kaicataldo/material.vim', { 'branch': 'main' }
Plug 'folke/tokyonight.nvim'

" syntax heighliter
Plug 'HerringtonDarkholme/yats.vim' " TS Syntax
Plug 'maxmellon/vim-jsx-pretty'
Plug 'yuezk/vim-js'

"error presentation
Plug 'kyazdani42/nvim-web-devicons'
Plug 'folke/trouble.nvim'


"airline (status bar on bottom)
"Plug 'vim-airline/vim-airline'
"Plug 'vim-airline/vim-airline-themes'
Plug 'jreybert/vimagit'

"lua line
Plug 'hoob3rt/lualine.nvim'
Plug 'kyazdani42/nvim-web-devicons'

" easy motion
Plug 'easymotion/vim-easymotion'


" Initialize plugin system
call plug#end()

""""""""""""""""""""""""""""""""""""""""""""lualine{{
lua << EOF
require'lualine'.setup {
    options = {
      theme = 'tokyonight',
      section_separators = {'', ''},
      component_separators = {'', ''},
      disabled_filetypes = {},
      icons_enabled =true,
    },
    sections = {
      lualine_a = { {'mode', {upper=true,},}, },
      lualine_b = { {'branch', {icon= '',}, }, },
      lualine_c = { { 'filename', {file_status=true,},}, { filetype }, },
      lualine_x = { {'diagnostics', {sources={'coc'}}},},
      lualine_y = { 'progress' },
      lualine_z = { 'location'  },
    },
    inactive_sections = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = { 'filename' },
      lualine_x = { 'location' },
      lualine_y = {},
      lualine_z = {},
    },
  extensions = { 'fzf' },
    }
EOF
"""""""""""""""""""""""""""""""""""""""""""""""""""""""}}

""""""""""""""""""""""""""""""""""""""""NERD Commenter{{{
let g:NERDCreateDefaultMappings = 1
nmap <C-n> :NERDTreeToggle<CR>
vmap ++ <plug>NERDCommenterToggle

""""""""""""""""""""""""""""""""""""""""""""""""""""""}}}


""""""""""""""""""""""""""""""""""""""""Line Indentation{{{
let g:indentLine_char_list = ['|', '¦', '┆', '┊']
""""""""""""""""""""""""""""""""""""""""""""""""""""""}}}

""""""""""""""""""""""""""""""""""""""""basic mapping{{
"mapping leader to space
let mapleader =" "

"map leader p and leader P to paste what was yanked, not deleted
nmap <Leader>p "0p
nmap <Leader>P "0P


"map m anf M to ; and ,
nnoremap m ;
nnoremap M ,
vnoremap m ;
vnoremap M ,

"jump list movements
nnoremap > <C-o>
nnoremap < <C-i>

"open new tab
nnoremap <silent> <Leader>n :tabnew<CR>


"mapping leader e to coc dignostics
nnoremap <silent> <Leader>e :CocDiagnostics<CR>

" map esc key to jj
inoremap jj <Esc>
"
" Windows mappings {{{
nnoremap <Leader><Leader> <C-^>
nnoremap <tab> <c-w>w
nnoremap <c-w><c-c> <c-w>c

" Delete current buffer
nnoremap <silent> <leader>bd :bp <bar> bd #<cr>
" Close current buffer
nnoremap <silent> <leader>bc :close<cr>

" Split navigations mappings
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

set splitbelow
set splitright

" }}}

" Grep {{{
" This is only availale in the quickfix window, owing to the filetype
" restriction on the autocmd (see below).
function! <SID>OpenQuickfix(new_split_cmd)
  " 1. the current line is the result idx as we are in the quickfix
  let l:qf_idx = line('.')
  " 2. jump to the previous window
  wincmd p
  " 3. switch to a new split (the new_split_cmd will be 'vnew' or 'split')
  execute a:new_split_cmd
  " 4. open the 'current' item of the quickfix list in the newly created buffer
  "    (the current means, the one focused before switching to the new buffer)
  execute l:qf_idx . 'cc'
endfunction

augroup grep_augroup
    autocmd!
    autocmd QuickFixCmdPost [^l]* copen
    autocmd QuickFixCmdPost l*    lopen
    autocmd FileType qf nnoremap <buffer> <C-v> :call <SID>OpenQuickfix("vnew")<CR>
    autocmd FileType qf nnoremap <buffer> <C-x> :call <SID>OpenQuickfix("split")<CR>
augroup END

" Set grepprg as RipGrep or ag (the_silver_searcher), fallback to grep
if executable("rg")
    let &grepprg='rg --vimgrep --no-heading --smart-case --hidden --follow -g "!{' . &wildignore . '}" $*'
    set grepformat=%f:%l:%c:%m,%f:%l:%m
elseif executable("ag")
    let &grepprg='ag --vimgrep --smart-case --hidden --follow --ignore "!{' . &wildignore . '}" $*'
    set grepformat=%f:%l:%c:%m
else
    let &grepprg='grep -n -r --exclude=' . shellescape(&wildignore) . ' $* .'
endif

function s:RipGrepCWORD(bang, visualmode, ...) abort
  let search_word = a:1

  if a:visualmode
    " Get the line and column of the visual selection marks
    let [lnum1, col1] = getpos("'<")[1:2]
    let [lnum2, col2] = getpos("'>")[1:2]

    " Get all the lines represented by this range
    let lines = getline(lnum1, lnum2)

    " The last line might need to be cut if the visual selection didn't end on the last column
    let lines[-1] = lines[-1][: col2 - (&selection == 'inclusive' ? 1 : 2)]
    " The first line might need to be trimmed if the visual selection didn't start on the first column
    let lines[0] = lines[0][col1 - 1:]

    " Get the desired text
    let search_word = join(lines, "\n")
  endif
  if search_word == ""
    let search_word = expand("<cword>")
  endif
  echom "Searching for " . search_word
  " Silent removes the "press enter to continue" prompt, and band (!) is for
  " not jumping to the first result
  let grepcmd = "silent grep" . a:bang ." -- " . shellescape(search_word)
  execute grepcmd
endfunction
command! -bang -range -nargs=? RipGrepCWORD call <SID>RipGrepCWORD("<bang>", v:false, <q-args>)
command! -bang -range -nargs=? RipGrepCWORDVisual call <SID>RipGrepCWORD("<bang>", v:true, <q-args>)
nmap <c-f> :RipGrepCWORD!<Space>
vmap <c-f> :RipGrepCWORDVisual!<cr>
" }}}

" Highlight word under cursor {{{
function! HighlightWordUnderCursor()
    if getline(".")[col(".")-1] !~# '[[:punct:][:blank:]]'
        hi MatchWord cterm=undercurl gui=undercurl guibg=#3b404a
        exec 'match' 'MatchWord' '/\V\<'.expand('<cword>').'\>/'
    else
        match none
    endif
endfunction

augroup Start
  autocmd!
  autocmd! CursorHold,CursorHoldI * call HighlightWordUnderCursor()
augroup END
" }}}

" Diff with last save function {{{
function! s:DiffWithSaved()
    let filetype=&ft
    diffthis
    vnew | r # | normal! 1Gdd
    exe "setlocal bt=nofile bh=wipe nobl noswf ro foldlevel=999 ft=" . filetype
    diffthis
    nnoremap <buffer> q :bd!<cr>
    augroup ShutDownDiffOnLeave
        autocmd! * <buffer>
        autocmd BufDelete,BufUnload,BufWipeout <buffer> wincmd p | diffoff |
                    \wincmd p
    augroup END

    wincmd p
endfunction
com! DiffSaved call s:DiffWithSaved()
nnoremap <leader>ds :DiffSaved<cr>
" }}}
" Insert mappings {{{

" Paste in insert mode
inoremap <c-v> <c-r>"

if empty(mapcheck('<C-U>', 'i'))
    inoremap <C-U> <C-G>u<C-U>
endif
if empty(mapcheck('<C-W>', 'i'))
    inoremap <C-W> <C-G>u<C-W>
endif

" }}}
"
" Map 0 to first non-blank character
nnoremap 0 ^
" Move to the end of the line
nnoremap E $
vnoremap E $

" Map dp and dg with leader for diffput and diffget
nnoremap <leader>dp :diffput<cr>
nnoremap <leader>dg :diffget<cr>
nnoremap <leader>du :diffupdate<cr>
nnoremap <leader>dn :windo diffthis<cr>
nnoremap <leader>df :windo diffoff<cr>

" Map enter to no highlight
nnoremap <silent> <CR> :nohlsearch<CR><CR>

" Search mappings {{{
nnoremap <silent> * :execute "normal! *N"<cr>
nnoremap <silent> # :execute "normal! #n"<cr>

nnoremap <expr> n  'Nn'[v:searchforward]
xnoremap <expr> n  'Nn'[v:searchforward]
onoremap <expr> n  'Nn'[v:searchforward]

nnoremap <expr> N  'nN'[v:searchforward]
xnoremap <expr> N  'nN'[v:searchforward]
onoremap <expr> N  'nN'[v:searchforward]

" Search visually selected text with // or * or #
vnoremap // y/\V<C-R>=escape(@",'/\')<CR><CR>

vnoremap <silent> * :<C-U>
            \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
            \gvy/<C-R>=&ic?'\c':'\C'<CR><C-R><C-R>=substitute(
            \escape(@", '/\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
            \gVzv:call setreg('"', old_reg, old_regtype)<CR>
vnoremap <silent> # :<C-U>
            \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
            \gvy?<C-R>=&ic?'\c':'\C'<CR><C-R><C-R>=substitute(
            \escape(@", '?\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
            \gVzv:call setreg('"', old_reg, old_regtype)<CR>

" }}}
" Map - to move a line down and _ a line up
" nnoremap -  :<c-u>execute 'move +'. v:count1<cr>
" nnoremap _  :<c-u>execute 'move -1-'. v:count1<cr>
nnoremap - "ldd$"lp
nnoremap _ "ldd2k"lp

" Exit insert mode
inoremap jk <esc>

" " Copy visual selection to clipboard
 vnoremap <leader>y "*y

" Search and Replace {{{
nnoremap <Leader>r :.,$s?<C-r><C-w>?<C-r><C-w>?gc<Left><Left><Left>
" vnoremap <Leader>r :%s/<C-r><C-w>//g<Left><Left>
vnoremap <leader>r "hy:.,$s?<C-r>h?<C-r>h?gc<left><left><left>

" Special filetypes {{{
augroup special_filetype
    au!
    autocmd BufNewFile,BufRead *yaml setf yaml
    autocmd FileType json syntax match Comment +\/\/.\+$+
    autocmd BufNewFile,BufRead aliases.sh setf zsh
    autocmd FileType javascript set filetype=javascriptreact | set iskeyword+=-
augroup end
let g:sh_fold_enabled = 4

com! FormatJSON exe '%!python -m json.tool'

function FormatEqual() abort
  let save_cursor = getcurpos()
  normal! gg=G
  call setpos('.', save_cursor)
endfunction

" }}}

" Vim smooth scroll {{{
noremap <silent> <c-u> :call smooth_scroll#up(&scroll, 15, 2)<CR>
noremap <silent> <c-d> :call smooth_scroll#down(&scroll, 15, 2)<CR>
" }}}
"""""""""""""""""""""""""""""""""""""""""""""}}


"""""""""""""""""""""""""""""""""""""""""basic options{{
:set nu  " show number of current line
:set hidden " keeps all opened files in background
:set scrolloff=8 " will start scrolling down when your 8 lines from end of screen

set relativenumber

set smarttab
set cindent
set tabstop=2
set shiftwidth=2
" always uses spaces instead of tab characters
set expandtab
set hidden " Some servers have issues with backup files, see #649 set nobackup set nowritebackup " Better display for messages set cmdheight=2 " You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
set signcolumn=yes

set nocompatible
syntax enable

set number         " Show current line number
set relativenumber " Show relative line numbers
set linebreak      " Avoid wrapping a line in the middle of a word.
set nowrap
set cursorcolumn
set cursorline     " Add highlight behind current line
" hi cursorline cterm=none term=none
" highlight CursorLine guibg=#303000 ctermbg=234
set hlsearch       " highlight reg. ex. in @/ register
set incsearch      " Search as characters are typed
set ignorecase     " Search case insensitive...
set smartcase      " ignore case if search pattern is all lowercase,
                   " case-sensitive otherwise
set autoread       " Re-read file if it was changed from the outside
set scrolloff=7    " When about to scroll page, see 7 lines below cursor
set cmdheight=1    " Height of the command bar
set hidden         " Hide buffer if abandoned
set showmatch      " When closing a bracket (like {}), show the enclosing
                   " bracket for a brief second
set nostartofline  " Stop certain movements from always going to the first
                   " character of a line.
set confirm        " Prompt confirmation if exiting unsaved file
set lazyredraw     " redraw only when we need to.
set noswapfile
set nobackup
set nowritebackup
set wildmenu       " Displays a menu on autocomplete
set wildmode=longest:full,full " on first <Tab> it will complete to the
                               " longest common string and will invoke wildmenu
set title          " Changes the iterm title
set showcmd
set guifont=:h
set mouse=a
set undofile       " Enables saving undo history to a file
set encoding=utf-8
set fileencodings=utf-8,cp1251
set visualbell     " Use visual bell instead of beeping

if has('nvim')
    set shortmess+=c   " don't give |ins-completion-menu| messages.
    set shortmess-=l
endif

" Ignore node_modules
set wildignore+=**/node_modules/**
set wildignore+=.hg,.git,.svn,*.DS_Store,*.pyc

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

if v:version > 703 || v:version == 703 && has("patch541")
    set formatoptions+=j " Delete comment character when joining commented lines
endif

filetype plugin on
filetype plugin indent on

set list
set listchars=trail:·,precedes:«,extends:»,eol:↲,tab:▸\

set path+=** " When searching, search also subdirectories

" Set python path
if executable("/usr/local/bin/python3")
    let g:python3_host_prog="/usr/local/bin/python3"
elseif executable("/usr/bin/python3")
    let g:python3_host_prog="/usr/bin/python3"
endif

" Auto load file changes when focus or buffer is entered
au FocusGained,BufEnter * :checktime

if &history < 1000
    set history=1000
endif

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved. {{{
  if has("patch-8.1.1564")
    " Recently vim can merge signcolumn and number column into one
    set signcolumn=number
  else
    set signcolumn=yes
  endif
" }}}

" Set relativenumber when focused {{{
augroup numbertoggle
    autocmd!
    autocmd BufEnter,FocusGained,InsertLeave * set number relativenumber
    autocmd BufLeave,FocusLost,InsertEnter   * set number norelativenumber
augroup END
" }}}
"""""""""""""""""""""""""""""""""""""""""""""""""""""""}}


""""""""""""""""""""""""""""""""""""colorscheme and styling{{
let g:tokyonight_style = "night"
let g:tokyonight_sidebars = [ "qf", "vista_kind", "terminal", "packer" ]
colorscheme tokyonight
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""}}

"""""""""""""""""""""""""""""""""""""""""""""""""easy motion{{
" <Leader>f{char} to move to {char}
map  <Leader>f <Plug>(easymotion-bd-f)
nmap <Leader>f <Plug>(easymotion-overwin-f)

" s{char}{char} to move to {char}{char}
nmap s <Plug>(easymotion-overwin-f2)

" Move to line
map <Leader>L <Plug>(easymotion-bd-jk)
nmap <Leader>L <Plug>(easymotion-overwin-line)

" Move to word
map  <Leader>w <Plug>(easymotion-bd-w)
nmap <Leader>w <Plug>(easymotion-overwin-w)
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""}}

""""""""""""""""""""""""""""""""""""""""""""""""""""fzf{{
" This is the default extra key bindings
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }
"
" Enable per-command history.
" CTRL-N and CTRL-P will be automatically bound to next-history and
" previous-history instead of down and up. If you don't like the change,
" explicitly bind the keys to down and up in your $FZF_DEFAULT_OPTS.
let g:fzf_history_dir = '~/.local/share/fzf-history'

map <leader>b :Buffers<CR>
nnoremap <C-f> :Rg<CR>


let g:fzf_tags_command = 'ctags -R'
" Border color
let g:fzf_layout = {'up':'~90%', 'window': { 'width': 0.8, 'height': 0.8,'yoffset':0.5,'xoffset': 0.5, 'highlight': 'Todo', 'border': 'sharp' } }

let $FZF_DEFAULT_OPTS = '--layout=reverse --info=inline'
let $FZF_DEFAULT_COMMAND="rg --files --hidden"


" Customize fzf colors to match your color scheme
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

"Get Files
command! -bang -nargs=? -complete=dir Files
    \ call fzf#vim#files(<q-args>, fzf#vim#with_preview({'options': ['--layout=reverse', '--info=inline']}), <bang>0)


" Get text in files with Rg
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
  \   fzf#vim#with_preview(), <bang>0)

" Ripgrep advanced
function! RipgrepFzf(query, fullscreen)
  let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case %s || true'
  let initial_command = printf(command_fmt, shellescape(a:query))
  let reload_command = printf(command_fmt, '{q}')
  let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction

command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)

" Git grep
command! -bang -nargs=* GGrep
  \ call fzf#vim#grep(
  \   'git grep --line-number '.shellescape(<q-args>), 0,
  \   fzf#vim#with_preview({'dir': systemlist('git rev-parse --show-toplevel')[0]}), <bang>0)

" undo after coding in insert mode will not undo all text but every word
" seperated by spaces
inoremap <space> <C-G>u<space>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""}}

""""""""""""""""""""""""""""""""""""""""""""""""""""""" Nerd Tree {{{
"
"open nerdtree automaticalli
"autocmd StdinReadPre * let s:std_in=1
"autocmd VimEnter * NERDTree
nnoremap <silent> <Leader>v :NERDTreeFind<CR>
let g:NERDTreeChDirMode = 2
let g:NERDTreeHijackNetrw=0
" Show hidden files
let NERDTreeShowHidden=1
let g:NERDTreeDirArrowExpandable = '⇾'
let g:NERDTreeDirArrowCollapsible = '⤓'
let NERDTreeHighlightCursorline = 1
let NERDTreeShowLineNumbers=1
let g:NERDTreeGitStatusUseNerdFonts = 1
" let g:NERDTreeGitStatusConcealBrackets = 1
autocmd FileType nerdtree setlocal relativenumber

" Set icon for Jenkinsfile
let g:WebDevIconsUnicodeDecorateFileNodesPatternSymbols = {}
let g:WebDevIconsUnicodeDecorateFileNodesPatternSymbols['Jenkinsfile'] = ''
let g:WebDevIconsUnicodeDecorateFileNodesPatternSymbols['\..*ignore.*'] = ''

let g:NERDTreePatternMatchHighlightColor = {}
let g:NERDTreePatternMatchHighlightColor['\..*ignore.*'] = 'EE6E73'
let g:NERDTreePatternMatchHighlightColor['Jenkinsfile'] = '62a2bf'

" If more than one window and previous buffer was NERDTree, go back to it.
" autocmd BufEnter * if bufname('#') =~# "^NERD_tree_" && winnr("$") > 1 | b# | endif

" Close VIM if NERDTree is the only buffer left
autocmd BufEnter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" Check if NERDTree is open or active
function! IsNERDTreeOpen()
    return exists("t:NERDTreeBufName") && (bufwinnr(t:NERDTreeBufName) != -1)
endfunction

" Call NERDTreeFind iff NERDTree is active, current window contains a modifiable
" file, and we're not in vimdiff
function! SyncTree()
    if &modifiable && IsNERDTreeOpen() && strlen(expand('%')) > 0 && !&diff
        NERDTreeFind
        wincmd p
    endif
endfunction

" Highlight currently open buffer in NERDTree
autocmd BufEnter * call SyncTree()

function! ToggleNerdTree()
    set eventignore=BufEnter
    NERDTreeToggle
    set eventignore=
endfunction
nmap <C-n> :call ToggleNerdTree()<CR>

function! ToggleNerdFugitiveVimStartup(timer)
    let l:firstbuf = bufnr('%')
    echom "firstbuf ". l:firstbuf
    Git
    let l:gitbuf = bufnr('%')
    hide
    call ToggleNerdTree()
    new
    exe 'buf' . l:gitbuf
    set buflisted
    let g:git_opened_by_func = 1
    let l:winids = win_findbuf(l:firstbuf)
    call win_gotoid(l:winids[0])
endfunc

function! CloseNERDGitWindows() abort
    if buflisted(bufname('.git/index'))
        buf .git/index
        bd .git/index
    endif
    if (winnr("$") != 1) && exists(":NERDTreeClose")
        NERDTreeClose
    endif
endfunction

" Reorganize all buffers
function! ReorganizeAllWindows(timer)
    call CloseNERDGitWindows()
    call ToggleNerdFugitiveVimStartup("")
endfunction

nnoremap <leader>ow :call ReorganizeAllWindows("")<cr>
nnoremap <leader>cw :call CloseNERDGitWindows()<cr>

let g:NERDTreeIgnore = ['^node_modules$']


" sync open file with NERDTree
" " Check if NERDTree is open or active
function! IsNERDTreeOpen()
  return exists("t:NERDTreeBufName") && (bufwinnr(t:NERDTreeBufName) != -1)
endfunction

" Call NERDTreeFind iff NERDTree is active, current window contains a modifiable
" file, and we're not in vimdiff
function! SyncTree()
  if &modifiable && IsNERDTreeOpen() && strlen(expand('%')) > 0 && !&diff
    NERDTreeFind
    wincmd p
  endif
endfunction

" Highlight currently open buffer in NERDTree
autocmd BufEnter * call SyncTree()
"""""""""""""""""""""""""""""""""""""""""""""""""""""""" }}}

""""""""""""""""""""""""""""""""""""""""""""""""""" vim-prettier{{
let g:prettier#quickfix_enabled = 0
let g:prettier#quickfix_auto_focus = 0
" prettier command for coc
command! -nargs=0 Prettier :CocCommand prettier.formatFile
" run prettier on save
let g:prettier#autoformat = 0
:autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue,*.yaml,*.html PrettierAsync
" line width for prettier
let g:prettier#config#print_width = '70'
""""""""""""""""""""""""""""""""""""""""""""""""""""""}}


"""""""""""""""""""""""""""""""""""""""""""""""""""" ctrlp{{
let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""}}


""""""""""""""""""""""""""""""""""""""""""""""""""""""" coc {{{
let g:coc_global_extensions = [
            \    "coc-cfn-lint",
            \    "coc-css",
            \    "coc-diagnostic",
            \    "coc-dictionary",
            \    "coc-docker",
            \    "coc-emmet",
            \    "coc-emoji",
            \    "coc-eslint",
            \    "coc-groovy",
            \    "coc-highlight",
            \    "coc-html",
            \    "coc-json",
            \    "coc-markdownlint",
            \    "coc-marketplace",
            \    "coc-neosnippet",
            \    "coc-pairs",
            \    "coc-prettier",
            \    "coc-python",
            \    "coc-react-refactor",
            \    "coc-scssmodules",
            \    "coc-sh",
            \    "coc-snippets",
            \    "coc-styled-components",
            \    "coc-swagger",
            \    "coc-syntax",
            \    "coc-tabnine",
            \    "coc-tag",
            \    "coc-tsserver",
            \    "coc-yaml"
            \]

augroup format_coc_group
    autocmd!
    " Setup formatexpr specified filetype(s).
    autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
    " Update signature help on jump placeholder.
    autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
    else
        call CocAction('doHover')
    endif
endfunction

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)
" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <F2> <Plug>(coc-rename)


augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end


" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)
""""""""""""""""""""""""""""""""""""""""""""""""" }}}

""""""""""""""""""""""""""""""""""""""" Install all coc plugins {{{

function! InstallAllCocExtensions() abort
  let all_extensions = get(g:, 'coc_global_extensions', [])
  let iterator = 10
  let counter = 0
  for extension in all_extensions
    if counter % iterator == 0
      echom string(all_extensions[counter:counter+iterator-1])
      call coc#util#install_extension([extension])
    endif
    let counter += 1
  endfor
endfunction

command! -bar -complete=custom,s:InstallOptions CocInstallAll
      \ :call InstallAllCocExtensions()

""""""""""""""""""""""""""""""""""""""""""""""""""""" }}}

"""""""""""""""""""""""""""""""""""""""""""""""""style{{
"change line number to get maximum visability
:highlight LineNr guifg=#7aa2f7
hi TabLine      guifg=#7aa2f7 guibg=#222 gui=none ctermfg=254 ctermbg=238 cterm=none
"}}
