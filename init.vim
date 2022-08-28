let mapleader=" "
syntax on
colorscheme badwolf

set number
set relativenumber
set cursorline
set wrap
set showcmd
set wildmenu
set scrolloff=5
set cindent
set tabstop=4
set shiftwidth=4
set showmatch

set hlsearch
exec "nohlsearch"
set ignorecase
set smartcase
noremap <LEADER><CR> :nohlsearch<CR>

noremap J 5j
noremap K 5k
noremap H 0
noremap L $
noremap W 5w
noremap B 5b
noremap = nzz
noremap - Nzz

map <c-q> :q<CR>
map <c-s> :w<CR>
map R :source $MYVIMRC<CR>

"split
map sh :set nosplitright<CR>:vsplit<CR>
map sj :set splitbelow<CR>:split<CR>
map sk :set nosplitbelow<CR>:split<CR>
map sl :set splitright<CR>:vsplit<CR>
noremap <LEADER>h <c-w>h
noremap <LEADER>j <c-w>j
noremap <LEADER>k <c-w>k
noremap <LEADER>l <c-w>l
noremap <LEADER>w <C-w>w
noremap qf <C-w>o
" Ctrl + J or K will move up/down the view port without moving the cursor
noremap <C-J> 5<C-y>
noremap <C-K> 5<C-e>

map <up> :res +5<CR>
map <down> :res -5<CR>
map <left> :vertical resize +5<CR>
map <right> :vertical resize -5<CR>

" ===
" === Insert Mode Cursor Movement
" ===
inoremap <C-a> <ESC>A
" Place the two screens up and down
noremap sh <C-w>t<C-w>K
" Place the two screens side by side
noremap sv <C-w>t<C-w>H

" Rotate screens
noremap srh <C-w>b<C-w>K
noremap srv <C-w>b<C-w>H

" Press <SPACE> + q to close the window below the current window
noremap <LEADER>q <C-w>j:q<CR>


" ===
" === Tab management
" ===
" Create a new tab with tu
noremap tu :tabe<CR>
noremap tU :tab split<CR>
" Move around tabs with tn and ti
noremap th :-tabnext<CR>
noremap tl :+tabnext<CR>
" Move the tabs with tmn and tmi
noremap tmh :-tabmove<CR>
noremap tml :+tabmove<CR>


" ===
" === Markdown Settings
" ===
" Snippets
source ~/.config/nvim/md-snippets.vim
" auto spell
autocmd BufRead,BufNewFile *.md setlocal spell

" Press ` to change case (instead of ~)
noremap ` ~

" Press space twice to jump to the next '<++>' and edit it
noremap <LEADER><LEADER> <Esc>/<++><CR>:nohlsearch<CR>c4l

" Compile ONLY useful in $HOME
noremap r :call CompileRunGcc()<CR>
func! CompileRunGcc()
	exec "w"
	if &filetype == 'c'
		exec "!g++ % -o %<"
		exec "!time ./%<"
	elseif &filetype == 'cpp'
		set splitbelow
		exec "!g++ -std=c++11 % -Wall -o %<"
		:sp
		:res -5
		:term ./%<
	elseif &filetype == 'java'
		set splitbelow
		:sp
		:res -5
		term javac % && time java %<
	elseif &filetype == 'sh'
		:!time bash %
	elseif &filetype == 'python'
		set splitbelow
		:sp
		:term python3 %
	elseif &filetype == 'html'
		silent! exec "!".g:mkdp_browser." % &"
	elseif &filetype == 'markdown'
		exec "InstantMarkdownPreview"
	elseif &filetype == 'tex'
		silent! exec "VimtexStop"
		silent! exec "VimtexCompile"
	elseif &filetype == 'dart'
		exec "CocCommand flutter.run -d ".g:flutter_default_device." ".g:flutter_run_args
		silent! exec "CocCommand flutter.dev.openDevLog"
	elseif &filetype == 'javascript'
		set splitbelow
		:sp
		:term export DEBUG="INFO,ERROR,WARNING"; node --trace-warnings .
	elseif &filetype == 'go'
		set splitbelow
		:sp
		:term go run .
	endif
endfunc


"===
"=== Plug
"===

" Specify a directory for plugins
call plug#begin('~/.config/nvim/plugged')

" Snippet 代码段
Plug 'SirVer/ultisnips'
"设置tab键为触发键
let g:UltiSnipsExpandTrigger = '<tab>'
"设置向后跳转键
let g:UltiSnipsJumpForwardTrigger = '<tab>' 
"设置向前跳转键
let g:UltiSnipsJumpBackwardTrigger = '<S-tab>' 
"设置文件目录
let g:UltiSnipsSnippetDirectories=["~/.config/nvim/Ultisnips"]
"设置打开配置文件时为垂直打开
let g:UltiSnipsEditSplit="vertical"


" On-demand loading 按需加载
"Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }

"vim-airline
Plug 'vim-airline/vim-airline'

"vim-color
Plug 'connorholyday/vim-snazzy'
Plug 'sjl/badwolf'
Plug 'tomasr/molokai'
Plug 'dracula/vim', { 'as': 'dracula'}

"vim-table-mode
Plug 'dhruvasagar/vim-table-mode'

"vim-indent-guide
Plug 'nathanaelkane/vim-indent-guides'

" Markdown 
Plug 'plasticboy/vim-markdown'
let g:vim_markdown_math = 1

" Markdown menu
"安装插件
Plug 'mzlogin/vim-markdown-toc'
"在当前光标后生成目录
":GenTocMarked
"更新目录
":UpdateToc
"取消储存时自动更新目录
let g:vmt_auto_update_on_save = 0



" coc.nvim
" Plug 'neoclide/coc.nvim', {'branch': 'release'}
" let g:coc_global_extensions = [
"	\ 'coc-vimlsp',
"	\ 'coc-marketplace']



" Initialize plugin system
call plug#end()
