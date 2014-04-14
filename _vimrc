source ~/.vim/bundles.vim
" ***************************************************************************
" This vimrc is based on the vimrc by Easwy Yang & Steve Francia
" @ http://github.com/easwy/share/tree/master/vim/vimrc/
" @ https://github.com/spf13/spf13-vim.git
"
" @ Maintainer  :	ruby- Li
" @ Last change :	2013 Jan 29
" @ Designed for:   ruby-'s vim on Mac OS X 10.7.5
" @ Get it      :   https://github.com/ruby-/ruby--s-toolcrib.git
" ***************************************************************************

" ***************************************************************************
"    General                                                            
" ************************************************************************-{{{

    " Automatically detect file types
    filetype plugin indent on
                                                                       
    " Encoding Settings for Languages Supporting
    set fileencodings=ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,euc-kr,latin1

    " For MacOSX macvim
    " Skip move-mappings in gvimrc (located in content of macvim.app)
    let macvim_skip_cmd_opt_movement = 1

    " Platform detection
    function! MySys()
        if has("win32")
            return "windows"
        else
            return  "linux"
        endif
    endfunction

    if has("win32")
        set fileencoding=chinese
    else
        set fileencoding=utf-8
    endif

    let &termencoding=&encoding 

    " encoding for console 
    language messages zh_CN.utf-8

    " allow backspacing over everything in insert mode
    set backspace=indent,eol,start

    set nocp           " Let vim work in incompatible mode
    set history=500    " keep 50 lines of command line history
    set incsearch      " do incremental searching
    set ignorecase     " ignore case searching
    set nobackup       " no backup
    set showmatch      " show match brackets/parenthesis
    set winminheight=0 " windows can be 0 line high
    set smartcase      " case sensitive when uc present
    set hlsearch
    set autoindent     " always set autoindenting on
    set tabpagemax=15  " only show 15 tabs
    set showmode       " display the current mode
    set cursorline     " highlight current line

    " Enable mouse usage
    if has('mouse')
      set mouse=a
    endif

    " Put these in an autocmd group, so that we can delete them easily.
    augroup vimrcEx
        au!

        " For all text files set 'textwidth' to 78 characters.
        autocmd FileType text setlocal textwidth=78

        " When editing a file, always jump to the last known cursor position.
        " Don't do it when the position is invalid or when inside an event handler
        " (happens when dropping a file on gvim).
        " Also don't do it when the mark is in the first line, that is the default
        " position when opening a file.
        autocmd BufReadPost *
        \ if line("'\"") > 1 && line("'\"") <= line("$") |
        \   exe "normal! g`\"" |
        \ endif
    augroup END
                                                                       "--}}}


" ***************************************************************************
"    Basic Terminal
" ***********************************************************************-{{{

    "set t_Co=256			"using console terminal capable of 256 colors
    "set term=xterm-256color
    let mapleader = ","
    syntax on
    scriptencoding utf-8

    " quick set up .vimrc
    if MySys() == 'windows'
        map <silent> <leader>ss :source ~/_vimrc<cr>
        map <silent> <leader>ee :call SwitchToBuf("~/_vimrc")<cr>
        " When _vimrc is edited, reload it
        autocmd! bufwritepost _vimrc source ~/_vimrc
    else
        map <silent> <leader>ss :source ~/.vimrc<cr>
        map <silent> <leader>ee :call SwitchToBuf("~/.vimrc")<cr>
        autocmd! bufwritepost .vimrc source ~/.vimrc
    endif

    " set autowrite
    set virtualedit=onemore             " allow for cursor beyond last character
    set spell                           " spell checking on
    set hidden                          " allow buffer switching without saving

    " set up the directories
    au BufWinLeave *.* silent! mkview   " make vim save view (state) (folds, cursor, etc)
    au BufWinEnter *.* silent! loadview " make vim load view (state) (folds, cursor, etc)

    " Autocomplete for (, {, [, <
    :inoremap (9 ()<ESC>i
    :inoremap (<cr> ();<ESC>hi<cr>
    :inoremap ) <c-r>=ClosePair(')')<CR>
    :inoremap { {}<ESC>i
    :inoremap {<CR> {<CR>}<ESC>O
    :inoremap } <c-r>=ClosePair('}')<CR>
    :inoremap [[ []<ESC>i
    :inoremap ] <c-r>=ClosePair(']')<CR>
    :inoremap "" ""<ESC>i
    :inoremap <c-o><CR> <c-o>$<space>{<CR>}<ESC>O
    :inoremap `` ``<ESC>i
    " :inoremap ' ''<ESC>i
    " ; to the end
    :inoremap ;; <ESC>$a;<ESC>
                                                                       "--}}}


" ***************************************************************************
"    Vim UI  
" ***********************************************************************-{{{

    set guifont=Monaco:h12
    set nu			        " line number

    " Different colorscheme for vim/macvim
    if has('gui_running')
          colorscheme codeschool
          set guioptions-=T
          set lines=40
          set transparency=5
    else 
          colorscheme macvim
    endif

    if has("cmdline_info")
        set ruler			" show the cursor position at any time
        set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%) " a ruler on steroid
        set showcmd			" display incomplete command; show partial command in status line and selected
                            "characters/lines in visual mode
    endif 

                                                                        "--}}}


" ***************************************************************************
"    Formatting 
" ***********************************************************************-{{{

    set wrap linebreak nolist                        " set line wrap , use prefix 'g'[$0...] to move around in wrapped lines
    set showbreak=...                                " knows where the line break is
    command! -nargs=* Wrap set wrap linebreak nolist " use just one command to do line wrap
    set tabstop=4                                    " set table space 4
    set expandtab                                    " tabs are spaces, not tabs
    set softtabstop=4                                " set backspace width
    set shiftwidth=4                                 " set indent space for everylevel

    " Don't use Ex mode, use Q for formatting
    map Q gq

    " Remove trailing whitespaces and ^M chars
    autocmd FileType c,cpp,java,php,javascript,jsp,python,twig,xml,yml autocmd BufWritePre <buffer> :call setline(1,map(getline(1,"$"),'substitute(v:val,"\\s\\+$","","")'))

    " Folding 
    " set fdm=marker      " fold by marker
    set foldenable      " auto fold code
    set foldmethod=indent
    nnoremap <space> @=((foldclosed(line('.')) < 0) ? 'zc' : 'zo')<CR> " use <space> to fold
    nnoremap zO zR
    nnoremap zC zM

                                                                        "--}}}


" ***************************************************************************
"   key (re)Mappings 
" ***********************************************************************-{{{

    " Wrapped line goes down/up to next row, rather than next line in file
    nnoremap j gj
    nnoremap k gk

    " Don't use SHIFT keys for following *"cmap" means command mode bonding
    cmap WQ wq
    cmap wQ wq
    cmap Q q
    cmap Tabe tabe

    " Switch hlsearch off
    nmap <silent><leader>h :nohlsearch<cr>

    "* Yank to end of line
    nnoremap Y y$

    "* Shortcuts to change directory to currently editing file
    "* Write new files in split/vertical/new table
    cmap cwd lcd %:p:h
    cmap cd. lcd %:p:h
    cnoremap %% <C-R>=expand('%:h').'/'<cr>
    map <leader>ew :e %%
    map <leader>es :sp %%
    map <leader>ev :vsp %%
    map <leader>et :tabe %%
    

    " visual shift doesn't exit visual mode
    vnoremap < <gv
    vnoremap > >gv

    "* Go to first and last letters in a line
    map [F $
    imap [F $
    map [H g^
    imap [H g^
    
    " Easy move around windows
    map <c-h> <c-w>h
    map <c-l> <c-w>l
    map <c-j> <c-w>j
    map <c-k> <c-w>k

    " Move around tabs
    " map <D-t> :tabnew<cr>
    " map <D-w> :tabclose<cr>
    map <D-1> 1gt
    map <D-2> 2gt
    map <D-3> 3gt
    map <D-4> 4gt
    map <D-5> 5gt
    map <D-6> 6gt
    map <D-7> 7gt
    map <D-8> 8gt
    map <D-9> 9gt
    
    " --IDE: Eclim 
    " Import class under cursor 
    nnoremap <silent> <buffer> <leader>i :JavaImport<cr>
    " Import organize
    nnoremap <D-i>      :JavaImportOrganize<cr>
    " Search for javadocs for the element under cursor
    nnoremap <silent> <buffer> <leader>d :JavaDocSearch -x declarations<cr>
    " Quick fix
    nnoremap <silent> <leader>f :lop<cr>
    " Refactoring
    " Place the cursor under class/method/package name to rename
    nnoremap <D-r>      :JavaRename<space>
    " Select range containing data member and issue :JavaConstructor
    vnoremap <D-c>      :JavaConstructor<cr>
    " Override methods for current class (inner) 
    nnoremap <D-o>      :JavaImpl<cr>
    inoremap <D-o>      <ESC>:JavaImpl<cr>
    " Buffertoggle
    nnoremap <D-b>      :BuffersToggle<cr>

    " Getter/setter 
    nnoremap <leader>s :JavaSet<cr>
    vnoremap <leader>s :JavaSet<cr>
    nnoremap <leader>g :JavaGet<cr>
    vnoremap <leader>g :JavaGet<cr>
    nnoremap <leader>gs :JavaGetSet<cr>
    vnoremap <leader>gs :JavaGetSet<cr>
    " Project View
    map <F10>               :ProjectTreeToggle<cr>
    map <F5>                :Java%<cr>

    " Move the editor
    nnoremap <D-n> zz
    inoremap <D-n> <c-o>zz<backspace><cr>

    " --IDE: Ctrlp
    "nnoremap <silent> <D-j> :CtrlP<CR>
    "nnoremap <silent> <D-k> :CtrlPMRU<CR> " MRU (Most Recently Used) files 
    "nnoremap <silent> <D-h> :CtrlPDir<CR>
    "nnoremap <silent> <D-l> :CtrlPTag<CR>


                                                                        "--}}}


" ***************************************************************************
"    Functions 
" ***********************************************************************-{{{

    " edit file in existing tabs, or else in new tab
    function! SwitchToBuf(filename)
        let fullfn=substitute(a:filename, "^\\~/", $HOME . "/", "")
        " find in current tab
        let bufwinnr=bufwinnr(a:filename)
        if bufwinnr!=-1
            exec bufwinnr . "wincmd w"
            return
        else
        " find in each tab
            tabfirst
            let tab=1
            while tab<=tabpagenr("$")
                let bufwinnr=bufwinnr(a:filename)
                if bufwinnr!=-1
                    exec "normal " . tab . "gt"
                    exec bufwinnr . "wincmd w"
                    return
                endif
                tabnext
                let tab=tab+1
            endwhile
            " not exit, new tab
            exec "tabnew " . a:filename
        endif
    endfunction


    " Autocomplete for (, {, [, " support
    function! ClosePair(char)
        if getline('.')[col('.')-1]==a:char
            return "\<Right>"
        else
            return a:char
        endif
    endfunction

    " Cucumbertables.vim: cucumber align for Tabularize
    " Following function automatically aligns when typing a supported
    " character        
    " Usage ->   
    "         | a | b | c|
    "         | x | y | z|
    "       | new   <- automatically align table like this while creating 
    inoremap <silent> <Bar>   <Bar><Esc>:call <SID>align()<CR>a

    function! s:align()
      let p = '^\s*|\s.*\s|\s*$'
      if exists(':Tabularize') && getline('.') =~# '^\s*|' && (getline(line('.')-1) =~# p || getline(line('.')+1) =~# p)
          let column = strlen(substitute(getline('.')[0:col('.')],'[^|]','','g'))
          let position = strlen(matchstr(getline('.')[0:col('.')],'.*|\s*\zs.*'))
          Tabularize/|/l1
          normal! 0
          call search(repeat('[^|]*|',column).'\s\{-\}'.repeat('.',position),'ce',line('.'))
      endif
    endfunction

    " Eclim support
    function! MeetsForJavaEclim(context)
        return g:acp_behaviorJavaEclimLength >= 0 &&
        \ a:context =~ '\k\.\k\{' . g:acp_behaviorJavaEclimLength . ',}$'
    endfunction

                                                                        "--}}}
                                                                    
" ***************************************************************************
"    Plugins
" ***********************************************************************-{{{

    " Tabular {
         nmap <Leader>a& :Tabularize /&<CR>
         vmap <Leader>a& :Tabularize /&<CR>
         nmap <Leader>a= :Tabularize /=<CR>
         vmap <Leader>a= :Tabularize /=<CR>
         nmap <Leader>a: :Tabularize /:<CR>
         vmap <Leader>a: :Tabularize /:<CR>
         nmap <Leader>a:: :Tabularize /:\zs<CR>
         vmap <Leader>a:: :Tabularize /:\zs<CR>
         nmap <Leader>a, :Tabularize /,<CR>
         vmap <Leader>a, :Tabularize /,<CR>
         nmap <Leader>a" :Tabularize /"<CR>
         vmap <Leader>a" :Tabularize /"<CR>
         nmap <Leader>a<Bar> :Tabularize /<Bar><CR>
         vmap <Leader>a<Bar> :Tabularize /<Bar><CR>
    "}

    " ctrlp {
         set wildignore+=*/tmp/*,*.so,*.o,*.a,*.obj,*.swp,*.zip,*.pyc,*.pyo,*.class,.DS_Store  " MacOSX/Linux
         let g:ctrlp_custom_ignore = {
             \ 'dir':  '\.git$\|\.hg$\|\.svn$',
             \ 'file': '\.exe$\|\.so$\|\.dll$' }
        
    "}

    " YCM {
    " Solve conflicts with Ultisnips for <Tab> binding
    let g:ycm_key_list_select_completion = ['<c-n>', '<Down>']
    let g:ycm_key_list_previous_completion = ['<c-p>', '<Up>']
    " }

	" Omnicomplete {
        if has("autocmd") && exists("+omnifunc")
            autocmd Filetype *
            \if &omnifunc == "" |
            \setlocal &omnifunc=syntaxcomplete#Complete |
            \endif
        endif

        hi Pmenu guifg=#000000 guibg=#F8F8F8 ctermfg=black ctermbg=Lightgray
      
        hi PmenuSbar  guifg=#8A95A7 guibg=#F8F8F8 gui=NONE ctermfg=darkcyan ctermbg=lightgray cterm=NONE	
        hi PmenuThumb  guifg=#F8F8F8 guibg=#8A95A7 gui=NONE ctermfg=lightgray ctermbg=darkcyan cterm=NONE
        
        " Some convenient mappings
        " Comment out conflicts short-cuts defined in MacVim.app/Contents/Resources/vim/runtime before using following commends
        inoremap <expr> <Esc>      pumvisible() ? "\<C-e>" : "\<Esc>"
        inoremap <expr> <CR>       pumvisible() ? "\<C-y>" : "\<CR>"
        inoremap <expr> <Down>     pumvisible() ? "\<C-n>" : "\<Down>"
        inoremap <expr> <Up>       pumvisible() ? "\<C-p>" : "\<Up>"
        inoremap <expr> <C-d>      pumvisible() ? "\<PageDown>\<C-p>\<C-n>" : "\<C-d>"
        inoremap <expr> <C-u>      pumvisible() ? "\<PageUp>\<C-p>\<C-n>" : "\<C-u>"

        " Omnicomplete : user define
        inoremap <D-l> <c-x><c-u>
        " Omnicomplete : words
        inoremap <D-j> <c-x><c-o>
        " Omnicomplete : lines
        inoremap <D-h> <c-x><c-l>
        " Omnicomplete : filenames
        inoremap <D-k> <c-x><c-f>
        " Omnicomplete : spell correction
        inoremap <D-s> <c-x><c-s>

        "" Automatically open and close the popup menu / preview window
        au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif
        set completeopt=menu,preview,longest
	"}

    " Optionals for snippet engine [1]
    " ultisnips {
    let g:UltiSnipsExpandTrigger="<tab>"
    let g:UltiSnipsJumpForwardTrigger="<tab>"
    let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
    " }

    " Optionals for snippet engine [2]
    " snipMate {
    "inoremap <expr> <Down>     pumvisible() ? "\<C-n>" : "\<Down>"
    "inoremap <expr> <Up>       pumvisible() ? "\<C-p>" : "\<Up>"
    "}

    " eclim {
    "let g:acp_behaviorJavaEclimLength = 3
    "let g:acp_behavior = {
        "\ 'java': [{
        "\ 'command': "\<c-x>\<c-u>",
        "\ 'completefunc' : 'eclim#java#complete#CodeComplete',
        "\ 'meets'        : 'MeetsForJavaEclim',
        "\ }]
    "\ }
    "}
    
    " PowerLine {
    set guifont=PowerlineSymbols\ for\ Powerline
    set laststatus=2
    let g:Powerline_symbols = 'fancy' 
    " }

    " Hammer {
    " Use <leader>p to easily preview markdown files in default browser
    map <leader>p :Hammer<CR>
    " }

    "* Surround {
    " Use viw to select current word, press "S" to add surroundings like ", '
    " Use csab to change surroundings from a to b
    " Use ysiw] or > or ) to add brackets 
    "}

    "* Easymotion {
    " Use <Leader><Leader>w to open possible position after cursor
    " Use <Leader><Leader>fx to mark all possible place holds character 'x'
    " use <leader><leader>b to open possible position before cursor
    "}

    "* NerdCommentor {
    " Use <Leader>cs: Comment select range
    " Use <leader>cn: comment current selected text in visual mode
    " Use <leader>c<space>: toggle comment
    "}
                        
                                                                        "--}}}
                                                                        

" ***************************************************************************
"    Optionals 
" ***********************************************************************-{{{
    " BufExplorer {
        let g:bufExplorerDefaultHelp=0      " Do not show default help
        let g:bufExplorerShowRelativePath=1 " Show relative path
        let g:bufExplorerSortBy='mru'       " Sort by mostly used
        let g:bufExplorerSplitRight=0       " Split left
        let g:bufExplorerSplitVertical=1    " Split vertically
        let g:bufExplorerSplitVertSize=30   " Split width
        let g:bufExplorerUseCurrentWindow=1 " Open in current window

        nmap <leader>b :BufExplorer<cr>
        autocmd BufWinEnter \[Buf\ List\] setl nonumber	
	"}


    " Tagbar {
        "let g:tagbar_ctags_bin = 'ctags' 
        "let g:tagbar_width = 30
    "}

                                                                       "-}}}

" ***************************************************************************
" Others
" ***************************************************************************
                                                                        
