set encoding=utf-8
"set encoding=cp932
set number
set autoindent
set smartindent
set smarttab
set tabstop=4
set shiftwidth=4
set ruler " column, row
set showcmd
set ignorecase
set clipboard=unnamed,autoselect
set listchars=tab:>-,trail:-,eol:$

set fileencodings=iso-2022-jp,iso-2022-jp-2,utf-8,euc-jp,sjis

set noerrorbells
set visualbell
set viminfo=

"hi Statement ctermfg=white
"hi Comment   ctermfg=yellow
"hi String ctermfg=green cterm=bold

"hi Constant ctermfg=yellow cterm=bold
"hi Character ctermfg=5
"hi String ctermfg=white cterm=bold
"hi Function term=bold ctermfg=LightBlue
"hi Number ctermfg=black
"hi Identifier ctermfg=black cterm=bold
"hi Statement ctermfg=white cterm=bold
"hi PreProc ctermfg=white cterm=bold
"hi Type ctermfg=LightBlue cterm=bold
"hi Special ctermfg=grey cterm=bold
"hi Underlined cterm=italic
"hi Ignore ctermfg=darkgray
"hi Error ctermfg=darkred ctermbg=black
"hi Todo ctermbg=darkred ctermfg=yellow

" neobundle settings {{{
if has('vim_starting')
  set nocompatible
  " neobundle をインストールしていない場合は自動インストール
  if !isdirectory(expand("/home/vimfiles/bundle/neobundle.vim/"))
    echo "install neobundle..."
    " vim からコマンド呼び出しているだけ neobundle.vim のクローン
    :call system("git clone https://github.com/Shougo/neobundle.vim /home/vimfiles/bundle/neobundle.vim")
  endif
  " runtimepath の追加は必須
  set runtimepath+=/home/vimfiles/bundle/neobundle.vim/
endif
call neobundle#begin(expand('/home/vimfiles/bundle'))
let g:neobundle_default_git_protocol='https'

" neobundle#begin - neobundle#end の間に導入するプラグインを記載します。
NeoBundleFetch 'Shougo/neobundle.vim'
" ↓こんな感じが基本の書き方
NeoBundle 'nanotech/jellybeans.vim'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'ujihisa/unite-colorscheme'

" unite {
let g:unite_enable_start_insert=1
nmap <silent> <C-u><C-b> :<C-u>Unite buffer<CR>
nmap <silent> <C-u><C-f> :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
nmap <silent> <C-u><C-r> :<C-u>Unite -buffer-name=register register<CR>
nmap <silent> <C-u><C-m> :<C-u>Unite file_mru<CR>
nmap <silent> <C-u><C-u> :<C-u>Unite buffer file_mru<CR>
nmap <silent> <C-u><C-a> :<C-u>UniteWithBufferDir -buffer-name=files buffer file_mru bookmark file<CR>
au FileType unite nmap <silent> <buffer> <expr> <C-j> unite#do_action('split')
au FileType unite imap <silent> <buffer> <expr> <C-j> unite#do_action('split')
au FileType unite nmap <silent> <buffer> <expr> <C-l> unite#do_action('vsplit')
au FileType unite imap <silent> <buffer> <expr> <C-l> unite#do_action('vsplit')
au FileType unite nmap <silent> <buffer> <ESC><ESC> q
au FileType unite imap <silent> <buffer> <ESC><ESC> <ESC>q
" }}}
NeoBundle 'Shougo/neomru.vim', {
  \ 'depends' : 'Shougo/unite.vim'
  \ }
NeoBundle 'Shougo/vimproc.vim', {
  \ 'build' : {
  \     'windows' : 'tools\\update-dll-mingw',   
  \     'cygwin' : 'make -f make_cygwin.mak',
  \     'mac' : 'make -f make_mac.mak',
  \     'unix' : 'make -f make_unix.mak',
  \    },
  \ }

if has('lua')
  NeoBundleLazy 'Shougo/neocomplete.vim', {
    \ 'depends' : 'Shougo/vimproc.vim',
    \ 'autoload' : { 'insert' : 1,}
    \ }
endif

" neocomplete {{{
let g:neocomplete#enable_at_startup               = 1
let g:neocomplete#auto_completion_start_length    = 3
let g:neocomplete#enable_ignore_case              = 1
let g:neocomplete#enable_smart_case               = 1
let g:neocomplete#enable_camel_case               = 1
let g:neocomplete#use_vimproc                     = 1
let g:neocomplete#sources#buffer#cache_limit_size = 1000000
let g:neocomplete#sources#tags#cache_limit_size   = 30000000
let g:neocomplete#enable_fuzzy_completion         = 1
let g:neocomplete#lock_buffer_name_pattern        = '\*ku\*'
" }}}

NeoBundleLazy 'Shougo/vimshell', {
  \ 'depends' : 'Shougo/vimproc.vim',
  \ 'autoload' : {
  \   'commands' : [{ 'name' : 'VimShell', 'complete' : 'customlist,vimshell#complete'},
  \                 'VimShellExecute', 'VimShellInteractive',
  \                 'VimShellTerminal', 'VimShellPop'],
  \   'mappings' : ['<Plug>(vimshell_switch)']
  \ }}

" vimshell {{{
nmap <silent> vs :<C-u>VimShell<CR>
nmap <silent> vp :<C-u>VimShellPop<CR>
" }}}

NeoBundle 'LeafCage/yankround.vim'

" yankround.vim {{{
nmap p <Plug>(yankround-p)
nmap P <Plug>(yankround-P)
nmap <C-p> <Plug>(yankround-prev)
nmap <C-n> <Plug>(yankround-next)
let g:yankround_max_history = 100
nnoremap <Leader><C-p> :<C-u>Unite yankround<CR>
"}}}

NeoBundleLazy 'Shougo/vimfiler', {
  \ 'depends' : ["Shougo/unite.vim"],
  \ 'autoload' : {
  \   'commands' : [ "VimFilerTab", "VimFiler", "VimFilerExplorer", "VimFilerBufferDir" ],
  \   'mappings' : ['<Plug>(vimfiler_switch)'],
  \   'explorer' : 1,
  \ }}


" vimfiler {{{
let g:vimfiler_as_default_explorer  = 1
let g:vimfiler_safe_mode_by_default = 0
let g:vimfiler_data_directory       = expand('~/.vim/etc/vimfiler')
nnoremap <silent><C-u><C-j> :<C-u>VimFilerBufferDir -split -simple -winwidth=35 -no-quit -toggle<CR>
" }}}

NeoBundle 'Townk/vim-autoclose'

NeoBundleLazy 'tpope/vim-endwise', {
  \ 'autoload' : { 'insert' : 1,}}

NeoBundle 'glidenote/memolist.vim'

" memolist {{{
let g:memolist_path = expand('/home/DropBox/vim/memo')
let g:memolist_gfixgrep = 1
let g:memolist_unite = 1
let g:memolist_unite_option = "-vertical -start-insert"
nnoremap mn  :MemoNew<CR>
nnoremap ml  :MemoList<CR>
nnoremap mg  :MemoGrep<CR>
" }}}

NeoBundle 'Lokaltog/vim-easymotion'
" vim-easymotion {{{
let g:EasyMotion_do_mapping = 0
nmap s <Plug>(easymotion-s2)
xmap s <Plug>(easymotion-s2)
omap z <Plug>(easymotion-s2)
nmap g/ <Plug>(easymotion-sn)
xmap g/ <Plug>(easymotion-sn)
omap g/ <Plug>(easymotion-tn)
let g:EasyMotion_smartcase = 1
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)
let g:EasyMotion_startofline = 0
let g:EasyMotion_keys = 'QZASDFGHJKL;'
let g:EasyMotion_use_upper = 1
let g:EasyMotion_enter_jump_first = 1
" }}}

NeoBundleLazy 'junegunn/vim-easy-align', {
  \ 'autoload': {
  \   'commands' : ['EasyAlign'],
  \   'mappings' : ['<Plug>(EasyAlign)'],
  \ }}

" vim-easy-align {{{
vmap <Enter> <Plug>(EasyAlign)
nmap <Leader>a <Plug>(EasyAlign)
" }}}

NeoBundle 'rcmdnk/vim-markdown'
" vim-markdown {{{
let g:vim_markdown_folding_disabled = 1
" }}}

NeoBundleLazy 'Shougo/neosnippet', {
  \ 'depends' : 'Shougo/neosnippet-snippets',
  \ 'autoload' : {
  \   'insert' : 1,
  \   'filetypes' : 'snippet',
  \ }}
NeoBundle 'Shougo/neosnippet-snippets'

let g:neosnippet#data_directory     = expand('/home/vimfiles/etc/.cache/neosnippet')
let g:neosnippet#snippets_directory = [expand('/home/vimfiles/.bundle/neosnippet-snippets/neosnippets'),expand('/home/dotfiles/snippets')]
" neosnippet {{{
imap <C-k> <Plug>(neosnippet_expand_or_jump)
smap <C-k> <Plug>(neosnippet_expand_or_jump)
" }}}

NeoBundle 'AndrewRadev/switch.vim'

" switch {{{
nmap + :Switch<CR>
nmap - :Switch<CR>
" }}}

NeoBundle 'tpope/vim-surround'
NeoBundle 'vim-scripts/matchit.zip'

NeoBundle 'tyru/open-browser.vim'

" open-browser {{{
let g:netrw_nogx = 1 " disable netrw's gx mapping
nmap gx <Plug>(openbrowser-smart-search)
" }}}

NeoBundle 'rizzatti/dash.vim'

" dash.vim {{{
nmap <Leader>d <Plug>DashSearch
" }}}

NeoBundleLazy 'thinca/vim-quickrun', {
  \ 'autoload' : {
  \   'mappings' : [['n', '\r']],
  \   'commands' : ['QuickRun']
  \ }}

" quickrun {{{
let g:quickrun_config = {}
let g:quickrun_config._ = { 'runner' : 'vimproc',
  \ 'runner/vimproc/updatetime' : 200,
  \ 'outputter/buffer/split' : ':botright 8sp',
  \ 'outputter' : 'multi:buffer:quickfix',
  \ 'hook/close_buffer/enable_empty_data' : 1,
  \ 'hook/close_buffer/enable_failure' : 1,
  \ }
nnoremap <expr><silent> <C-c> quickrun#is_running() ? quickrun#sweep_sessions() : "\<C-c>"
" }}}

NeoBundleLazy 'mattn/emmet-vim', {
  \ 'autoload' : {
  \   'filetypes' : ['html', 'html5', 'eruby', 'jsp', 'xml', 'css', 'scss', 'coffee'],
  \   'commands' : ['<Plug>ZenCodingExpandNormal']
  \ }}
" emmet {{{
let g:use_emmet_complete_tag = 1
let g:user_emmet_settings = {
  \ 'lang' : 'ja',
  \ 'html' : {
  \   'indentation' : '  '
  \ }}
" }}}

" Ruby on rails
NeoBundle 'tpope/vim-rails'

NeoBundleLazy 'alpaca-tc/alpaca_tags', {
  \ 'depends': ['Shougo/vimproc.vim', 'Shougo/unite.vim'],
  \ 'autoload' : {
  \   'commands' : ['Tags', 'TagsUpdate', 'TagsSet', 'TagsBundle', 'TagsCleanCache'],
  \   'unite_sources' : ['tags']
  \ }}
" alpaca_tags {{{
let g:alpaca_update_tags_config = {
  \ '_' : '-R --sort=yes --languages=-js,html,css',
  \ 'ruby': '--languages=+Ruby',
  \ }
" }}}

NeoBundleLazy 'vim-ruby/vim-ruby', {
  \ 'autoload' : {'filetypes' : ['ruby', 'eruby']}}

" Python
NeoBundleLazy "davidhalter/jedi-vim", {
  \ "autoload": {
  \   "filetypes": ["python", "python3", "djangohtml"],
  \ },
  \ "build" : {
  \   "mac"  : "pip install jedi",
  \   "unix" : "pip install jedi",
  \ }}
" jedi-vim {{{
let g:jedi#rename_command = '<Leader>R'
let g:jedi#goto_assignments_command = '<Leader>G'
autocmd FileType python setlocal omnifunc=jedi#completions
let g:jedi#completions_enabled = 0
let g:jedi#auto_vim_configuration = 0
" }}}

" html

" next-alter
NeoBundle 'mopp/next-alter.vim'

nnoremap [NEXTALTER] <Nop>
nmap <Space>n [NEXTALTER]

nmap [NEXTALTER]o <Plug>(next-alter-open)

" next-alter {{{
let g:next_alter#pair_extension = {
	\   'c': ['h'],
	\   'C': ['H'],
	\  'cc': ['h'],
	\  'CC': ['H',   'h'],
	\ 'cpp': ['h', 'hpp'],
	\ 'CPP': ['H', 'HPP'],
	\ 'cxx': ['h', 'hpp'],
	\ 'CXX': ['H', 'HPP'],
	\   'h': ['c',  'cpp', 'cxx'],
	\   'H': ['C',  'CPP', 'CXX'],
	\ 'hpp': ['cpp', 'cxx'],
	\ 'HPP': ['CPP', 'CXX'],
	\ }
let g:next_alter#search_dir = ['.', '..', '../..', '.././src']
" }}}

NeoBundle 'hail2u/vim-css3-syntax'
NeoBundle 'othree/html5.vim'

" javascript
NeoBundle 'kchmck/vim-coffee-script'
NeoBundle 'moll/vim-node'
NeoBundle 'pangloss/vim-javascript'

NeoBundle 'kana/vim-smartchr'
NeoBundle 'bronson/vim-trailing-whitespace'

" vimrc に記述されたプラグインでインストールされていないものがないかチェックする
NeoBundleCheck
call neobundle#end()

filetype plugin indent on

" どうせだから jellybeans カラースキーマを使ってみましょう
set t_Co=256

syntax on
colorscheme jellybeans
