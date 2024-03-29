" Section: General Config
" ----------------------------
let mapleader = " "

set shell=bash
set backspace=2   " Backspace deletes like most programs in insert mode
set nobackup
set nowritebackup
set noswapfile    " http://robots.thoughtbot.com/post/18739402579/global-gitignore#comment-458413287
set history=50
set ruler         " show the cursor position all the time
set showcmd       " display incomplete commands
set laststatus=2  " Always display the status line
set autowrite     " Automatically :write before running commands
set noshowmode
set timeoutlen=1000
set ttimeoutlen=0
set tabstop=2
set shiftwidth=2
set shiftround
set expandtab
set scrolloff=3
set list listchars=tab:»·,trail:·  " Display extra whitespace characters
set hidden
set inccommand=nosplit
set omnifunc=syntaxcomplete#Complete

" Line numbers
set number
set numberwidth=5

" Set spellfile to location that is guaranteed to exist, can be symlinked to
" Dropbox or kept in Git and managed outside of thoughtbot/dotfiles using rcm.
set spellfile=$HOME/.vim-spell-en.utf-8.add

" Highlight search matches
set hlsearch
" And search as characters are entered
set incsearch

" Enable persistent undo so that undo history persists across vim sessions
set undofile
set undodir=~/.config/nvim/undo

" Open new split panes to right and bottom, which feels more natural
set splitbelow
set splitright

" Point python checker to homebrew installs`
let g:python3_host_prog = '/usr/bin/python3'
let g:python_host_prog = '/usr/bin/python2'
"

" Configure grep to use The Silver Searcher
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor

  let g:ackprg='ag --vimgrep'

  command! -bang -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!
endif
"
" Configure fzf in vim
let g:rg_command = 'rg --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow --color "always" -g "!{.git,node_modules}" -g "*.{js,json,md,config,py,cpp,c,go,conf}" '

command! -bang -nargs=* F call fzf#vim#grep(g:rg_command .shellescape(<q-args>), 1, <bang>0)
"
"
" Section: Autocommands
" --------------------------
if has("autocmd")
  filetype plugin indent on

  autocmd BufReadPost * "
    " When editing a file, always jump to the last known cursor position.
    " Don't do it for commit messages, when the position is invalid, or when
    " inside an event handler (happens when dropping a file on gvim).
    \ if &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif "

  " Automatically clean trailing whitespace
  autocmd BufWritePre * :%s/\s\+$//e

  autocmd BufRead,BufNewFile COMMIT_EDITMSG call pencil#init({'wrap': 'soft'})
                                        \ | set textwidth=0

  autocmd BufRead,BufNewFile *.md set filetype=markdown

  autocmd BufRead,BufNewFile .eslintrc,.jscsrc,.jshintrc,.babelrc set ft=json

  autocmd BufRead,BufNewFile gitconfig set ft=.gitconfig

endif
"
" Section: External Functions

" Open current file in Marked
function! MarkedPreview()
  :w
  exec ':silent !open -a "Marked 2.app" ' . shellescape('%:p')
  redraw!
endfunction
nnoremap <leader>md :call MarkedPreview()<CR>
"
" Open current file in Chrome
function! OpenInChrome()
  exec ':silent !open -a /Applications/Google\ Chrome.app %'
endfunction
nnoremap <leader>ch :call OpenInChrome()<CR>
"
"
" Section: Load vim-plug plugins

" Specify plugins
call plug#begin()

" UI
Plug 'shaheinm/vim-deus'
Plug 'fenetikm/falcon'
Plug 'morhetz/gruvbox'
Plug 'mhinz/vim-startify'
Plug 'vim-airline/vim-airline'            " Handy info
Plug 'vim-airline/vim-airline-themes'            " Handy info
Plug 'retorillo/airline-tablemode.vim'
Plug 'ryanoasis/vim-webdevicons'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'jez/vim-superman'                   " Man pages in Vim

" Project Navigation
Plug 'junegunn/fzf',                      { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'mhinz/vim-grepper'
Plug 'scrooloose/nerdtree',                { 'on': 'NERDTreeToggle' }
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'vim-scripts/ctags.vim'              " ctags related stuff
Plug 'majutsushi/tagbar'
Plug 'mileszs/ack.vim'

" File Navigation
Plug 'vim-scripts/matchit.zip'            " More powerful % matching
Plug 'easymotion/vim-easymotion'            " Move like the wind!
Plug 'jeffkreeftmeijer/vim-numbertoggle'  " Smarter line numbers
Plug 'wellle/targets.vim'
Plug 'kshenoy/vim-signature'
Plug 'haya14busa/incsearch.vim'           " Better search highlighting

" Editing
Plug 'tpope/vim-surround'                 " Change word surroundings
Plug 'tpope/vim-commentary'               " Comments stuff
Plug 'tpope/vim-repeat'
Plug 'dhruvasagar/vim-table-mode',        { 'on': 'TableModeEnable' }
Plug 'kana/vim-textobj-user'
Plug 'sgur/vim-textobj-parameter'
Plug 'jasonlong/vim-textobj-css'
Plug 'Konfekt/FastFold'
Plug 'editorconfig/editorconfig-vim'
Plug 'simnalamburt/vim-mundo'
Plug 'scrooloose/nerdcommenter'

" Git
Plug 'tpope/vim-fugitive'                 " Git stuff in Vim
Plug 'airblade/vim-gitgutter'
Plug 'junegunn/gv.vim',                   { 'on': 'GV' }
Plug 'jez/vim-github-hub'

" Task Running
Plug 'tpope/vim-dispatch'                 " Run tasks asychronously in Tmux
Plug 'dense-analysis/ale'                           " Linter
Plug 'wincent/terminus'
Plug 'Olical/vim-enmasse'                 " Edit all files in a Quickfix list
Plug 'janko-m/vim-test'

" Autocomplete
Plug 'neoclide/coc.nvim', { 'branch': 'release' }

" Productivity
Plug 'wakatime/vim-wakatime'

" Language Support
" JavaScript
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'posva/vim-vue'
Plug 'rhysd/npm-debug-log.vim'
Plug 'martinda/Jenkinsfile-vim-syntax'

" Handlebars
Plug 'mustache/vim-mustache-handlebars'

" HTML
Plug 'othree/html5.vim',                  { 'for': 'html' }
Plug 'mattn/emmet-vim'

" CSS
Plug 'hail2u/vim-css3-syntax',            { 'for': 'css' }

" Sass
Plug 'cakebaker/scss-syntax.vim'

" Python
Plug 'klen/python-mode',                  { 'for': 'python' }
Plug 'davidhalter/jedi-vim',              { 'for': 'python' }
Plug 'alfredodeza/pytest.vim',            { 'for': 'python' }

" Go
Plug 'fatih/vim-go',                      { 'do': ':GoUpdateBinaries' }
Plug 'mdempsky/gocode', { 'rtp': 'nvim', 'do': '~/.config/nvim/plugged/gocode/nvim/symlink.sh' }

" Markdown
Plug 'reedes/vim-pencil'                  " Markdown, Writing
Plug 'godlygeek/tabular',                 { 'for': 'markdown' } " Needed for vim-markdown
Plug 'plasticboy/vim-markdown',           { 'for': 'markdown' }

" Java
Plug 'artur-shaik/vim-javacomplete2'

" GraphQL
Plug 'jparise/vim-graphql'

call plug#end()

" Load plugin configurations
" For some reason, a few plugins seem to have config options that cannot be
" placed in the `plugins` directory. Those settings can be found here instead.

" vim-airline
let g:airline_powerline_fonts = 1 " Enable the patched Powerline fonts

" emmet-vim
let g:user_emmet_leader_key='<C-E>'

let g:user_emmet_settings = {
  \    'html' : {
  \        'quote_char': "'"
  \    }
  \}


" vim-javacomplete2
autocmd FileType java setlocal omnifunc=javacomplete#Complete
nmap <F4> <Plug>(JavaComplete-Imports-AddSmart)
imap <F4> <Plug>(JavaComplete-Imports-AddSmart)
nmap <F5> <Plug>(JavaComplete-Imports-Add)
imap <F5> <Plug>(JavaComplete-Imports-Add)
nmap <F6> <Plug>(JavaComplete-Imports-AddMissing)
imap <F6> <Plug>(JavaComplete-Imports-AddMissing)
nmap <F7> <Plug>(JavaComplete-Imports-RemoveUnused)
imap <F7> <Plug>(JavaComplete-Imports-RemoveUnused)
let g:JavaComplete_ClasspathGenerationOrder = ['Maven']
"

" Section: Remaps

" Normal Mode Remaps

" Quickly find file in NERDTree
nnoremap <leader>f :NERDTreeFind<CR>

nnoremap <silent> <Space> :nohlsearch<Bar>:echo<CR>

" Smarter pasting
nnoremap <Leader>p :set invpaste paste?<CR>

" Smarter searching
nnoremap ] :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>
nnoremap \ :Ag

" Remap :MundoToggle
nnoremap <leader>u :MundoToggle<CR>
" -- Smart indent when entering insert mode with i on empty lines --------------
function! IndentWithI()
  if len(getline('.')) == 0
    return "\"_ddO"
  else
    return "i"
  endif
endfunction
nnoremap <expr> i IndentWithI()

" save session
nnoremap <leader>s :mksession<CR><Paste>

" Remap the increment and decrement features of Vim
nnoremap <A-a> <C-a>
nnoremap å <C-a>

nnoremap <A-x> <C-x>
nnoremap ≈ <C-x>

" Tab Shortcuts
nnoremap tk :tabfirst<CR>
nnoremap tl :tabnext<CR>
nnoremap th :tabprev<CR>
nnoremap tj :tablast<CR>
nnoremap tn :tabnew<CR>
nnoremap tc :CtrlSpaceTabLabel<CR>
nnoremap td :tabclose<CR>

" EasyMotion config
let g:EasyMotion_do_mapping = 0 " Disable default mappings

" Jump to anywhere you want with minimal keystrokes, with just one key binding.
" `s{char}{label}`
nmap s <Plug>(easymotion-overwin-f)
" or
" `s{char}{char}{label}`
" Need one more keystroke, but on average, it may be more comfortable.
nmap s <Plug>(easymotion-overwin-f2)

" Turn on case insensitive feature
let g:EasyMotion_smartcase = 1

" JK motions: Line motions
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)
"
"
" Insert Mode Remaps

set completeopt-=preview

"
"
" Section: Theme

syntax enable
let g:gruvbox_italic=1
let g:gruvbox_contrast_dark="hard"
let $NVIM_TUI_ENABLE_TRUE_COLOR=1
set t_Co=256
set termguicolors
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
set background=dark
colorscheme gruvbox
let g:deus_termcolors=256

hi Folded ctermbg=NONE guibg=NONE ctermfg=014 guifg=#0087d7
" Airline theme
let g:falcon_airline=1
let g:airline_theme='badwolf'

" Section: Local-Machine Config

if filereadable($DOTFILES . "/nvim/init.local.vim")
  source $DOTFILES/nvim/init.local.vim
endif
"

set fillchars+=vert:\.

