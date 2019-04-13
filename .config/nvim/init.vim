if &compatible
  set nocompatible
endif


" --- Dein config
set runtimepath+=/home/silvus/.config/nvim/dein/repos/github.com/Shougo/dein.vim

if dein#load_state('/home/silvus/.config/nvim/dein')
  call dein#begin('/home/silvus/.config/nvim/dein')

  call dein#add('/home/silvus/.config/nvim/dein/repos/github.com/Shougo/dein.vim')

  " Visuals
  call dein#add('ap/vim-buftabline')
  call dein#add('itchyny/lightline.vim')
  call dein#add('arcticicestudio/nord-vim')
  call dein#add('altercation/vim-colors-solarized')

  " Wiki
  call dein#add('vimwiki/vimwiki')

  " Auto completion
  call dein#add('shougo/deoplete.nvim')
  call dein#add('deoplete-plugins/deoplete-jedi')
  call dein#add('autozimu/LanguageClient-neovim', {'build': 'bash install.sh', 'rev': 'next'})

  " Utils
  call dein#add('shougo/denite.nvim')
  call dein#add('raghur/fruzzy')
  call dein#add('mileszs/ack.vim')

  " Git
  call dein#add('tpope/vim-fugitive')
  call dein#add('airblade/vim-gitgutter')

  " Language specific
  call dein#add('rust-lang/rust.vim')
  call dein#add('alvan/vim-closetag')
  call dein#add('lervag/vimtex')


  call dein#end()
  call dein#save_state()
endif

" Required:
filetype plugin indent on
syntax enable

if dein#check_install()
  call dein#install()

  call fruzzy#install()
endif


" --- Vim configuration

" Line numbers
set number relativenumber
set nu rnu

"Automatically swich between line number types
augroup numbertoggle
    autocmd!
    autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
    autocmd BufLeave,FocusLost,InsertEnter * set norelativenumber
augroup END

" Allow to change away from unsaved buffer
set hidden
" Buffer switching mappings
nnoremap <BS> :b #<CR>
nnoremap <C-q> :bp<CR>
nnoremap <C-e> :bn<CR>

" Window switching mappings
nmap <C-w> :wincmd k<CR>
nmap <C-a> :wincmd h<CR>
nmap <C-s> :wincmd j<CR>
nmap <C-d> :wincmd l<CR>

" Colorscheme
colorscheme nord
let g:solarized_termcolors=256

" Tab settings
set tabstop=4
set shiftwidth=4
set expandtab

" Line length and paragraph formatting
set textwidth=100
set formatoptions-=t

" Cursor distance from edge
set scrolloff=10

" --- Buftabline configuration
let g:buftabline_numbers = 2
let g:buftabline_indicators = 1

" --- Vimwiki configuration

" De-highlight checked check boxes
let g:vimwiki_hl_cb_checked=2

" Change html output to be inside repository
let g:vimwiki_list = [{'path': '~/vimwiki', 'path_html': '~/vimwiki/html/', 'template_path': '~/vimwiki/templates/', 'template_default': 'default', 'template_ext': '.html'}]

" --- Deoplete configuration
call deoplete#enable()

" --- Language server configuration
let g:LanguageClient_serverCommands = {
            \ 'rust': ['rustup', 'run', 'nightly', 'rls'],
            \ }

" --- Denite configuration
call denite#custom#var('file/rec', 'command',
            \ ['ag', '--follow', '--nocolor', '--nogroup', '--hidden', '--skip-vcs-ignores', '--ignore-dir', '__pycache__', '--ignore-dir', 'target', '--ignore-dir', '.git', '-g', ''])
call denite#custom#source('_', 'matchers', ['matcher/fruzzy'])
let g:fruzzy#usenative = 1

nmap <C-p> :Denite file/rec<CR>

" --- Rust.vim configuration
let g:rustfmt_autosave = 1
let g:rustfmt_emit_files=1

" --- Lightline configuration
let g:lightline = {
            \ 'colorscheme': 'wombat',
            \ 'active': {
            \   'left': [['mode', 'paste'], ['readonly', 'filename', 'modified']],
            \   'right': [['lineinfo', 'percent'], ['fileformat', 'fileencoding', 'filetype'], ['gitbranch']],
            \ },
            \ 'component_function': {
            \   'gitbranch': 'fugitive#head',
            \ },
            \ }

" --- Ack.vim configuration
if executable('ag')
    let g:ackprg = 'ag --vimgrep'
endif
