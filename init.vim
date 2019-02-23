
if &compatible
  set compatible
endif

set runtimepath+=~/.local/share/dein/repos/github.com/Shougo/dein.vim

if dein#load_state('~/.local/share/dein')
  call dein#begin('~/.local/share/dein')
  call dein#add('~/.local/share/dein/repos/github.com/Shougo/dein.vim')

  call dein#add('scrooloose/nerdtree')
  call dein#add('easymotion/vim-easymotion')
  call dein#add('jlanzarotta/bufexplorer')
  "call dein#add('vim-scripts/cscope_macros.vim')
  call dein#add('jsfaint/gen_tags.vim')
  call dein#add('bronson/vim-trailing-whitespace')
  call dein#add('vim-scripts/localrc.vim')
  call dein#add('lambdalisue/vim-unified-diff')
  call dein#add('tpope/vim-fugitive')
  call dein#add('vim-airline/vim-airline')
  call dein#add('airblade/vim-gitgutter')
  call dein#add('Shougo/denite.nvim')

  call dein#end()
  call dein#save_state()
endif

filetype plugin indent on
syntax enable

if dein#check_install()
  call dein#install()
endif

set tabstop=4
set shiftwidth=4
set expandtab
set smarttab

set inccommand=split
set ignorecase
set smartcase

nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

inoremap <silent> jj <ESC>:<C-u>w<CR>
nmap <Esc><Esc> :noh<CR><Esc>

cmap <C-x> <C-r>=expand('%:p:h')<CR>/

set colorcolumn=80

" NERDTree
nnoremap <silent> <C-e> :NERDTreeToggle<CR>
let g:NERDTreeShowBookmarks=1
let g:NERDTreeMapUpdir=''
let g:NERDTreeMapOpenVSplit='<C-o>'
"let g:NERDTreeQuitOnOpen=1
let g:NERDTreeShowHidden=1

" Easy Motion
let g:EasyMotion_leader_key='<Space>'

" gen_tags.vim
let g:gen_tags#gtags_default_map=1
let g:gen_tags#gtags_auto_gen=1

" vim:set ts=2 sw=2:
