" Vim with all enhancements

" Use the internal diff if available.
" Otherwise use the special 'diffexpr' for Windows.
if &diffopt !~# 'internal'
  set diffexpr=MyDiff()
endif
function MyDiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg1 = substitute(arg1, '!', '\!', 'g')
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg2 = substitute(arg2, '!', '\!', 'g')
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  let arg3 = substitute(arg3, '!', '\!', 'g')
  if $VIMRUNTIME =~ ' '
    if &sh =~ '\<cmd'
      if empty(&shellxquote)
        let l:shxq_sav = ''
        set shellxquote&
      endif
      let cmd = '"' . $VIMRUNTIME . '\diff"'
    else
      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
  else
    let cmd = $VIMRUNTIME . '\diff'
  endif
  let cmd = substitute(cmd, '!', '\!', 'g')
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3
  if exists('l:shxq_sav')
    let &shellxquote=l:shxq_sav
  endif
endfunction

"--------------------------------------------------------
"key mappings
"--------------------------------------------------------
  nnoremap <F2> :e $VIM/init.vim<cr>

"--------------------------------------------------------
"better settings
"--------------------------------------------------------
  set autoindent	" Auto-indent new lines
  set autochdir		" Change working directory to open buffer
  set cursorline
  set hlsearch
  set incsearch
  set ignorecase
  "set number 		"show line number
  set ruler		" Show row and column ruler information
  set shiftwidth=4	" Number of auto-indent spaces
  set smartcase		" Enable smart-case search
  set smartindent	" Enable smart-indent
  set smarttab		" Enable smart-tabs
  set spell		" Enable spell-checking
  set guioptions-=m     "remove menu bar
  set guioptions-=T     "remove toolbar
  set guioptions-=r     "remove right-hand scroll bar
  set guioptions-=L     "remove left-hand scroll bar

"--------------------------------------------------------
"key mapping
"--------------------------------------------------------

autocmd BufWritePost $MYVIMRC source $MYVIMRC

"--------------------------------------------------------
"UI Setting
"--------------------------------------------------------
syntax enable
set background=dark
colorscheme gruvbox
set guifont=Ubuntu_Mono:h13

"--------------------------------------------------------
"plugs Settings 
"--------------------------------------------------------
let g:hardtime_default_on = 1
let g:AutoPairsFlyMode = 1 

"--------------------------------------------------------
"plugs list
"--------------------------------------------------------

if &compatible
  set nocompatible
endif
" Add the dein installation directory into runtimepath
set runtimepath+=~/.cache/dein/repos/github.com/Shougo/dein.vim

if dein#load_state('~/.cache/dein')

call dein#begin('~/.cache/dein')
call dein#add('~/.cache/dein/repos/github.com/Shougo/dein.vim')

  call dein#add('Shougo/deoplete.nvim')
  if !has('nvim')
    call dein#add('roxma/nvim-yarp')
    call dein#add('roxma/vim-hug-neovim-rpc')
  endif
  call dein#add('wsdjeg/dein-ui.vim')

  call dein#add('morhetz/gruvbox')
  call dein#add('jiangmiao/auto-pairs')
  

  call dein#end()
  call dein#save_state()
endif

filetype plugin indent on
syntax enable
