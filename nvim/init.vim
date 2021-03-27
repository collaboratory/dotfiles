syntax on
set number
set hidden
set cmdheight=2
set updatetime=300
set shortmess+=c
set background=dark
set encoding=UTF-8
set guifont="BlexMono NF"
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
set signcolumn=yes
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
Plug 'sonph/onehalf', { 'rtp': 'vim' }
Plug 'preservim/nerdcommenter'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-surround'
Plug 'alexlafroscia/postcss-syntax.vim'

call plug#end()

set splitright
set splitbelow

" Svelte configuration
let g:svelte_preprocessors = ['postcss', 'ts']

" NERDTree
nmap <leader>b :NERDTreeMirror<CR>:NERDTreeToggle<CR>

autocmd FileType nerdtree setlocal nolist
" autocmd VimEnter * NERDTree | wincmd p
autocmd BufWinEnter * silent NERDTreeMirror
" Exit Vim if NERDTree is the only window left.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() |
      \ quit | endif


" Snippets
let g:UltiSnipsExpandTrigger='<tab>'
let g:UltiSnipsJumpForwardTrigger='<c-b>'
let g:UltiSnipsJumpBackwardTrigger='<c-z>'

" Emmet
let g:user_emmet_leader_key='<C-s>'

" Linting
let g:ale_fix_on_save = 1

" Tabman
nnoremap <leader>t :tabnext<CR>
nnoremap <leader>p :tabprev<CR>

" CtrlP
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']

" Theme
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
if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif

let g:airline_theme='onehalfdark'
