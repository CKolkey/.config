" Plugin Settings & Mappings PRE {{{
  " POLYGLOT {{{
    let g:polyglot_disabled = ['ruby', 'eruby', 'slim']
  " }}}
" }}}

" Plugins {{{
" Auto-Install vim-plug {{{
  if empty(glob('~/.config/nvim/autoload/plug.vim'))
    silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
          \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
  endif
" }}}
call plug#begin()
  Plug 'ryanoasis/vim-devicons'                                 " Nice icons for Files
  Plug 'joshdick/onedark.vim'                                   " Colorscheme

  Plug 'wincent/ferret'                                         " Find and Replace across files
  Plug 'wincent/scalpel'                                        " Replace word under Cursor in buffer/selection. Activate with <leader-e>
  Plug 'tommcdo/vim-lion'                                       " Align characters across lines
  Plug 'romainl/vim-cool'                                       " Clear Search Highlights automatically
  Plug 'dense-analysis/ale'                                     " Async Linting and Fixing
  Plug 'Krasjet/auto.pairs'                                     " Autoclose Parens intelligently
  Plug 'rhysd/clever-f.vim'                                     " Improvement to 'f' and 'F', 't', and 'T'
  Plug 'qpkorr/vim-bufkill'                                     " Close Buffers without closing Splits
  Plug 'sheerun/vim-polyglot'                                   " Load on Demand Language Packages
  Plug 'vim-ruby/vim-ruby'                                      " Use Ruby Package Specifically as it's more up-to-date than polyglot
  Plug 'slim-template/vim-slim'                                 " Use Slim Pagkage Specifically as it's more up to date
  Plug 'andymass/vim-matchup'                                   " Paren/def&end highlighting
  Plug 'pechorin/any-jump.vim'                                  " IDE like Reference Finding and Method Definitions
  Plug 'rrethy/vim-hexokinase', { 'do': 'make hexokinase' }     " Colorize HEX codes
  Plug 'airblade/vim-gitgutter'                                 " Git Line status in left gutter
  Plug 'chaoren/vim-wordmotion'                                 " Add more word objects, like camelCase
  Plug 'machakann/vim-highlightedyank'                          " Highlight Yanked Text
  Plug 'christoomey/vim-tmux-navigator'                         " Navigate Vim Splits and Tmux Splits like they are the same thing
  Plug 'Shougo/defx.nvim', { 'do': ':UpdateRemotePlugins' }     " File tree Browser
  Plug 'kristijanhusak/defx-icons'                              " Icons for File Tree Browser
  Plug 'ludovicchabant/vim-gutentags'                           " Manage CTags and GTags
  Plug 'skywind3000/gutentags_plus'                             " Manage CTags and GTags
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }           " File finder, text finder, buffer finder
  Plug 'junegunn/fzf.vim'
  Plug 'vim-airline/vim-airline'                                " Status Bar and Tab Bar
  Plug 'vim-airline/vim-airline-themes'
  Plug 'tpope/vim-rails'                                        " Rails Specific Commands
  Plug 'tpope/vim-endwise'                                      " Place an 'end' in ruby blocks automatically
  Plug 'tpope/vim-repeat'                                       " Improvements to . repeat
  Plug 'tpope/vim-fugitive'                                     " Git Integration
  Plug 'tpope/vim-sensible'                                     " Sensible Default Configs
  Plug 'tpope/vim-surround'                                     " Operations on parens, brackts, quotes
  Plug 'tpope/vim-commentary'                                   " Comment-out lines

  " neovim 0.5
  Plug 'nvim-treesitter/nvim-treesitter'
  Plug 'nvim-treesitter/nvim-treesitter-refactor'
  Plug 'neovim/nvim-lspconfig'
  Plug 'nvim-lua/diagnostic-nvim'
  Plug 'nvim-lua/completion-nvim'
  Plug 'steelsojka/completion-buffers'
  Plug 'nvim-treesitter/completion-treesitter'
call plug#end()
" }}}

" Plugin Settings & Mappings POST {{{
" AIRLINE{{{
  let g:airline#extensions#ale#enabled          = 1
  let g:airline#extensions#tabline#enabled      = 1
  let g:airline#extensions#tabline#formatter    = 'unique_tail_improved'
  let g:airline#extensions#bufferline#enabled   = 1
  let g:airline#extensions#gutentags#enabled    = 1
  let g:airline_theme                           = 'deus'
  let g:airline_powerline_fonts                 = 1
  let g:airline_left_sep                        = '█'
  let g:airline_right_sep                       = '█'
  let g:airline_left_alt_sep                    = ' '
  let g:airline#extensions#tabline#left_sep     = '█'
  let g:airline#extensions#tabline#right_sep    = '█'
  let g:airline#extensions#tabline#left_alt_sep = ' '
"}}}
" ALE{{{
  " from: https://github.com/fohte/rubocop-daemon
  let g:ale_ruby_rubocop_executable = 'rubocop-daemon-wrapper'
  let g:ale_ruby_reek_executable    = 'reek'

  let g:ale_linters = {
    \   'javascript': ['eslint'],
    \   'ruby':       ['rubocop', 'reek', 'solargraph'],
    \}

  let g:ale_fixers = {
    \   '*':          ['remove_trailing_lines', 'trim_whitespace'],
    \   'ruby':       ['rubocop'],
    \   'javascript': ['prettier', 'eslint'],
    \   'css' :       ['prettier'],
    \   'html' :      ['prettier'],
    \   'markdown' :  ['prettier'],
    \   'yaml':       ['prettier'],
    \   'json':       ['prettier'],
    \}

  let g:ale_fix_on_save        = 1
  let g:ale_fix_on_save_ignore = { 'javascript': ['prettier'] }
  let g:ale_linters_explicit   = 1
  let g:ale_sign_column_always = 1
  let g:ale_sign_error         = '!!'
  let g:ale_sign_warning       = '~>'
"}}}
" ANY-JUMP {{{
  let g:any_jump_window_width_ratio  = 0.7
  let g:any_jump_window_height_ratio = 0.6
  let g:any_jump_window_top_offset   = 4

  augroup anyjump
    autocmd!
    autocmd FileType any-jump setlocal nonumber norelativenumber signcolumn=no
  augroup END
" }}}
" CLEVER-F {{{
  let g:clever_f_smart_case        = 1
  let g:clever_f_fix_key_direction = 1
  " let g:clever_f_mark_char_color   = ''

  augroup clever-f-plugin-set-color
    autocmd!
    autocmd Colorscheme * highlight default CleverFDefaultLabel ctermfg=NONE ctermbg=NONE cterm=bold guifg=#E06C75 guibg=NONE gui=bold
  augroup END
" }}}
" DEFX Filetree browser {{{
  nnoremap <silent>- :Defx<CR>
  call defx#custom#option('_', {
    \ 'columns': 'space:indent:icons:filename:type',
    \ 'winwidth': 50,
    \ 'split': 'vertical',
    \ 'direction': 'topleft',
    \ 'show_ignored_files': 1,
    \ 'resume': 1,
    \ 'toggle': 1,
    \ 'root_marker': ' ',
  \})

  call defx#custom#column('filename', { 'root_marker_highlight': 'Ignore' })

  let g:defx_icons_directory_symlink_icon  = '>'
  let g:defx_icons_directory_icon          = '+'
  let g:defx_icons_root_opened_tree_icon   = '-'
  let g:defx_icons_nested_opened_tree_icon = '-'
  let g:defx_icons_nested_closed_tree_icon = '+'
  let g:defx_icons_enable_syntax_highlight = 1
  let g:defx_icons_column_length           = 2
  let g:defx_icons_mark_icon               = '*'
  let g:defx_icons_copy_icon               = ''
  let g:defx_icons_move_icon               = ''
  let g:defx_icons_parent_icon             = ' '
  let g:defx_icons_default_icon            = ''

  augroup defx_init
    autocmd!
    autocmd BufWritePost * call defx#redraw() " Redraw on file change
    autocmd FileType defx call s:defx_init()  " Load Settings
  augroup END

  function! s:defx_init()
    setl nonumber
    setl norelativenumber
    setl listchars=
    setl nofoldenable
    setl foldmethod=manual
    setl signcolumn=no

    " Define Mappings
    nnoremap <silent><nowait><buffer><expr> <esc>
      \ defx#do_action('quit')
    nnoremap <silent><nowait><buffer><expr> <CR>
      \ defx#do_action('multi', ['drop', 'quit'])
    nnoremap <silent><nowait><buffer><expr> .
      \ defx#do_action('toggle_ignored_files')
    nnoremap <silent><nowait><buffer><expr> c
      \ defx#do_action('copy')
    nnoremap <silent><nowait><buffer><expr> q
      \ defx#do_action('quit')
    nnoremap <silent><nowait><buffer><expr> m
      \ defx#do_action('move')
    nnoremap <silent><nowait><buffer><expr> p
      \ defx#do_action('paste')
    nnoremap <silent><nowait><buffer><expr> l
      \ defx#do_action('open_tree')
    nnoremap <silent><nowait><buffer><expr> h
      \ defx#do_action('close_tree')
    nnoremap <silent><nowait><buffer><expr> v
      \ defx#do_action('multi', [['drop', 'vsplit'], 'quit'])
    nnoremap <silent><nowait><buffer><expr> s
      \ defx#do_action('multi', [['drop', 'split'], 'quit'])
    nnoremap <silent><nowait><buffer><expr> t
      \ defx#do_action('drop', 'tabedit')
    nnoremap <silent><nowait><buffer><expr> n
      \ defx#do_action('new_file')
    nnoremap <silent><nowait><buffer><expr> dd
      \ defx#do_action('remove')
    nnoremap <silent><nowait><buffer><expr> r
      \ defx#do_action('rename')
    nnoremap <silent><nowait><buffer><expr> <C-r>
      \ defx#do_action('redraw')
    nnoremap <silent><nowait><buffer><expr> >
      \ defx#do_action('resize', defx#get_context().winwidth + 10)
    nnoremap <silent><nowait><buffer><expr> <
      \ defx#do_action('resize', defx#get_context().winwidth - 10)
  endfunction
" }}}
" ENDWISE {{{
  " See function: SMART ENTER FOR AUTOCOMPLETION
  let g:endwise_no_mappings = 1
" }}}
" FERRET {{{
  nnoremap <silent> <Up> :cprevious<CR>
  nnoremap <silent> <Down> :cnext<CR>
  nnoremap <silent> <Left> :cpfile<CR>
  nnoremap <silent> <Right> :cnfile<CR>

  nnoremap <silent> <S-Up> :lprevious<CR>
  nnoremap <silent> <S-Down> :lnext<CR>
  nnoremap <silent> <S-Left> :lpfile<CR>
  nnoremap <silent> <S-Right> :lnfile<CR>
" }}}
" FZF{{{
  nnoremap <silent><c-g> :RG<cr>
  nnoremap <silent><c-f> :Files<CR>
  nnoremap <silent><c-b> :Buffers<cr>

  let $FZF_DEFAULT_COMMAND = 'rg --files --no-ignore-vcs --hidden -g "!{node_modules,.git,tmp,storage}"'

  command! -bang -nargs=? -complete=dir Files
  \ call fzf#vim#files(<q-args>, fzf#vim#with_preview({'options': ['--layout=reverse', '--margin=1,2']}), <bang>0)

  function! s:build_quickfix_list(lines)
    call setqflist(map(copy(a:lines), '{ "filename": v:val }'))
    copen
    cc
  endfunction

  let g:fzf_action = {
        \ 'ctrl-s': 'split',
        \ 'ctrl-v': 'vsplit',
        \ 'ctrl-t': 'tab split',
        \ 'ctrl-q': function('s:build_quickfix_list')
        \ }

  let g:fzf_history_dir = '~/.cache/nvim/fzf-history'
  let g:fzf_layout = { 'window': 'call CreateCenteredFloatingWindow()' }

  let g:fzf_colors = {
        \ 'fg':      ['fg', 'Normal'],
        \ 'bg':      ['bg', 'Normal'],
        \ 'hl':      ['fg', 'Keyword'],
        \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'PreProc'],
        \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
        \ 'hl+':     ['fg', 'Keyword'],
        \ 'info':    ['fg', 'Statement'],
        \ 'border':  ['fg', 'Comment'],
        \ 'prompt':  ['fg', 'Conditional'],
        \ 'pointer': ['fg', 'Statement'],
        \ 'marker':  ['fg', 'Keyword'],
        \ 'spinner': ['fg', 'Label'],
        \ 'header':  ['fg', 'Keyword'] }

  command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)

  function! RipgrepFzf(query, fullscreen)
    let command_fmt     = 'rg --column --line-number --no-heading --color=always --smart-case %s || true'
    let initial_command = printf(command_fmt, shellescape(a:query))
    let reload_command  = printf(command_fmt, '{q}')
    let spec            = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command, '--layout=reverse', '--margin=1,2']}
    call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
  endfunction
"}}}
" GITGUTTER {{{
  let g:gitgutter_sign_added             = '▌'
  let g:gitgutter_sign_modified           = '▌'
  let g:gitgutter_sign_modified_removed  = '▌'
  let g:gitgutter_sign_removed_first_line = '▔'
  let g:gitgutter_sign_removed           = '▁'
" }}}
" GUTENTAGS {{{
  " enable gtags module
  let g:gutentags_modules = ['ctags', 'gtags_cscope']

  " config project root markers.
  let g:gutentags_project_root = ['.root', '.git']

  " generate datebases in cache directory, prevent gtags files polluting my project
  let g:gutentags_cache_dir = expand('~/.cache/tags')

  " change focus to quickfix window after search (optional).
  let g:gutentags_plus_switch              = 1

  let g:gutentags_generate_on_new          = 1
  let g:gutentags_generate_on_missing      = 1
  let g:gutentags_generate_on_write        = 1
  let g:gutentags_generate_on_empty_buffer = 0

  let g:gutentags_ctags_exclude = [
    \ '*.git', '*.svg', '*.hg',
    \ '*/tests/*',
    \ 'build',
    \ 'dist',
    \ '*sites/*/files/*',
    \ 'bin',
    \ 'node_modules',
    \ 'bower_components',
    \ 'cache',
    \ 'compiled',
    \ 'docs',
    \ 'example',
    \ 'bundle',
    \ 'vendor',
    \ '*.md',
    \ '*-lock.json',
    \ '*.lock',
    \ '*bundle*.js',
    \ '*build*.js',
    \ '.*rc*',
    \ '*.json',
    \ '*.min.*',
    \ '*.map',
    \ '*.bak',
    \ '*.zip',
    \ '*.pyc',
    \ '*.class',
    \ '*.sln',
    \ '*.Master',
    \ '*.csproj',
    \ '*.tmp',
    \ '*.csproj.user',
    \ '*.cache',
    \ '*.pdb',
    \ 'tags*',
    \ 'cscope.*',
    \ '*.css',
    \ '*.less',
    \ '*.scss',
    \ '*.exe', '*.dll',
    \ '*.mp3', '*.ogg', '*.flac',
    \ '*.swp', '*.swo',
    \ '*.bmp', '*.gif', '*.ico', '*.jpg', '*.png',
    \ '*.rar', '*.zip', '*.tar', '*.tar.gz', '*.tar.xz', '*.tar.bz2',
    \ '*.pdf', '*.doc', '*.docx', '*.ppt', '*.pptx',
    \ ]

" }}}
" HEXOKINASE (COLORIZER) {{{
  let g:Hexokinase_highlighters = [ 'backgroundfull' ]
  let g:Hexokinase_ftEnabled    = ['css', 'html', 'javascript', 'sass', 'slim', 'vim']
  let g:Hexokinase_optInPatterns = [
  \     'full_hex',
  \     'triple_hex',
  \     'rgb',
  \     'rgba',
  \     'hsl',
  \     'hsla'
  \ ]
" }}}
" MATCHUP{{{
  augroup matchup_matchparen_highlight
    autocmd!
    autocmd ColorScheme * hi MatchParen guifg=#c678dd gui=bold
    autocmd ColorScheme * hi MatchWord  guifg=#FFCB6B gui=italic
  augroup END
  let g:matchup_surround_enabled     = 1
  let g:matchup_matchparen_deferred  = 1
  let g:matchup_matchparen_offscreen = {}
"}}}
  " NVIM COMPLETION {{{
    " Use <Tab> and <S-Tab> to navigate through popup menu
    inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
    inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

    " Set completeopt to have a better completion experience
    set completeopt=menuone,noinsert,noselect

    " Avoid showing message extra message when using completion
    set shortmess+=c

    augroup loadLSPFeatures
      autocmd!
      autocmd BufEnter * lua require'completion'.on_attach()
    augroup end

lua << EOF
local on_attach_vim = function(client)
  require'completion'.on_attach(client)
  require'diagnostic'.on_attach(client)
end

require'nvim_lsp'.tsserver.setup{on_attach=on_attach_vim}
require'nvim_lsp'.solargraph.setup{on_attach=on_attach_vim}

completion_chain_complete_list = {
  { complete_items = { 'lsp' } },
  { complete_items = { 'buffers' } },
  { complete_items = { 'treesitter' } },
  { mode = { '<c-p>' } },
  { mode = { '<c-n>' } }
}
EOF
  " }}}
  " NVIM TREESITTER {{{
lua <<EOF
  require'nvim-treesitter.configs'.setup {
    ensure_installed = "all",
    highlight = {
      enable = true,
      custom_captures = {
        ["variable.builtin"] = "PreProc"
      }
    },
    refactor = {
      highlight_definitions = { enable = false },
      smart_rename = {
        enable = true,
        keymaps = {
          smart_rename = "grr",
        },
      },
    },
  }
EOF
  " }}}
  " NVIM LSP {{{
lua <<EOF
require'nvim_lsp'.solargraph.setup {
  commandPath = "~/.rbenv/shims/solargraph",
}

require'nvim_lsp'.tsserver.setup{}
EOF
  " }}}
" }}}

" General Settings {{{
  filetype plugin indent on
  set cursorline            " Highlight cursor line
  set number                " Show line number
  set relativenumber        " Show Relative Line Numbers
  set noshowmode            " Status line makes this unneeded
  set numberwidth=5         " Make the line number column wider
  set backspace=indent,eol,start
  set tabstop=2
  set shiftwidth=2
  set expandtab
  set shiftround            " Use multiple of shiftwidth when indenting with > and <
  set autoindent
  set incsearch             " Show matches While searching
  set inccommand=split      " Show substitutions live
  set ignorecase            " ignore case on search
  set smartcase             " Ignores case if search is all lower, case sensitive otherwise
  set hlsearch              " Highlight Search
  set visualbell            " don't beep
  set noerrorbells          " don't beep
  set belloff=all           " don't flash
  set pastetoggle=<F2>      " turn on paste mode with F2
  set noswapfile
  set splitbelow            " split below, not above
  set splitright            " split right, not left
  set foldmethod=marker     " Fold code between {{{ and }}}
  set grepprg=rg\ --vimgrep " Use RipGrep for grepping
  set clipboard+=unnamedplus " Use system Clipboard
  set scrolloff=6          " Keep 10 lines above/below cursor
  set lazyredraw           " Don't redaw screen while executing macro
  set winwidth=80
  set winheight=10
  set list
  set listchars=tab:››,nbsp:⦸,trail:•,extends:»,precedes:«
  set shortmess=atIAcW      " Hidden startup messages
  set hidden                " allows you to nav away from an unsaved buffer
  set updatetime=300        " You will have bad experience for diagnostic messages when it's default 4000.
  set signcolumn=yes        " always show signcolumns
  set fillchars+=eob:\      " Don't show ~ off end of buffer
  set virtualedit=block     " allow cursor to move where there is no text in visual block mode

  set backup
  set undofile              " Persistant Undo
  set undodir=$HOME/.cache/nvim/undo
  set backupdir=$HOME/.cache/nvim/backup

  set wildmenu
  set wildmode=full
  set wildignore+=*.so,*.pyc,*.png,*.jpg,*.gif,*.jpeg,*.ico,*.pdf
  set wildignore+=*.wav,*.mp4,*.mp3
  set wildignore+=*.o,*.out,*.obj,.git,*.rbc,*.rbo,*.class,.svn,*.gem
  set wildignore+=*.zip,*.tar.gz,*.tar.bz2,*.rar,*.tar.xz
  set wildignore+=*/vendor/gems/*,*/vendor/cache/*,*/.bundle/*,*/.sass-cache/*
  set wildignore+=*.swp,*~,._*
  set wildignore+=_pycache_,.DS_Store,.vscode,.localized
  set wildignore+=.cache,node_modules,package-lock.json,yarn.lock,dist,.git
  set wildignore+=.vimruncmd

  set encoding=utf-8
  setglobal fileencoding=utf-8

  if (has("nvim"))
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif

  if (has("termguicolors"))
    set termguicolors
  endif

  " As Root {{{
    if exists('$SUDO_USER')
      set noswapfile
      set nobackup
      set nowritebackup
      set noundofile
    endif
  " }}}
" }}}

" AutoCommands {{{
" AUTORELOAD CHANGED FILES {{{
    set autoread
    augroup autoreadfiles
      autocmd!
      autocmd FocusGained,BufEnter * silent! checktime
      autocmd FileChangedShellPost * echohl WarningMsg | echo "File changed on disk - Buffer reloaded" | echohl None
    augroup END
" }}}
" AUTOSAVE CURRENT BUFFER {{{
  augroup autosavebuffer
    autocmd!
    " autocmd InsertLeave * nested silent! update
    autocmd InsertLeave * nested call timer_start(50, { -> execute("silent! update") })
  augroup end
" }}}
  " RELATIVE LINE NUMBERS IN NORMAL MODE, ABSOLUTE NUMBERS IN INSERT MODE {{{
    augroup numbertoggle
      autocmd!
      autocmd InsertLeave * set relativenumber
      autocmd InsertEnter * set norelativenumber
    augroup END
  " }}}
  " AUTOSOURCE VIMRC ON SAVE {{{
    augroup autosource
      autocmd!
      autocmd BufWritePost $MYVIMRC nested source $MYVIMRC
    augroup END
  " }}}
  " TERMINAL BEHAVIOR {{{
    augroup TerminalBehavior
      autocmd!
      autocmd TermOpen * setlocal listchars= nonumber norelativenumber nowrap winfixwidth noruler signcolumn=no noshowmode
      autocmd TermOpen * startinsert
      autocmd TermClose * set showmode ruler
    augroup END
  " }}}
  " EASYQUIT {{{
    augroup easyquit
      autocmd!
      autocmd Filetype help nnoremap <buffer> q :q<CR>
    augroup END
  " }}}
  " FORMATTING {{{
    augroup niceformating
      autocmd!
      autocmd BufWinEnter * set fo-=c fo-=r fo-=o " Disable continuation of comments to the next line
      autocmd BufWinEnter * set formatoptions+=j  " Remove a comment leader when joining lines
    augroup END
  " }}}
" }}}

" Functions {{{
  " RESIZE MODE {{{
    let g:resize_active=0
    function! ToggleResizeMode()
      if g:resize_active == 0
        let g:resize_active = 1
        echom 'Resize Mode'
        " ESC should exit
        nnoremap <esc> :call ToggleResizeMode()<CR>
        " Switch to resize keys
        nnoremap h <C-w><
        nnoremap j <C-w>-
        nnoremap k <C-w>+
        nnoremap l <C-w>>
        " Switch to window moving keys
        nnoremap H <C-w>H
        nnoremap J <C-w>J
        nnoremap K <C-w>K
        nnoremap L <C-w>L
        nnoremap = <C-w>=
        nnoremap _ <C-w>_
        nnoremap + <C-w><bar>
      else
        let g:resize_active = 0
        " Switch back to 'normal' keys
        nnoremap <esc> <esc>
        nnoremap h h
        nnoremap k gk
        nnoremap j gj
        nnoremap l l
        nnoremap K K
        nnoremap J J
        nnoremap H ^
        nnoremap L $
        nnoremap = =
        nnoremap _ _
        nnoremap + +
        echom ''
      endif
    endfunction
    nnoremap <silent><nowait> <Leader>r :call ToggleResizeMode()<CR>
  " }}}
  " TERMINAL DRAWER {{{
    " depends on: CLEAN UI and Terminal Behavior
    nnoremap <silent>``           :call ToggleTerminalDrawer()<CR>
    tnoremap <silent>`` <C-\><C-n>:call ToggleTerminalDrawer()<CR>

    let g:terminal_drawer_height   = 0.25
    let g:terminal_drawer_position = "botright"

    let g:terminal_drawer = { 'win_id': v:null, 'buffer_id': v:null }
    function! ToggleTerminalDrawer() abort
      if win_gotoid(g:terminal_drawer.win_id)
        hide
        set laststatus=2 showmode ruler
      else
        exec g:terminal_drawer_position . " new"
        if !g:terminal_drawer.buffer_id
          call termopen($SHELL, {"detach": 0})
          let g:terminal_drawer.buffer_id = bufnr("")
        else
          exec 'buffer' g:terminal_drawer.buffer_id
          call RemoveEmptyBuffers()
        endif

        exec 'resize' float2nr(&lines * g:terminal_drawer_height)
        setlocal laststatus=0 noshowmode noruler
        setlocal nobuflisted
        echo ''
        startinsert!
        let g:terminal_drawer.win_id = win_getid()

        tnoremap <buffer><Esc> <C-\><C-n>
        nnoremap <buffer><silent><Esc> :call ToggleTerminalDrawer()<CR>
        nnoremap <buffer><silent> q :call ToggleTerminalDrawer()<CR>
      endif
    endfunction
  " }}}
  " LAZYGIT {{{
    function! ToggleLazyGit()
      echo "Loaded Lazygit"
      call ToggleTerm('lazygit')
    endfunction

    nnoremap <silent><leader>ll :call ToggleLazyGit()<cr>
    tnoremap <silent><leader>ll <C-\><C-n>:call ToggleLazyGit()<CR>
  " }}}
  " CREATE FLOATING WINDOW {{{
    function! CreateCenteredFloatingWindow()
      let width  = float2nr(&columns * 0.9)
      let height = float2nr(&lines * 0.8)
      let top    = ((&lines - height) / 2) - 1
      let left   = (&columns - width) / 2
      let opts   = { 'relative': 'editor', 'row': top, 'col': left, 'width': width, 'height': height, 'style': 'minimal' }

      let top_line    = "╭" . repeat("─", width - 2) . "╮"
      let mid_line    = "│" . repeat(" ", width - 2) . "│"
      let bot_line    = "╰" . repeat("─", width - 2) . "╯"
      let lines  = [top_line] + repeat([mid_line], height - 2) + [bot_line]
      let s:buf  = nvim_create_buf(v:false, v:true)

      call nvim_buf_set_lines(s:buf, 0, -1, v:true, lines)
      call nvim_open_win(s:buf, v:true, opts)
      set winhl=Normal:Floating
      call InvertBackground()

      call nvim_open_win(nvim_create_buf(v:false, v:true), v:true, CreatePadding(opts))
      autocmd BufWipeout <buffer> exe 'bwipeout '.s:buf
      autocmd BufWipeout <buffer> call ResetBackground()
    endfunction

    function! CreatePadding(opts)
      let a:opts.row    += 1
      let a:opts.height -= 2
      let a:opts.col    += 2
      let a:opts.width  -= 4
      return a:opts
    endfunction
  " }}}
  " TOGGLE TERMINAL && ON TERMINAL EXIT {{{
    function! ToggleTerm(cmd)
      if empty(bufname(a:cmd))
        call CreateCenteredFloatingWindow()
        call termopen(a:cmd, { 'on_exit': function('OnTermExit') })
      else
        bwipeout!
      endif
    endfunction

    function! OnTermExit(job_id, code, event) dict
      if a:code == 0
        bwipeout!
      endif
    endfunction
  " }}}
  " INVERT && RESET BACKGROUND {{{
    function! InvertBackground()
      hi InactiveWindow guibg=NONE
      hi ActiveWindow   guibg=#2c323c
      set winhighlight=Normal:ActiveWindow,NormalNC:InactiveWindow
    endfunction

    function! ResetBackground()
      hi ActiveWindow   guibg=NONE
      hi InactiveWindow guibg=#2c323c
      set winhighlight=Normal:ActiveWindow,NormalNC:InactiveWindow
    endfunction
  " }}}
  " REMOVE EMPTY BUFFERS {{{
    function! RemoveEmptyBuffers()
      let buffers = filter(range(1, bufnr('$')), 'buflisted(v:val) && empty(bufname(v:val)) && bufwinnr(v:val)<0 && !getbufvar(v:val, "&mod")')
      if !empty(buffers)
          silent exe 'bw ' . join(buffers, ' ')
      endif
    endfunction
  " }}}
  " SMART ENTER FOR AUTOCOMPLETION {{{
    " complete_info()["selected"] is '-1' when nothing is selected
    imap <expr> <CR> (pumvisible() ? (complete_info()["selected"] == "-1" ?  "\<CR>\<Plug>DiscretionaryEnd" :  "\<C-Y>\<Plug>DiscretionaryEnd") : "\<CR>\<Plug>DiscretionaryEnd" )
  "}}}
" }}}

" Key Mappings {{{
  let mapleader = "\\"

  nnoremap <leader>vi :e $MYVIMRC<cr>
  nnoremap <leader>pu :PlugUpdate<cr>
  nnoremap <leader>h  :Helptags<cr>
  nnoremap <leader>bb obinding.pry<esc>:w<cr>^
  nnoremap <leader>fr :%s///gc<left><left><left><left>
  " Open Last Buffer
  nnoremap <Leader><Leader> <C-^>

  " GoBuffer List
  nnoremap gb :ls<CR>:b<Space>

  " Play Last Macro with Q
  nnoremap Q @@

  " For debugging ColorSchemes
  map <F10> :echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')<cr>

  " More sane vertical navigation - respects columns
  nnoremap k gk
  nnoremap j gj
  vnoremap k gk
  vnoremap j gj

  " rebinds semi-colon in normal mode.
  nnoremap ; :

  nnoremap <f7> :bprevious<cr>
  nnoremap <f8> :tabnext<cr>
  nnoremap <f9> :bnext<cr>

  " Change text without putting the text into register,
  nnoremap c "_c
  nnoremap C "_C
  nnoremap cc "_cc

  " Y yanks to the end of the line instead of the whole line (like D)
  nnoremap Y y$

  " vv selects the whole line, just like dd deletes the whole line
  nnoremap vv V
  " V selects till the end of the line just like D deletes till eol
  nnoremap V v$h

  " Insert mode: go to beginning of word
  inoremap <C-b> <C-o>b
  " Insert mode: go to end of word
  inoremap <C-f> <C-o>e<C-o>l
  " Insert mode: delete following word
  inoremap <expr><C-d> strcharpart(getline('.')[col('.') - 1:], 0, 1) == ' ' ? "\<C-o>d2w" : "\<C-o>dw"

  " Remove Arrow Keys in Insert Mode
  inoremap <Up>    <Nop>
  inoremap <Down>  <Nop>
  inoremap <Left>  <Nop>
  inoremap <Right> <Nop>
  " And remove other navigations that are defined elsewhere
  map $            <Nop>
  map ^            <Nop>
  nmap >>          <Nop>
  nmap <<          <Nop>
  vmap >>          <Nop>
  vmap <<          <Nop>

  noremap H     g^
  noremap L     g_

  " Close split using c-q, close pane keeping split with c-w
  " plugin: bufkill
  noremap  <C-q> :bw<Cr>
  noremap  <C-w> :BW<Cr>
  noremap  <C-e> <C-w>c<Cr>

  " buffer splits
  nmap <silent><nowait><leader>sh  :leftabove  vnew<CR>:bnext<CR>:call RemoveEmptyBuffers()<CR>
  nmap <silent><nowait><leader>sl  :rightbelow vnew<CR>:bnext<CR>:call RemoveEmptyBuffers()<CR>
  nmap <silent><nowait><leader>sj  :leftabove  new<CR>:bnext<CR>:call RemoveEmptyBuffers()<CR>
  nmap <silent><nowait><leader>sk  :rightbelow new<CR>:bnext<CR>:call RemoveEmptyBuffers()<CR>

  " Enter inserts newline without leaving Normal mode
  nmap <s-cr> O<Esc>
  nmap <cr>   o<Esc>

  " Center Search Results
  nnoremap <silent> n nzz
  nnoremap <silent> N Nzz
  nnoremap <silent> * *zz
  nnoremap <silent> # #zz


  " use tab and shift tab to indent and de-indent code
  nnoremap <Tab>   >>
  nnoremap <S-Tab> <<
  vnoremap <Tab>   >><Esc>gv
  vnoremap <S-Tab> <<<Esc>gv

  " jump list next (F20 is what c-i sends, thanks to Karabiner. This addresses collision with Tab)
  nnoremap <F20> <c-i>

  " " Quicker window movement
  " nnoremap <C-j> <C-w>j
  " nnoremap <C-k> <C-w>k
  " nnoremap <C-h> <C-w>h
  " nnoremap <C-l> <C-w>l
  tnoremap <C-h> <C-\><C-n><C-w>h
  tnoremap <C-j> <C-\><C-n><C-w>j
  tnoremap <C-k> <C-\><C-n><C-w>k
  tnoremap <C-l> <C-\><C-n><C-w>l

  " Moves selected Lines up and Down with alt-j/k
  nnoremap <silent> ∆ :m .+1<CR>==
  nnoremap <silent> ˚ :m .-2<CR>==
  inoremap <silent> ∆ <Esc>:m .+1<CR>==gi
  inoremap <silent> ˚ <Esc>:m .-2<CR>==gi
  vnoremap <silent> ∆ :m '>+1<CR>gv=gv
  vnoremap <silent> ˚ :m '<-2<CR>gv=gv
" }}}

" Language Settings {{{
  " Ruby {{{
    let ruby_operators               = 1
    let ruby_line_continuation_error = 1
    let ruby_pseudo_operators        = 1
    let ruby_space_errors            = 1
    let ruby_global_variable_error   = 1
    let ruby_spellcheck_strings      = 1

    augroup setRubyFiletype
      autocmd!
      autocmd BufNewFile,BufRead *.rb set syntax=ruby
    augroup END
  " }}}
  " Slim {{{
    autocmd BufNewFile,BufRead *.slim setlocal filetype=slim
  " }}}
" }}}

" Colorscheme & Highlights {{{
  if (has("autocmd") && !has("gui_running"))
    augroup colorset
      autocmd!
      let s:yellow      = { "gui": "#FFE082", "cterm": "180", "cterm16": "3"  }
      let s:purple      = { "gui": "#C792EA", "cterm": "170", "cterm16": "5"  }
      let s:blue        = { "gui": "#82AAFF", "cterm": "39",  "cterm16": "4"  }
      let s:red         = { "gui": "#E06C75", "cterm": "204", "cterm16": "1"  }
      let s:dark_yellow = { "gui": "#FFCB6B", "cterm": "173", "cterm16": "11" }

      autocmd ColorScheme * call onedark#set_highlight("Constant",            { "fg": s:yellow      })
      " autocmd ColorScheme * call onedark#set_highlight("Statement",           { "fg": s:blue        })
      autocmd ColorScheme * call onedark#set_highlight("Macro",               { "fg": s:blue        })
      autocmd ColorScheme * call onedark#set_highlight("CursorLineNr",        { "fg": s:yellow      })
      autocmd ColorScheme * call onedark#set_highlight("rubyConstant",        { "fg": s:dark_yellow })
      autocmd ColorScheme * call onedark#set_highlight("rubySymbolDelimiter", { "fg": s:red         })
      autocmd ColorScheme * call onedark#set_highlight("rubyKeywordAsMethod", { "fg": s:blue        })
      autocmd ColorScheme * call onedark#set_highlight("rubySymbol",          { "fg": s:yellow      })
      autocmd ColorScheme * call onedark#set_highlight("rubyPseudoVariable",  { "fg": s:red         })
      autocmd ColorScheme * call onedark#set_highlight("rubyBoolean",         { "fg": s:red         })
      autocmd ColorScheme * call onedark#set_highlight("rubyInteger",         { "fg": s:red         })
    augroup END
  endif

  let g:onedark_terminal_italics = 1
  let g:onedark_color_overrides  = {
    \ "black":       { "gui": "#181a1b", "cterm": "235", "cterm16": "0"  },
    \ "green":       { "gui": "#C3E88D", "cterm": "114", "cterm16": "2"  },
    \ "yellow":      { "gui": "#FFE082", "cterm": "180", "cterm16": "3"  },
    \ "dark_yellow": { "gui": "#FFCB6B", "cterm": "173", "cterm16": "11" },
    \ "blue":        { "gui": "#82AAFF", "cterm": "39",  "cterm16": "4"  },
    \ "purple":      { "gui": "#C792EA", "cterm": "170", "cterm16": "5"  },
    \ "cyan":        { "gui": "#89DDF3", "cterm": "38",  "cterm16": "6"  },
    \ "white":       { "gui": "#FCFCFC", "cterm": "145", "cterm16": "7"  },
    \}

  syntax on
  colorscheme onedark

  " Custom Italics
  highlight htmlArg   gui=italic
  highlight Comment   gui=italic
  highlight Type      gui=italic
  highlight sassClass gui=italic
  highlight slimClass gui=italic guifg=#ffe082
  highlight slimId    gui=italic guifg=#82AAFF
  highlight slimAttr  gui=italic

  " Active and Inactive window bg color
  hi ActiveWindow   guibg=NONE
  hi InactiveWindow guibg=#2c323c
  set winhighlight=Normal:ActiveWindow,NormalNC:InactiveWindow

  " Set Transparent Background
  hi Normal guibg=NONE

  " DIRVISH GIT {{{
    hi default DirvishGitModified guifg=#FFE082
    hi default DirvishGitRenamed  guifg=#FFE082
    hi default DirvishGitStaged   guifg=#C3E88D
    hi default DirvishGitUnmerged guifg=#E06C75
  " }}}
" }}}
