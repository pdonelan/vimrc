"
" Vim Config
" Patrick Donelan
"

"=====[ Pre Config ]==========================================================
set nocompatible
silent! source ~/.vimrc-vundle
syntax on
silent! source ~/.vimrc-pre
filetype plugin indent on
let mapleader = ";"

"=====[ General Settings ]====================================================
set autowrite " Automatically save before commands like :next and :make
set background=dark
set colorcolumn=+1
set hidden " Hide buffers when they are abandoned
set hlsearch
set ignorecase " Do case insensitive matching
set incsearch " Incremental search
set list " Special chars
set matchtime=1 " Default 5 is too slow (in 10ms)
set modeline
set mouse=a " Enable mouse usage (all modes)
set nocursorline " Causes a visible flicker, especially in visual mode
set showcmd " Show (partial) command in status line
set showmatch " Show matching brackets
set smartcase " Do smart case matching
set splitright
set synmaxcol=400 " Helps prevent vim from choking on long lines
set virtualedit=block "Square up visual selections
set wildmenu

"=====[ Stuff ]===============================================================

" .vimrc
augroup VimReload
  autocmd!
  autocmd BufWritePost $MYVIMRC source $MYVIMRC
augroup END
nmap <silent> <leader>v :next $MYVIMRC<CR>

" Special Chars
nmap <silent> <leader># :set list!<CR>
set listchars=tab:▸\·,eol:¬,trail:\·,extends:»,precedes:«
highlight NonText ctermfg=DarkGrey guifg=DarkGrey
highlight SpecialKey ctermbg=0 ctermfg=DarkRed guibg=black guifg=DarkRed
" Demo: tab & trailing spaces should be red	text     

" gutters
highlight SignColumn ctermbg=233
let g:gitgutter_sign_column_always = 1
" Also: :GitGutterLineHighlightsToggle, [h, ]h

" Jump to most recent position in file
au BufReadPost *  if line("'\"") > 1 && line("'\"") <= line("$")
              \|    exe "normal! g`\""
              \|  endif

" Persistent undo
if has('persistent_undo')
  set undodir=$HOME/.vim/undo
  set undolevels=5000
  set undofile
endif

" Tabs
set expandtab
set shiftwidth=2 " Autoindent width
set softtabstop=2 " BS deletes 2 spaces
set tabstop=8 " Make unwanted tabs easy to spot

" Persistent selection
vmap <silent> > >gv
vmap <silent> < <gv
vmap <silent> u <ESC>ugv
vmap <silent> <C-R> <ESC><C-R>gv

" Line width
au FileType java setlocal textwidth=100 colorcolumn=+1
au FileType javascript setlocal textwidth=80 colorcolumn=+1
au FileType objc,objcpp setlocal textwidth=80 colorcolumn=+1
au FileType vim setlocal textwidth=0

" Vim's ftplugin/javascript.vim unsets the t flag (/usr/share/vim/vim73/ftplugin/javascript.vim)
au FileType javascript setlocal formatoptions+=t

" File changes
set autoread
au CursorHold,BufWinEnter * checktime

" Fix js syntax highlighting within html files (otherwise breaks after :e)
au BufEnter *.html :syntax sync fromstart

nnoremap <silent> <leader>c :execute "set colorcolumn=" . (&cc == "+1" ? "0" : "+1")<CR>
nnoremap <silent> <leader>u :Bufdo checktime<CR>
nnoremap <silent> <C-w><C-^> :vsplit #<CR>
nnoremap <silent> <Backspace> :nohlsearch<CR>
nnoremap <silent> <Leader>] :execute "silent! !ctags -R" <Bar> redraw!<CR>
nnoremap <silent> <leader>q :cw<CR>

" Paste (best to use 'yp' or 'yP' to enter temporary insert paste mode)
set pastetoggle=<F2>

" Search/Replace
nmap <leader>s :%s/\<<C-r><C-w>\>/
vmap s :s/

" Sorting
vmap so !sort<CR>

" Saving files
nmap <silent> <leader>w :w<CR>
nmap <silent> <leader>x :BD<CR>
nmap <silent> <leader>X :bd<CR>

" Alternate file
" nmap <silent> <leader>a <C-^>
nmap <silent> <leader>a <leader>lss
" imap <silent> <C-^> <C-C>:e #<CR>

" One-handed scrolling
nmap <silent> <Space> <PageDown>
nmap <silent> <M-Space> <PageUp>

" Select last pasted/modified text (from vim.wikia.com)
nnoremap <expr> gp '`[' . strpart(getregtype(), 0, 1) . '`]'

" Make
" nnoremap <leader>m :silent make\|redraw!<CR>

" Vimdiff
" highlight DiffAdd cterm=bold ctermfg=green ctermbg=NONE guibg=NONE
" highlight DiffChange cterm=bold ctermfg=cyan ctermbg=NONE guibg=NONE
" highlight DiffText cterm=bold ctermfg=gray ctermbg=NONE guibg=NONE
" highlight DiffDelete cterm=bold ctermfg=red ctermbg=NONE guibg=NONE

"=====[ Plugins ]=============================================================

" NERDTree
nnoremap <silent> <Leader>d :NERDTreeToggle<CR>
nnoremap <silent> <Leader>f :NERDTreeFind<CR>
let NERDTreeShowBookmarks=1

" CtrlP
noremap <silent> <leader>b :CtrlPBuffer<CR>
nnoremap <silent> <leader>m :CtrlPMRUFiles<CR>
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\.git$\|\.hg$\|\.svn$',
  \ 'file': '\.exe$\|\.so$\|\.dll$',
  \ }
let g:ctrlp_by_filename = 0 " Search by filename instead of path by default
let g:ctrlp_clear_cache_on_exit = 0 " Only refresh on explicit <C-F5>
let g:ctrlp_max_files = 50000
let g:ctrlp_max_height = 20
let g:ctrlp_working_path_mode = 0 " Don't muck with $PWD
" let g:ctrlp_user_command = 'vimls %s'

" LustyJuggler
let g:LustyJugglerDefaultMappings = 0
nmap <silent> <leader>l :LustyJuggler<CR>

" Ack
let g:ackprg="ack-grep -H --nocolor --nogroup --column"

" Powerline
set laststatus=2   " Always show the statusline
set encoding=utf-8 " Necessary to show unicode glyphs
let g:Powerline_stl_path_style="short"
let g:Powerline_symbols="fancy"

" TagBar
nnoremap <silent> <Leader>t :TagbarToggle<CR>
let g:tagbar_autoclose=1

" Eclim
" set rtp+=~/.vim/bundle/eclim
" let g:EclimProjectProblemsUpdateOnSave=0 " keep saving fast
" let g:EclimJavaDocSearchSingleResult='lopen' " Preview instead of Browser
" let g:EclimJavaSearchSingleResult='edit'
" let g:EclimJavaSearchMapping=0 " Don't bind <CR> to :JavaSearchContext
" let g:EclimJavaValidate=0 " Manually validate with :Validate instead
" " au Filetype java nnoremap <silent> <buffer> <Leader>r :JavaSearch -x reference<CR>
" " nmap <silent> <expr> <leader>jsp FS_FoldAroundTarget('\S\+\.prototype\.\w\+',{'context':0})
" au Filetype java nnoremap <silent> <buffer> <Leader>jc  :JavaCorrect<CR>
" au Filetype java nnoremap <silent> <buffer> <Leader>jdc :JavaDocComment<CR>
" au Filetype java nnoremap <silent> <buffer> <Leader>jdp :JavaDocPreview<CR>
" au Filetype java nnoremap <silent> <buffer> <Leader>jds :JavaDocSearch<CR>
" au Filetype java nnoremap <silent> <buffer> <Leader>jg  :JavaSearchContext<CR>
" au Filetype java nnoremap <silent> <buffer> <Leader>jh  :JavaHierarchy<CR>
" au Filetype java nnoremap <silent> <buffer> <Leader>ji  :JavaImport<CR>
" au Filetype java nnoremap <silent> <buffer> <Leader>jo  :JavaImportOrganize<CR>
" au Filetype java nnoremap          <buffer> <Leader>jrm :JavaMove 
" au Filetype java nnoremap <silent> <buffer> <Leader>jrp :RefactorUndoPeek<CR>
" au Filetype java nnoremap          <buffer> <Leader>jrr :JavaRename 
" au Filetype java nnoremap <silent> <buffer> <Leader>jru :RefactorUndo<CR>
" au Filetype java nnoremap <silent> <buffer> <Leader>jv  :w<CR>:Validate<CR>

" Commentary
nmap <silent> <C-\> <Plug>CommentaryLine
au Filetype objc,objcpp,html set commentstring=//%s

" Matchit (bundled with vim)
:runtime macros/matchit.vim

" a.vim
nmap <silent> <leader>A :A<CR>
let g:alternateExtensions_M = "h" " Objective-c
let g:alternateDefaultMappings = 0

" ToggleList
let g:toggle_list_no_mappings=1
nmap <silent> <leader>tq :call ToggleQuickfixList()<CR>
nmap <silent> <leader>tl :call ToggleLocationList()<CR>
nmap <silent> <leader>tp :pclose<CR>

" YouCompleteMe
let g:ycm_filetype_specific_completion_to_disable = {'cpp': 1, 'c': 1}
let g:ycm_key_detailed_diagnostics = ''

"=====[ Functions ]===========================================================

" Like bufdo but restore the current buffer.
" http://vim.wikia.com/wiki/Run_a_command_in_multiple_buffers#Restoring_position
function! BufDo(command)
  let currBuff=bufnr("%")
  execute 'bufdo ' . a:command
  execute 'buffer ' . currBuff
endfunction
command! -nargs=+ -complete=command Bufdo call BufDo(<q-args>)

nmap <silent> <CR> :call Enter()<CR>
function! Enter()
  if (&modifiable)
    execute "normal! mxi\<CR>\<Esc>`x"
  else
    execute "normal! \<CR>"
  endif
endfunction

" Post-config
silent! source ~/.vimrc-post
