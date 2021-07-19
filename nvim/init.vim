" Enable syntax highlighting
syntax on

" Line numbering
set number
" Showing commands
set showcmd

" Matching brackets automatically
set showmatch

" Keep a few lines between cursor and top and bottom of screen during scroll
set scrolloff=15

" Donot wrap text
set nowrap

" Case sensitive search only if search term explicitly containes uppercase
set smartcase

" Donot create swap files everywhere
set noswapfile

" Highlight searches
set incsearch

" Make vim use system clipboard, Requires xclip
set clipboard+=unnamedplus

" Setting space as leader key
let mapleader=" "
set ttimeoutlen=500


" Call all the plugins
call plug#begin('~/.vim/plugged')

    Plug 'norcalli/nvim-colorizer.lua'                              " Show colors on color codes
    Plug 'mhinz/vim-startify'                                       " Startup screen for vim
    Plug 'yggdroot/indentline'                                      " Show indentation levels with lines
    Plug 'raimondi/delimitmate'                                     " Autoclose brackets,quotes etc.
    Plug 'bronson/vim-trailing-whitespace'                          " Highlight and delete trailing whitespace
    Plug 'neoclide/coc.nvim', {'branch': 'release'}                 " Autocompletion for code
    Plug 'adithyan-kv/gruvbox-darkest'                              " Custom gruvbox colorscheme
    Plug 'tpope/vim-fugitive'                                       " Git integration
    Plug 'kyazdani42/nvim-web-devicons'                             " Icons for Filetree and stuff
    Plug 'kyazdani42/nvim-tree.lua'                                 " File explorer tree
    Plug 'terrortylor/nvim-comment'                                 " Commenting out lines
    Plug 'hoob3rt/lualine.nvim'                                     " Statusline plugin
    Plug 'akinsho/nvim-bufferline.lua'                              " Tabline plugin
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}     " Better highlighting and stuff
    Plug 'junegunn/fzf'                                             " Fuzzy finding file search
    Plug 'junegunn/fzf.vim'                                         " Some wrapper functions for fzf
    Plug 'airblade/vim-rooter'                                      " Change working directory to project directory

call plug#end()

" Setting color scheme
let g:gruvbox_contrast_dark='hard'
colorscheme gruvbox-darkest
set background=dark

" Disable quote concealing in JSON files. To compensate for a setting that
" Indentline plugin changes
let g:vim_json_conceal=0

" For color code highlighting plugin
set termguicolors
lua require'colorizer'.setup()

" Draw ruler
set colorcolumn=80
highlight ColorColumn ctermbg=234 guibg=#1c1c1c

" Highlighting the line on which the cursor is on
set cursorline
highlight Cursorline ctermbg=235 guibg=#262626

" Enable mouse in all modes
set mouse=a

" Disable automatic commenting of the next line after a comment
au FileType * set fo-=c fo-=r fo-=o

"""""""""""""""""""""""""""""""""""""""""""""""""""""
" Fuzzy finding
"""""""""""""""""""""""""""""""""""""""""""""""""""""
" Fuzzy find filename in cwd and down, respects gitignore
" (Requires fzf installed in system)
nnoremap <C-p> :GFiles<CR>
" Fuzzy find text inside file in cwd and down
" (Requires ripgrep installed in system)
nnoremap <M-p> :Rg<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""
" Syntax highlighting with treesitter
"""""""""""""""""""""""""""""""""""""""""""""""""""""
lua require('nvim-treesitter.configs').setup{highlight={enable=true}}

"""""""""""""""""""""""""""""""""""""""""""""""""""""
" Managing split windows
"""""""""""""""""""""""""""""""""""""""""""""""""""""
" Making new split windows open to the right and down
set splitbelow splitright

" Remapping split navigation to just Ctrl+hjkl
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nnoremap <C-c> <C-w>q

" Opening terminal in vertical split, Shift+t to toggle terminal
autocmd TermOpen * startinsert              " Always open terminal in insert mode
" Open terminal in bottom split
nnoremap <S-t> :10sp \| bel terminal<CR>
" Close terminal if already open
tnoremap <S-t> <C-\><C-n>:q<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""
" File browser plugin
""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <leader>n :NvimTreeToggle<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Managing indents
""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Autoindent
set smartindent
set autoindent

" Tabs
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab

" display indentation levels with lines plugin. Setting colors
let g:indentLine_color_term=235
let g:indentLine_color_gui='#262626'

" Donot leave visual mode after indenting once
vnoremap > >gv
vnoremap < <gv

"""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Managing the statusline
"""""""""""""""""""""""""""""""""""""""""""""""""""""""
lua require('lualine').setup{
            \options = {theme='gruvbox_material',
                        \section_separators = {'', ''},
                        \component_separators = {'', ''}},
            \tabline={},
            \extensions={'nvim-tree','fugitive'},
            \}

" Disabling the modename at the bottom as statusline extension already shows it
set noshowmode

" Adding a tabline
lua require("bufferline").setup()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Navigating tabs
"""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <S-h> gT
nnoremap <S-l> gt

"""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Comments plugin
"""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Comment line with Ctrl+/.For some reason _ represents /.
lua require('nvim_comment').setup()
nnoremap <C-_> :CommentToggle<CR>
vnoremap <C-_> :CommentToggle<CR>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""
"  Setting other custom keybindings
"  (Mostly to VSCode bindings)
"""""""""""""""""""""""""""""""""""""""""""""""""""""""
" save with Ctrl+s
" Automatically deletes trailing whitespace while saving
nmap <C-s> :FixWhitespace<CR> :w<CR>
imap <C-s> <Esc>:FixWhitespace<CR> :w<CR>

" Alt+j/k or Alt+up/down to move a line up or down
nnoremap <A-j> :m .+1<CR>==
nnoremap <A-k> :m .-2<CR>==
inoremap <A-j> <Esc>:m .+1<CR>==gi
inoremap <A-k> <Esc>:m .-2<CR>==gi
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv

nnoremap <A-down> :m .+1<CR>==
nnoremap <A-up> :m .-2<CR>==
inoremap <A-down> <Esc>:m .+1<CR>==gi
inoremap <A-up> <Esc>:m .-2<CR>==gi
vnoremap <A-down> :m '>+1<CR>gv=gv
vnoremap <A-up> :m '<-2<CR>gv=gv
