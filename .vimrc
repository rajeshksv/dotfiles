" Map leader to ,
let mapleader = ','

" Needed for vim custom icons to work
set encoding=UTF-8

" All vundle stuff - Plugins and their config

set nocompatible              " be iMproved, required for vundle
filetype off                  " required for vundle

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo

" Git plugin for vim
Plugin 'tpope/vim-fugitive'

" Plugin for file navigation in vim
Plugin 'scrooloose/nerdtree'
map <leader>n :NERDTreeFind<cr>
map <C-n> :NERDTreeToggle<CR>

" Open file from Nerd tree in split/tab using v/x/t
let g:NERDTreeMapOpenSplit = 'x'
let g:NERDTreeMapOpenVSplit = 'v'
let NERDTreeShowHidden=1

" NERDTress File highlighting
function! NERDTreeHighlightFile(extension, fg, bg, guifg, guibg)
 exec 'autocmd filetype nerdtree highlight ' . a:extension .' ctermbg='. a:bg .' ctermfg='. a:fg .' guibg='. a:guibg .' guifg='. a:guifg
 exec 'autocmd filetype nerdtree syn match ' . a:extension .' #^\s\+.*'. a:extension .'$#'
endfunction

call NERDTreeHighlightFile('jade', 'green', 'none', 'green', '#151515')
call NERDTreeHighlightFile('ini', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('md', 'blue', 'none', '#3366FF', '#151515')
call NERDTreeHighlightFile('yml', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('config', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('config', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('conf', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('json', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('html', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('styl', 'cyan', 'none', 'cyan', '#151515')
call NERDTreeHighlightFile('css', 'cyan', 'none', 'cyan', '#151515')
call NERDTreeHighlightFile('coffee', 'Red', 'none', 'red', '#151515')
call NERDTreeHighlightFile('js', 'Red', 'none', '#ffa500', '#151515')
call NERDTreeHighlightFile('php', 'Magenta', 'none', '#ff00ff', '#151515')

" NerdTree Mappings :help NERDTree-t
" For some wierd reason control characters are appearing. Removing them
let g:NERDTreeNodeDelimiter = "\u00a0"


" Plugin for File finder in vim
Plugin 'ctrlpvim/ctrlp.vim'
" Ctrp Mappings :help ctrlp-mappings
" Fasten up ctrl p using ag tool. Hence, ag is mandatory to install this
let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
let g:ctrlp_working_path_mode = 'ra'
" let g:ctrlp_working_path_mode = 0
let g:ctrlp_map = '<c-j>'
" let g:ctrlp_cmd = 'CtrlPMixed'
" let g:ctrlp_cmd = 'CtrlP'
" let g:ctrlp_root_directory = '/Users/rajesh.kaki/Flipkart/'
" noremap <C-p> :CtrlP /Users/rajesh.kaki/Flipkart/<CR>
noremap <C-p> :CtrlP<CR>
noremap <C-h> :CtrlPMRU <CR>
noremap <C-b> :CtrlPBuffer <CR>
" noremap <C-p> :CtrlP <CR>
" More search results
let g:ctrlp_match_window = 'min:4,max:10'

" Plugin for vim search
" Ag (better) search tool in vim. Ack vim plugin integrating with ag search tool
" https://github.com/ggreer/the_silver_searcher
" Ack is alternative to grep
Plugin 'mileszs/ack.vim'
let g:ackprg = 'ag --nogroup --nocolor --column'
nnoremap <leader>g :Ack
let g:ack_mappings = { "x": "<C-W><CR><C-W>K", "X": "<C-W><CR><C-W>K<C-W>b" }

" Replace vim grep as well with ag
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor
endif

" Vim statusbar (statusline)
Plugin 'bling/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
set laststatus=2
let g:airline_powerline_fonts = 1
let g:airline_theme='luna'

" Displays indent with vertical lines
" Useful for YAML, YML files
Plugin 'indentLine.vim'

" When you want to copy, you don't want indent lines to be copied as well,
" right! Also remove relative line numbers
nmap <silent> <leader>c :IndentLinesToggle<CR> :se rnu!<CR>

" Plugin for ini folds
Plugin 'matze/vim-ini-fold'

set foldlevel=20
" Fix folds for ini files
syn region dosiniSection start="^\[" end="\(\n\+\[\)\@=" contains=dosiniLabel,dosiniHeader,dosiniComment keepend fold
" ini files in logsvc are inventory files which contains IPs. Hence modify word definition to contain .
" Now search for current word using # or * or ,w works for IPs as well! Yayyy!
autocmd FileType dosini set iskeyword=65-90,95,97-122,48-57,46 "the same: a-z,_,A-Z,0-9,.

" Better yaml folds
Plugin 'pedrohdz/vim-yaml-folds'
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
let g:ale_sign_error = '✘'
let g:ale_sign_warning = '⚠'
let g:ale_lint_on_text_changed = 'never'

" Displays YAML hirearchy at status bar
Plugin 'einenlum/yaml-revealer'

" JSON - Better foldings, displays errors, can conceal quotes for readability
Plugin 'elzr/vim-json'

let g:vim_json_syntax_conceal = 0
setlocal foldmethod=syntax

" Plugin for custom icons
Plugin 'ryanoasis/vim-devicons'
" Post this, you need to change non-ASCII font in iTerm as well
" Vim uses iterm fonts (as with all apps running in iTerm)

" More customization over dev icons
Plugin 'tiagofumo/vim-nerdtree-syntax-highlight'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" To install a plugin
" :source %
" :PluginInstall
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

" ####################################################################################################
" Non vundle stuff
" Enable syntax
syntax enable

set relativenumber      " Set relative line numbers by default
set cursorline          " highlight current line
set wildmenu            " visual autocomplete for command menu
set lazyredraw          " redraw only when we need to.
set showmatch           " highlight matching [{()}]
set ignorecase

" Toggle between relative line numbers, line numbers and no line numbers
nnoremap <silent> <F3> :exec &nu==&rnu? "se nu!" : "se rnu!"<CR>

" Remaping some basic stuff.

" Map jj to escape. No need to hurt your fingers
imap jj <ESC>
imap <C-d> <C-[> dawi
" nmap oo : " Adding this will slow down normal o operation

" In insert or command mode, move normally by using Ctrl
inoremap <C-h> <Left>
inoremap <C-j> <Down>
inoremap <C-k> <Up>
inoremap <C-l> <Right>
cnoremap <C-h> <Left>
cnoremap <C-j> <Down>
cnoremap <C-k> <Up>
cnoremap <C-l> <Right>

filetype plugin indent on
" On pressing tab, insert 2 spaces
set expandtab
" show existing tab with 2 spaces width
set tabstop=2
set softtabstop=2
" when indenting with '>', use 2 spaces width
set shiftwidth=2


" For wierd reason backspace isn't working
set backspace=indent,eol,start

" Rename tmux window with vim file name
autocmd BufReadPost,FileReadPost,BufNewFile,BufEnter * call system("tmux rename-window '" . expand("%:t") . "'")
autocmd VimLeave * call system("tmux rename-window 'tmux'")

" Search current word using easy mapping
nnoremap <leader>w :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>

" To get XML folding working
augroup XML
    autocmd!
    autocmd FileType xml let g:xml_syntax_folding=1
    autocmd FileType xml setlocal foldmethod=syntax
    autocmd FileType xml :syntax on
    autocmd FileType xml :%foldopen!
augroup END


" ################

" Display Vim Top Used Commands when you do <leader>h

function! Vimhelp()
let g:vimHelp="Help:\n
  \ For help with plugin, use :help <<plugin_name>>. Ex: :help fugitive (Don't forget to use tabs)
  \ C-v and then using arrow marks select multiple lines, go to insert mode\n
        \ Using Shift+I and then type # and then Esc to comment multiple lines \n
  \ To resize splits, use :resize +5/-5 or :vertical resize or Ctrl+w -/+ </> \n
        \ c-w left/right arrows or c-w c-w to switch between split screens\n
        \ maximise split c-w |, c-w = restore
  \ < > for next/previous tabs or c-l for previous tab or ,1 ,2 for tab\n
        \ <num>ctrl^ to move to a given buffer
  \ For Ctrl P Use <c-t> or <c-v>, <c-x> to open selected entry in a new tab or in a split\n
        \ Ctrl H to see MRU files, Ctrl b Ctrl b to search in buffers (if you are using tmux) \n
        \ c-f, c-b for switching between MRU and files and buffers in Ctrl P \n
        \ Use <c-p><c-\>w to search for current word in ctrlp (type c-\ to see more options)  \n
        \ Press <c-d> to switch to filename only search instead of full path in CtrlP\n
        \ Use F5 to refresh
  \ Vim Git plugin :Git <<any command>> or even :G <<any command>> instead of :!git <<any command>>
        \ :Git co master or :Git log
        \ More shortcuts like :Gcommit,:Gstatus, :Gblame
        \ Others like :Gwrite (:Git add %), :Gread (:Git checkout %), :Gremove, :Gmv, :Gdiff
  \ c-n for nerd tree, <leader>n for nerd tree with current file as start. r/R for refresh \n
        \ In NERD tree use t, v, x to open selected entry in a new tab or in a split\n
        \ Press m for modify tree i.e., file operations such as create new file \n
  \ <leader>g to grep. o (open), t (open in tab), x (horizontal split), v (vertical split) \n
        \ <leader>w to search for current word \n
  \ <leader>l to toggle line numbers - absolute, relative \n
  \ <leader>c for copying. This will allow copy friendly mode \n
  \ surround - Change "" to ' cs"' (s/"/'/g), ds" (delete ""), ysiw{ or } for space
  \ <leader><leader>w(or b/j/k etc) for easymotion\n
  \ :%norm A* % = for every line, norm = type command, A* = append * to end of line \n
  \ sc for spell check, z= for suggestions , zg for adding word\n
  \ YouCompleteMe is an interesting plugin. Have to look in future\n
  \ "
echo g:vimHelp
endfunction

nnoremap <leader>h :call Vimhelp()<CR>
nnoremap <leader>t :e ~/Flipkart/vimTips<CR>
nnoremap <leader>v :e ~/.vimrc<CR>
" Once you do changes, run source ~/.vimrc for changes to reload
" or so % when you opened .vimrc file

