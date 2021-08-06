" Specify a directory for plugins
call plug#begin('~/.vim/plugged')

" conquer of complition
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" NERDTree navigation
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'ryanoasis/vim-devicons'
Plug 'airblade/vim-gitgutter'
"Plug 'ctrlpvim/ctrlp.vim' " fuzzy find files
Plug 'scrooloose/nerdcommenter'

"telescope
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

"auto import
Plug 'ludovicchabant/vim-gutentags'
Plug 'kristijanhusak/vim-js-file-import', {'do': 'npm install'}

"show line indentation
Plug 'Yggdroot/indentLine'

"resizing windows with hjkl
Plug 'simeji/winresizer'

"smooth scrolling
Plug 'terryma/vim-smooth-scroll'

" git wrapper
Plug 'tpope/vim-fugitive'

" react snippets
Plug 'SirVer/ultisnips'
Plug 'mlaursen/vim-react-snippets'

" themes
Plug 'folke/tokyonight.nvim'
Plug 'pineapplegiant/spaceduck', { 'branch': 'main' }

"lua line
Plug 'hoob3rt/lualine.nvim'
Plug 'kyazdani42/nvim-web-devicons'

" easy motion
Plug 'easymotion/vim-easymotion'

" syntax heighliter
Plug 'sheerun/vim-polyglot'
Plug 'HerringtonDarkholme/yats.vim' " TS Syntax
Plug 'maxmellon/vim-jsx-pretty'
Plug 'yuezk/vim-js'

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


"break insert undo sequence with space . , ? or !
inoremap , ,<c-g>u
inoremap . .<c-g>u
inoremap ? ?<c-g>u
inoremap ! !<c-g>u
inoremap <space> <space><c-g>u

" map %% to create new file
cnoremap %% <C-R>=fnameescape(expand('%:h')).'/'<cr>
"use that remap to create new file and go to buffer
map <leader>ew :e %%
"create new file and split horizontally
map <leader>es :sp %%
"create new file and split vertically
map <leader>ev :vsp %%
"create new file and open in new tab
map <leader>et :tabe %%

" add symboles arround visually selected text
vnoremap <leader>' <esc>`>a'<esc>`<i'<esc>
vnoremap <leader>" <esc>`>a"<esc>`<i"<esc>
vnoremap <leader>` <esc>`>a`<esc>`<i`<esc>
vnoremap <leader>( <esc>`>a)<esc>`<i(<esc>
vnoremap <leader>[ <esc>`>a]<esc>`<i[<esc>
vnoremap <leader>{ <esc>`>a}<esc>`<i{<esc>

"mapping leader e to coc dignostics
nnoremap <silent> <Leader>e :CocDiagnostics<CR>

"add line under and above without exiting normal mode
nnoremap <silent> <leader>k  :<c-u>put!=repeat([''],v:count)<bar>']+1<cr>
nnoremap <silent> <leader>j  :<c-u>put =repeat([''],v:count)<bar>'[-1<cr>

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
vnoremap - :'<,'> m '>+1<CR>gv
vnoremap _ :'<,'> m '<-2<CR>gv

"keeping cursore centered after jumping in search resoults
nnoremap n nzzzv
nnoremap N Nzzzv
nnoremap J mzJ`z

" " Copy visual selection to clipboard
 vnoremap <leader>y "*y

" Search and Replace {{{
nnoremap <Leader>r :.,$s?<C-r><C-w>?<C-r><C-w>?gc<Left><Left><Left>
" vnoremap <Leader>r :%s/<C-r><C-w>//g<Left><Left>
vnoremap <leader>r "hy:.,$s?<C-r>h?<C-r>h?gc<left><left><left>

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
"let g:tokyonight_style = "night"
let g:tokyonight_sidebars = [ "qf", "vista_kind", "terminal", "packer" ]
colorscheme tokyonight
    "if exists('+termguicolors')
    ""  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    ""  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
    ""  set termguicolors
    "endif

   "colorscheme spaceduck
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
let g:prettier#autoformat = 0
:autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue,*.yaml,*.html Prettier
""""""""""""""""""""""""""""""""""""""""""""""""""""""}}
""""""""""""""""""""""""""""""""""""""""""""""""""" coc{{
" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)
" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
""""""""""""""""""""""""""""""""""""""""""""""""""""""}}
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""}}
"""""""""""""""""""""""""""""""""""""""""""""""""""" telescope{{
nnoremap <silent> <C-p> <cmd>Telescope find_files<cr>
nnoremap <silent> ;r <cmd>Telescope live_grep<cr>
nnoremap <silent> \\ <cmd>Telescope buffers<cr>
nnoremap <silent> ;; <cmd>Telescope help_tags<cr>
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""}}
"""""""""""""""""""""""""""""""""""""""""""""""""style{{
"change line number to get maximum visability
:highlight LineNr guifg=#7aa2f7
hi TabLine      guifg=#7aa2f7 guibg=#222 gui=none ctermfg=254 ctermbg=238 cterm=none
"}}
