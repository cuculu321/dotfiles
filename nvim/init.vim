
" reset augroup
augroup MyAutoCmd
    autocmd!
augroup END

" ENV
let $CACHE = empty($XDG_CACHE_HOME) ? expand('$HOME/.cache') : $XDG_CACHE_HOME
let $CONFIG = empty($XDG_CONFIG_HOME) ? expand('$HOME/.config') : $XDG_CONFIG_HOME
let $DATA = empty($XDG_DATA_HOME) ? expand('$HOME/.local/share') : $XDG_DATA_HOME

" Load rc file
function! s:load(file) abort
    let s:path = expand('$CONFIG/nvim/rc/' . a:file . '.vim')

    if filereadable(s:path)
        execute 'source' fnameescape(s:path)
    endif
endfunction

call s:load('plugins')

set clipboard+=unnamed
set shortmess-=S

" dein.vim settings {{{
" install dir {{{
let s:dein_dir = expand('~/.cache/dein')
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'
" }}}
" dein installation check {{{
if &runtimepath !~# '/dein.vim'
  if !isdirectory(s:dein_repo_dir)
    execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
  endif
  execute 'set runtimepath^=' . s:dein_repo_dir
endif
" }}}
" begin settings {{{
if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)
  " .toml file
  let s:rc_dir = expand('~/.config/nvim')
  if !isdirectory(s:rc_dir)
    call mkdir(s:rc_dir, 'p')
  endif
  let s:toml = s:rc_dir . '/dein.toml'
  " read toml and cache
  call dein#load_toml(s:toml, {'lazy': 0})
  " end settings
  call dein#end()
  call dein#save_state()
endif
" }}}
" plugin installation check {{{
if dein#check_install()
  call dein#install()
endif
" dein.vim settings {{{
" install dir {{{
let s:dein_dir = expand('~/.cache/dein')
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'
" }}}
" dein installation check {{{
if &runtimepath !~# '/dein.vim'
  if !isdirectory(s:dein_repo_dir)
    execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
  endif
  execute 'set runtimepath^=' . s:dein_repo_dir
endif
" }}}
" begin settings {{{
if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)
  " .toml file
  let s:rc_dir = expand('~/.vim')
  if !isdirectory(s:rc_dir)
    call mkdir(s:rc_dir, 'p')
  endif
  let s:toml = s:rc_dir . '/dein.toml'
  " read toml and cache
  call dein#load_toml(s:toml, {'lazy': 0})
  " end settings
  call dein#end()
  call dein#save_state()
endif
" }}}
" plugin installation check {{{
if dein#check_install()
  call dein#install()
endif
let g:acp_enableAtStartup = 0
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_smart_case = 1
let g:neocomplete#sources#syntax#min_keyword_length = 3
let g:neocomplete#sources#dictionary#dictionaries = {
    \ 'default' : '',
    \ 'vimshell' : $HOME.'/.vimshell_hist',
    \ 'scheme' : $HOME.'/.gosh_completions'
        \ }
if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'
inoremap <expr><C-g>     neocomplete#undo_completion()
inoremap <expr><C-l>     neocomplete#complete_common_string()
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  A
  return (pumvisible() ? '\<C-y>' : '' ) . '\<CR>'
endfunction
inoremap <expr><TAB>  pumvisible() ? '\<C-n>' : '\<TAB>'
inoremap <expr><C-h> neocomplete#smart_close_popup().'\<C-h>'
inoremap <expr><BS> neocomplete#smart_close_popup().'\<C-h>'
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif
let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'
let g:neosnippet#snippets_directory = ['~/.cache/dein/repos/github.com/Shougo/neosnippet-snippets/neosnippets','~/.cache/dein/repos/github.com/sameyasu/neosnippet-php-functions/neosnippets',]
inoremap <expr><BS> neocomplete#smart_close_popup().'<C-h>'
imap <expr><CR> neosnippet#expandable() ? '<Plug>(neosnippet_expand_or_jump)' : pumvisible() ? '<C-y>' : '<CR>'
imap <expr><TAB> pumvisible() ? '<C-n>' : neosnippet#jumpable() ? '<Plug>(neosnippet_expand_or_jump)' : '<TAB>'
if has('conceal')
  set conceallevel=2 concealcursor=niv
endif
let g:neosnippet#snippets_directory = ['~/.cache/dein/repos/github.com/Shougo/neosnippet-snippets/neosnippets','~/.cache/dein/repos/github.com/sameyasu/neosnippet-php-functions/neosnippets',]

nnoremap <C-]> g<C-]>
inoremap <C-]> <ESC>g<C-]>

syntax on

" _________________________________________
" \_ _/ ____| ____| ___ \ ____| ___ \  ___/
"  | | |____| ____| ___ < ____| __  / |__ \
" /___\_____|_____|_____/_____|_| \_\_____/
"
"  cool-headed perspective for your coding
"
"
" File:       iceberg.vim
" Maintainer: cocopon <cocopon@me.com>
" Modified:   2020-03-06 09:55+0900
" License:    MIT


if !has('gui_running') && &t_Co < 256
  finish
endif

set background=dark
hi clear

if exists('syntax_on')
  syntax reset
endif

let g:colors_name = 'iceberg'


hi! ColorColumn cterm=NONE ctermbg=235 guibg=#1e2132
hi! CursorColumn cterm=NONE ctermbg=235 guibg=#1e2132
hi! CursorLine cterm=NONE ctermbg=235 guibg=#1e2132
hi! Comment ctermfg=242 guifg=#6b7089
hi! Constant ctermfg=140 guifg=#a093c7
hi! Cursor ctermbg=252 ctermfg=234 guibg=#c6c8d1 guifg=#161821
hi! CursorLineNr cterm=NONE ctermbg=237 ctermfg=253 guibg=#2a3158 guifg=#cdd1e6
hi! Delimiter ctermfg=252 guifg=#c6c8d1
hi! DiffAdd ctermbg=29 ctermfg=158 guibg=#45493e guifg=#c0c5b9
hi! DiffChange ctermbg=23 ctermfg=159 guibg=#384851 guifg=#b3c3cc
hi! DiffDelete ctermbg=95 ctermfg=224 guibg=#53343b guifg=#ceb0b6
hi! DiffText cterm=NONE ctermbg=30 ctermfg=195 gui=NONE guibg=#5b7881 guifg=#c6c8d1
hi! Directory ctermfg=109 guifg=#89b8c2
hi! Error ctermbg=234 ctermfg=203 guibg=#161821 guifg=#e27878
hi! ErrorMsg ctermbg=234 ctermfg=203 guibg=#161821 guifg=#e27878
hi! WarningMsg ctermbg=234 ctermfg=203 guibg=#161821 guifg=#e27878
hi! EndOfBuffer ctermbg=234 ctermfg=236 guibg=#161821 guifg=#242940
hi! NonText ctermbg=234 ctermfg=236 guibg=#161821 guifg=#242940
hi! SpecialKey ctermbg=234 ctermfg=236 guibg=#161821 guifg=#242940
hi! Folded ctermbg=235 ctermfg=245 guibg=#1e2132 guifg=#686f9a
hi! FoldColumn ctermbg=235 ctermfg=239 guibg=#1e2132 guifg=#444b71
hi! Function ctermfg=110 guifg=#84a0c6
hi! Identifier cterm=NONE ctermfg=109 guifg=#89b8c2
hi! Include ctermfg=110 guifg=#84a0c6
hi! LineNr ctermbg=235 ctermfg=239 guibg=#1e2132 guifg=#444b71
hi! MatchParen ctermbg=237 ctermfg=255 guibg=#3e445e guifg=#ffffff
hi! MoreMsg ctermfg=150 guifg=#b4be82
hi! Normal ctermbg=234 ctermfg=252 guibg=#161821 guifg=#c6c8d1
hi! Operator ctermfg=110 guifg=#84a0c6
hi! Pmenu ctermbg=236 ctermfg=251 guibg=#3d425b guifg=#c6c8d1
hi! PmenuSbar ctermbg=236 guibg=#3d425b
hi! PmenuSel ctermbg=240 ctermfg=255 guibg=#5b6389 guifg=#eff0f4
hi! PmenuThumb ctermbg=251 guibg=#c6c8d1
hi! PreProc ctermfg=150 guifg=#b4be82
hi! Question ctermfg=150 guifg=#b4be82
hi! QuickFixLine ctermbg=236 ctermfg=252 guibg=#272c42 guifg=#c6c8d1
hi! Search ctermbg=216 ctermfg=234 guibg=#e4aa80 guifg=#392313
hi! SignColumn ctermbg=235 ctermfg=239 guibg=#1e2132 guifg=#444b71
hi! Special ctermfg=150 guifg=#b4be82
hi! SpellBad ctermbg=95 ctermfg=252 gui=undercurl guisp=#e27878
hi! SpellCap ctermbg=24 ctermfg=252 gui=undercurl guisp=#84a0c6
hi! SpellLocal ctermbg=23 ctermfg=252 gui=undercurl guisp=#89b8c2
hi! SpellRare ctermbg=97 ctermfg=252 gui=undercurl guisp=#a093c7
hi! Statement ctermfg=110 gui=NONE guifg=#84a0c6
hi! StatusLine cterm=reverse ctermbg=234 ctermfg=245 gui=reverse guibg=#17171b guifg=#818596 term=reverse
hi! StatusLineTerm cterm=reverse ctermbg=234 ctermfg=245 gui=reverse guibg=#17171b guifg=#818596 term=reverse
hi! StatusLineNC cterm=reverse ctermbg=238 ctermfg=233 gui=reverse guibg=#3e445e guifg=#0f1117
hi! StatusLineTermNC cterm=reverse ctermbg=238 ctermfg=233 gui=reverse guibg=#3e445e guifg=#0f1117
hi! StorageClass ctermfg=110 guifg=#84a0c6
hi! String ctermfg=109 guifg=#89b8c2
hi! Structure ctermfg=110 guifg=#84a0c6
hi! TabLine cterm=NONE ctermbg=233 ctermfg=238 gui=NONE guibg=#0f1117 guifg=#3e445e
hi! TabLineFill cterm=reverse ctermbg=238 ctermfg=233 gui=reverse guibg=#3e445e guifg=#0f1117
hi! TabLineSel cterm=NONE ctermbg=234 ctermfg=252 gui=NONE guibg=#161821 guifg=#9a9ca5
hi! TermCursorNC ctermbg=242 ctermfg=234 guibg=#6b7089 guifg=#161821
hi! Title ctermfg=216 gui=NONE guifg=#e2a478
hi! Todo ctermbg=234 ctermfg=150 guibg=#45493e guifg=#b4be82
hi! Type ctermfg=110 gui=NONE guifg=#84a0c6
hi! Underlined cterm=underline ctermfg=110 gui=underline guifg=#84a0c6 term=underline
hi! VertSplit cterm=NONE ctermbg=233 ctermfg=233 gui=NONE guibg=#0f1117 guifg=#0f1117
hi! Visual ctermbg=236 guibg=#272c42
hi! WildMenu ctermbg=255 ctermfg=234 guibg=#d4d5db guifg=#17171b
hi! diffAdded ctermfg=150 guifg=#b4be82
hi! diffRemoved ctermfg=203 guifg=#e27878
hi! ALEErrorSign ctermbg=235 ctermfg=203 guibg=#1e2132 guifg=#e27878
hi! ALEWarningSign ctermbg=235 ctermfg=216 guibg=#1e2132 guifg=#e2a478
hi! ALEVirtualTextError ctermfg=203 guifg=#e27878
hi! ALEVirtualTextWarning ctermfg=216 guifg=#e2a478
hi! CtrlPMode1 ctermbg=236 ctermfg=242 guibg=#2e313f guifg=#6b7089
hi! EasyMotionShade ctermfg=239 guifg=#3d425b
hi! EasyMotionTarget ctermfg=150 guifg=#b4be82
hi! EasyMotionTarget2First ctermfg=216 guifg=#e2a478
hi! EasyMotionTarget2Second ctermfg=216 guifg=#e2a478
hi! GitGutterAdd ctermbg=235 ctermfg=150 guibg=#1e2132 guifg=#b4be82
hi! GitGutterChange ctermbg=235 ctermfg=109 guibg=#1e2132 guifg=#89b8c2
hi! GitGutterChangeDelete ctermbg=235 ctermfg=109 guibg=#1e2132 guifg=#89b8c2
hi! GitGutterDelete ctermbg=235 ctermfg=203 guibg=#1e2132 guifg=#e27878
hi! gitmessengerEndOfBuffer ctermbg=235 ctermfg=239 guibg=#1e2132 guifg=#444b71
hi! gitmessengerPopupNormal ctermbg=235 ctermfg=252 guibg=#1e2132 guifg=#c6c8d1
hi! Sneak ctermbg=140 ctermfg=234 guibg=#a093c7 guifg=#161821
hi! SneakScope ctermbg=236 ctermfg=242 guibg=#272c42 guifg=#6b7089
hi! SyntasticErrorSign ctermbg=235 ctermfg=203 guibg=#1e2132 guifg=#e27878
hi! SyntasticStyleErrorSign ctermbg=235 ctermfg=203 guibg=#1e2132 guifg=#e27878
hi! SyntasticStyleWarningSign ctermbg=235 ctermfg=216 guibg=#1e2132 guifg=#e2a478
hi! SyntasticWarningSign ctermbg=235 ctermfg=216 guibg=#1e2132 guifg=#e2a478
hi! ZenSpace ctermbg=203 guibg=#e27878
hi! icebergALAccentRed ctermfg=203 guifg=#e27878

hi! link TermCursor Cursor
hi! link cssBraces Delimiter
hi! link cssClassName Special
hi! link cssClassNameDot Normal
hi! link cssPseudoClassId Special
hi! link cssTagName Statement
hi! link helpHyperTextJump Constant
hi! link htmlArg Constant
hi! link htmlEndTag Statement
hi! link htmlTag Statement
hi! link jsonQuote Normal
hi! link phpVarSelector Identifier
hi! link pythonFunction Title
hi! link rubyDefine Statement
hi! link rubyFunction Title
hi! link rubyInterpolationDelimiter String
hi! link rubySharpBang Comment
hi! link rubyStringDelimiter String
hi! link sassClass Special
hi! link shFunction Normal
hi! link vimContinue Comment
hi! link vimFuncSID vimFunction
hi! link vimFuncVar Normal
hi! link vimFunction Title
hi! link vimGroup Statement
hi! link vimHiGroup Statement
hi! link vimHiTerm Identifier
hi! link vimMapModKey Special
hi! link vimOption Identifier
hi! link vimVar Normal
hi! link xmlAttrib Constant
hi! link xmlAttribPunct Statement
hi! link xmlEndTag Statement
hi! link xmlNamespace Statement
hi! link xmlTag Statement
hi! link xmlTagName Statement
hi! link yamlKeyValueDelimiter Delimiter
hi! link CtrlPPrtCursor Cursor
hi! link CtrlPMatch Title
hi! link CtrlPMode2 StatusLine
hi! link deniteMatched Normal
hi! link deniteMatchedChar Title
hi! link elixirBlockDefinition Statement
hi! link elixirDefine Statement
hi! link elixirDocSigilDelimiter String
hi! link elixirDocTest String
hi! link elixirExUnitMacro Statement
hi! link elixirExceptionDefine Statement
hi! link elixirFunctionDeclaration Title
hi! link elixirKeyword Statement
hi! link elixirModuleDeclaration Normal
hi! link elixirModuleDefine Statement
hi! link elixirPrivateDefine Statement
hi! link elixirStringDelimiter String
hi! link jsFlowMaybe Normal
hi! link jsFlowObject Normal
hi! link jsFlowType PreProc
hi! link graphqlName Normal
hi! link graphqlOperator Normal
hi! link gitmessengerHash Comment
hi! link gitmessengerHeader Statement
hi! link gitmessengerHistory Constant
hi! link jsArrowFunction Operator
hi! link jsClassDefinition Normal
hi! link jsClassFuncName Title
hi! link jsExport Statement
hi! link jsFuncName Title
hi! link jsFutureKeys Statement
hi! link jsFuncCall Normal
hi! link jsGlobalObjects Statement
hi! link jsModuleKeywords Statement
hi! link jsModuleOperators Statement
hi! link jsNull Constant
hi! link jsObjectFuncName Title
hi! link jsObjectKey Identifier
hi! link jsSuper Statement
hi! link jsTemplateBraces Special
hi! link jsUndefined Constant
hi! link markdownBold Special
hi! link markdownCode String
hi! link markdownCodeDelimiter String
hi! link markdownHeadingDelimiter Comment
hi! link markdownRule Comment
hi! link ngxDirective Statement
hi! link plug1 Normal
hi! link plug2 Identifier
hi! link plugDash Comment
hi! link plugMessage Special
hi! link SignifySignAdd GitGutterAdd
hi! link SignifySignChange GitGutterChange
hi! link SignifySignChangeDelete GitGutterChangeDelete
hi! link SignifySignDelete GitGutterDelete
hi! link SignifySignDeleteFirstLine SignifySignDelete
hi! link StartifyBracket Comment
hi! link StartifyFile Identifier
hi! link StartifyFooter Constant
hi! link StartifyHeader Constant
hi! link StartifyNumber Special
hi! link StartifyPath Comment
hi! link StartifySection Statement
hi! link StartifySlash Comment
hi! link StartifySpecial Normal
hi! link svssBraces Delimiter
hi! link swiftIdentifier Normal
hi! link typescriptAjaxMethods Normal
hi! link typescriptBraces Normal
hi! link typescriptEndColons Normal
hi! link typescriptFuncKeyword Statement
hi! link typescriptGlobalObjects Statement
hi! link typescriptHtmlElemProperties Normal
hi! link typescriptIdentifier Statement
hi! link typescriptMessage Normal
hi! link typescriptNull Constant
hi! link typescriptParens Normal

if has('nvim')
  let g:terminal_color_0 = '#1e2132'
  let g:terminal_color_1 = '#e27878'
  let g:terminal_color_2 = '#b4be82'
  let g:terminal_color_3 = '#e2a478'
  let g:terminal_color_4 = '#84a0c6'
  let g:terminal_color_5 = '#a093c7'
  let g:terminal_color_6 = '#89b8c2'
  let g:terminal_color_7 = '#c6c8d1'
  let g:terminal_color_8 = '#6b7089'
  let g:terminal_color_9 = '#e98989'
  let g:terminal_color_10 = '#c0ca8e'
  let g:terminal_color_11 = '#e9b189'
  let g:terminal_color_12 = '#91acd1'
  let g:terminal_color_13 = '#ada0d3'
  let g:terminal_color_14 = '#95c4ce'
  let g:terminal_color_15 = '#d2d4de'
else
  let g:terminal_ansi_colors = ['#1e2132', '#e27878', '#b4be82', '#e2a478', '#84a0c6', '#a093c7', '#89b8c2', '#c6c8d1', '#6b7089', '#e98989', '#c0ca8e', '#e9b189', '#91acd1', '#ada0d3', '#95c4ce', '#d2d4de']
endif

"==========================================="
"==========================================="
:set number
inoremap jk  <Esc>

" ウィンドウ分割を楽にする設定
nnoremap ss :<C-u>sp<CR>
nnoremap sv :<C-u>vs<CR>
nnoremap sq :<C-u>q<CR>
nnoremap sQ :<C-u>bd<CR>
nnoremap sj <C-w>j
nnoremap sk <C-w>k
nnoremap sl <C-w>l
nnoremap sh <C-w>h
nnoremap sJ <C-w>J
nnoremap sK <C-w>K
nnoremap sL <C-w>L
nnoremap sH <C-w>H

"タブ操作
nnoremap st :<C-u>tabnew<CR>
nnoremap sn gt
nnoremap sp gT
nnoremap ; :

""set expandtab
set tabstop=4
set title
set shiftwidth=4
set smartindent
set hidden
set virtualedit=block
set whichwrap=b,s,[,],<,>
set backspace=indent,eol,start
set scrolloff=3
set ignorecase
set incsearch
set hlsearch

nnoremap <silent> <ESC><ESC> :nohlsearch<CR>

set laststatus=2

nnoremap <Space>gst :tab sp<CR>:Gstatus<CR>:only<CR>
nnoremap <Space>gad :Gwrite<CR>
nnoremap <Space>gcm :Gcommit<CR>
nnoremap <Space>gdif :Gdiff<CR>
nnoremap <Space>gb :Gblame<CR>
nnoremap <Space>gl :Git log<CR>
nnoremap <Space>gh :tab sp<CR>:0Glog<CR>

inoremap { {}<Left>
inoremap [ []<Left>
inoremap ( ()<Left>
inoremap ' ''<LEFT>
inoremap " ""<LEFT>
inoremap {<Enter> {}<Left><CR><ESC><S-o>
inoremap [<Enter> []<Left><CR><ESC><S-o>
inoremap (<Enter> ()<Left><CR><ESC><S-o>

augroup MyXML
autocmd!
	autocmd Filetype xml inoremap <buffer> </ </<C-x><C-o>
	autocmd Filetype html inoremap <buffer> </ </<C-x><C-o>
	autocmd Filetype php inoremap <buffer> </ </<C-x><C-o>
augroup END

set showmatch
set matchtime=1
set matchpairs& matchpairs+=<:>

inoremap zl ->
