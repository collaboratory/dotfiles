syntax on
set encoding=utf-8
set hidden
set number
set cmdheight=2
set updatetime=300
set shortmess+=c
set background=dark
set guifont=BlexMono\ NF\ 12
set ts=2 sw=2 sts=4 et
set mouse=a
set autoindent
set copyindent
set smartindent
set noswapfile
set nobackup
set nowritebackup
set cursorline
set notimeout
set ttimeout

if has("nvim-0.5.0") || has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

set ttyfast
highlight EndOfBuffer ctermfg=black ctermbg=black
set t_Co=256
set nocompatible
filetype off
set hlsearch

call plug#begin("~/.vim/plugged")

Plug 'scrooloose/nerdtree'
Plug 'evanleck/vim-svelte', {'branch': 'main'}
Plug 'dense-analysis/ale'
Plug 'adelarsq/vim-matchit'
Plug 'vim-scripts/darkspectrum'
Plug 'ryanoasis/vim-devicons'
Plug 'prettier/vim-prettier', { 'do': 'yarn install' }
Plug 'mattn/emmet-vim'
Plug 'easymotion/vim-easymotion'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'pangloss/vim-javascript'
Plug 'leafgarland/typescript-vim'
Plug 'hail2u/vim-css3-syntax'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'mg979/vim-visual-multi', {'branch':'master'}
" Plug 'morhetz/gruvbox'
Plug 'sonph/onehalf', { 'rtp': 'vim' }
Plug 'preservim/nerdcommenter'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-surround'
Plug 'alexlafroscia/postcss-syntax.vim'
Plug 'tpope/vim-fugitive'
Plug 'qpkorr/vim-bufkill'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'rust-lang/rust.vim'
Plug 'codota/tabnine-vim'
Plug 'metakirby5/codi.vim'

call plug#end()

set splitright
set splitbelow

" Svelte configuration
let g:svelte_preprocessors = ['postcss', 'ts']

" NERDTree
" Create default mappings
let g:NERDCreateDefaultMappings = 1

" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1

" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1

" Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDDefaultAlign = 'left'

" Set a language to use its alternate delimiters by default
let g:NERDAltDelims_java = 1

" Add your own custom formats or override the defaults
let g:NERDCustomDelimiters = { 'c': { 'left': '/**','right': '*/' } }

" Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 1

" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1

" Enable NERDCommenterToggle to check all selected lines is commented or not
let g:NERDToggleCheckAllLines = 1

nmap <leader>b :NERDTreeMirror<CR>:NERDTreeToggle<CR>
nmap <leader>n :NERDTreeFind<CR>

autocmd FileType nerdtree setlocal nolist
" autocmd VimEnter * NERDTree | wincmd p
autocmd BufWinEnter * silent NERDTreeMirror
" Exit Vim if NERDTree is the only window left.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() |
      \ quit | endif

autocmd BufNewFile,BufRead *.svf set filetype=svelte

" Snippets
let g:UltiSnipsExpandTrigger='<tab>'
let g:UltiSnipsJumpForwardTrigger='<c-b>'
let g:UltiSnipsJumpBackwardTrigger='<c-z>'

" Emmet
let g:user_emmet_leader_key='<C-s>'

" Linting
let b:ale_linters = ['prettier', 'eslint']
let b:ale_fixers = ['prettier', 'eslint']
let g:ale_fix_on_save = 1

" Tabman
nnoremap <leader>t :tabnext<CR>
nnoremap <leader>p :tabprev<CR>

" CtrlP
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']

" Theme
let g:gruvbox_contrast_dark = "hard"
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1

" COC
inoremap <silent><expr> <c-space> coc#refresh()
" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

colorscheme onehalfdark
" let g:airline_theme='onehalf'
if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif
