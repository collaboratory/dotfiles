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
if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif

Plug 'tbodt/deoplete-tabnine', { 'do': './install.sh' }
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'pangloss/vim-javascript'
Plug 'leafgarland/typescript-vim'
Plug 'hail2u/vim-css3-syntax'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'mg979/vim-visual-multi', {'branch':'master'}
Plug 'morhetz/gruvbox'
Plug 'preservim/nerdcommenter'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

call plug#end()

" Autocompletion
let g:deoplete#enable_at_startup = 1

" Svelte configuration
let g:svelte_preprocessor_tags = [{ 'name': 'postcss', 'tag': 'style', 'as': 'scss' }, { 'name': 'ts', 'tag': 'script', 'as': 'typescript'}]
let g:svelte_preprocessors = ["typescript", "postcss", "ts"]

" NERDTree
nmap <leader>b :NERDTreeMirror<CR>:NERDTreeToggle<CR>
" NERDTrees File highlighting
function! NERDTreeHighlightFile(extension, fg, bg, guifg, guibg)
 exec 'autocmd FileType nerdtree highlight ' . a:extension .' ctermbg='. a:bg .' ctermfg='. a:fg .' guibg='. a:guibg .' guifg='. a:guifg
 exec 'autocmd FileType nerdtree syn match ' . a:extension .' #^\s\+.*'. a:extension .'$#'
endfunction

call NERDTreeHighlightFile('jade', 'green', 'none', 'green', '#151515')
call NERDTreeHighlightFile('ini', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('md', 'blue', 'none', '#3366FF', '#151515')
call NERDTreeHighlightFile('yml', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('config', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('conf', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('json', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('html', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('styl', 'cyan', 'none', 'cyan', '#151515')
call NERDTreeHighlightFile('css', 'cyan', 'none', 'cyan', '#151515')
call NERDTreeHighlightFile('coffee', 'Red', 'none', 'red', '#151515')
call NERDTreeHighlightFile('js', 'Red', 'none', '#ffa500', '#151515')
call NERDTreeHighlightFile('php', 'Magenta', 'none', '#ff00ff', '#151515')
call NERDTreeHighlightFile('ds_store', 'Gray', 'none', '#686868', '#151515')
call NERDTreeHighlightFile('gitconfig', 'Gray', 'none', '#686868', '#151515')
call NERDTreeHighlightFile('gitignore', 'Gray', 'none', '#686868', '#151515')
call NERDTreeHighlightFile('bashrc', 'Gray', 'none', '#686868', '#151515')
call NERDTreeHighlightFile('bashprofile', 'Gray', 'none', '#686868', '#151515')

autocmd FileType nerdtree setlocal nolist
" autocmd VimEnter * NERDTree | wincmd p
autocmd BufWinEnter * silent NERDTreeMirror
" Exit Vim if NERDTree is the only window left.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() |
      \ quit | endif


" Snippets
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" Emmet
let g:user_emmet_leader_key="<C-s>"

" Linting
let g:ale_fixers = { 'javascript': ['prettier'], 'svelte': ['prettier'], 'css': ['prettier'], 'scss': ['prettier'], 'postcss': ['prettier'], 'html': ['prettier'], 'typescript': ['prettier'] }
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

syntax on
set number
colorscheme gruvbox
set encoding=UTF-8
set guifont="BlexMono NF"
set ts=2 sw=2 sts=4 et
set mouse=a
set autoindent
set cursorline
set notimeout
set ttimeout
set ttyfast
set background=dark
highlight EndOfBuffer ctermfg=black ctermbg=black
