" Plugin Settings & Mappings PRE {{{
  " POLYGLOT {{{
    let g:polyglot_disabled = ['ruby', 'eruby', 'slim', 'autoindent', 'sensible']
  " }}}
" }}}
" Language Settings {{{
  " Ruby {{{
    let ruby_operators               = 1
    let ruby_line_continuation_error = 1
    let ruby_pseudo_operators        = 1
    let ruby_space_errors            = 1
    let ruby_global_variable_error   = 1
    let ruby_spellcheck_strings      = 1

    let g:ruby_indent_assignment_style = 'hanging'
    let g:ruby_indent_block_style = 'do'
    let g:ruby_indent_hanging_elements = 1
  " }}}
  " Slim {{{
    " autocmd BufNewFile,BufRead *.slim setlocal filetype=slim
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

  Plug 'tommcdo/vim-lion'                                       " Align characters across lines
  Plug 'romainl/vim-cool'                                       " Clear Search Highlights automatically
  Plug 'Krasjet/auto.pairs'                                     " Autoclose Parens intelligently
  Plug 'rhysd/clever-f.vim'                                     " Improvement to 'f' and 'F', 't', and 'T'
  Plug 'jgdavey/vim-turbux'                                     " Send spec's to a second TMUX pane
  Plug 'andymass/vim-matchup'                                   " Paren/def&end highlighting
  Plug 'rrethy/vim-hexokinase', { 'do': 'make hexokinase' }     " Colorize HEX codes
  Plug 'chaoren/vim-wordmotion'                                 " Add more word objects, like camelCase
  Plug 'machakann/vim-highlightedyank'                          " Highlight Yanked Text
  Plug 'christoomey/vim-tmux-navigator'                         " Navigate Vim Splits and Tmux Splits like they are the same thing
  Plug 'ludovicchabant/vim-gutentags'                           " Manage CTags and GTags
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }           " File finder, text finder, buffer finder
  Plug 'junegunn/fzf.vim'
  Plug 'soywod/himalaya', {'rtp': 'vim'}                        " Mail client integration

  Plug 'sheerun/vim-polyglot'                                   " Load on Demand Language Packages
  Plug 'vim-ruby/vim-ruby'                                      " Use Ruby Package Specifically as it's more up-to-date than polyglot
  Plug 'slim-template/vim-slim'                                 " Use Slim Pagkage Specifically as it's more up to date

  Plug 'tpope/vim-rails'                                        " Rails Specific Commands
  Plug 'tpope/vim-endwise'                                      " Place an 'end' in ruby blocks automatically
  Plug 'tpope/vim-repeat'                                       " Improvements to . repeat
  Plug 'tpope/vim-sensible'                                     " Sensible Default Configs
  Plug 'tpope/vim-surround'                                     " Operations on parens, brackts, quotes
  Plug 'tpope/vim-commentary'                                   " Comment-out lines

  if has('nvim-0.5')
    Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' }
    Plug 'code-biscuits/nvim-biscuits'                          " Adds Closing biscuit
    Plug 'neovim/nvim-lspconfig'
    " Plug 'yamatsum/nvim-cursorline'                             " Highlight the same word as under cursor
    Plug 'glepnir/indent-guides.nvim'                           " Indentation Guides
    Plug 'nvim-lua/plenary.nvim'                                " Utilities for LUA
    Plug 'lewis6991/gitsigns.nvim'                              " Gitgutter
    Plug 'hrsh7th/nvim-compe'                                   " Completion
    Plug 'kyazdani42/nvim-web-devicons'                         " Icons for BarBar
    Plug 'kyazdani42/nvim-tree.lua'                             " File Browser
    Plug 'romgrk/barbar.nvim'                                   " BufferLine
    Plug 'glepnir/galaxyline.nvim', {'branch': 'main'}          " StatusLine
    Plug 'nacro90/numb.nvim'                                    " Peek line when typing :{number}
    Plug 'glepnir/lspsaga.nvim'                                 " Code Actions for LSP
    Plug 'stsewd/fzf-checkout.vim'                              " fzf + git checkout
  endif
call plug#end()
" }}}
" Plugin Settings & Mappings POST {{{
  " BARBAR {{{
  let bufferline = get(g:, 'bufferline', {})
  let bufferline.maximum_padding = 2
  " let bufferline.icon_close_tab_modified = '!'
  " }}}
  " CODE BISCUITS {{{
lua <<EOF

require('nvim-biscuits').setup({
  default_config = {
    max_length = 80,
    min_distance = 5,
    prefix_string = " --"
  },
  language_config = {
    ruby = { prefix_string = " # " },
    javascript = { prefix_string = " //" }
  }
})
EOF
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
" ENDWISE {{{
  " See function: SMART ENTER FOR AUTOCOMPLETION
  let g:endwise_no_mappings = v:true
" }}}
" FZF{{{
  " let $FZF_DEFAULT_COMMAND = 'rg --files --no-ignore-vcs --hidden -g "!{node_modules,.git,tmp,storage}"'

  nnoremap <silent><c-g> :RG<cr>
  nnoremap <silent><c-f> :Files<CR>

  " Search for current symbol under cursor
  nnoremap <silent> <C-Space> yiw:RG <C-r>"<CR>
  vnoremap <silent> <C-Space> y:RG <C-r>"<CR>

  command! -bang -nargs=? -complete=dir Files
  \ call fzf#vim#files(<q-args>, fzf#vim#with_preview({'options': ['--layout=reverse', '--margin=1,2']}), <bang>0)

  let g:fzf_history_dir = '~/.cache/nvim/fzf-history'
  let g:fzf_layout = { 'window': { 'width': 1, 'height': 1, 'border': 'top' } }

  augroup FzfAutocmd
    autocmd!
    autocmd FileType fzf call InvertBackground()
      \| autocmd BufLeave <buffer> call ResetBackground()
    autocmd FileType fzf tnoremap <buffer> <C-j> <Down>
    autocmd FileType fzf tnoremap <buffer> <C-k> <Up>
  augroup END

  let g:fzf_action = {
        \ 'ctrl-s': 'split',
        \ 'ctrl-v': 'vsplit',
        \ 'ctrl-t': 'tab split',
        \ }

  function! RipgrepFzf(query, fullscreen)
    let command_fmt     = 'rg --column --line-number --no-heading --color=always --smart-case %s || true'
    let initial_command = printf(command_fmt, shellescape(a:query))
    let reload_command  = printf(command_fmt, '{q}')
    let spec            = {
      \ 'options': [
        \ '--phony',
        \ '--query',
        \ a:query,
        \ '--bind',
        \ 'change:reload:'.reload_command,
        \ '--layout=reverse',
        \ '--margin=0,1',
        \ '--preview-window=down:50%',
        \ '--color=bg+:#2C323C,border:#5C6370,spinner:#E06C75,hl:#E06C75,fg:#FCFCFC,info:#5C6370:italic,pointer:#E06C75,fg+:#FFE082:bold,prompt:#82AAFF,hl+:#E06C75'
      \ ]}

    call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
  endfunction

  command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)
"}}}
  " GALAXY LINE {{{
lua <<EOF
  local buffer_not_empty = function()
    if vim.fn.empty(vim.fn.expand("%:t")) ~= 1 then
      return true
    end
    return false
  end

  local buffer_empty = function()
    if vim.fn.empty(vim.fn.expand("%:t")) ~= 1 then
      return false
    end
    return true
  end

  local gl = require('galaxyline')
  local condition = require('galaxyline.condition')
  local gls = gl.section
  gl.short_line_list = {'NvimTree', 'vista', 'dbui', 'packer', 'QF', "quickfix"}
  vim.api.nvim_command('hi GalaxyLineFillSection guibg=NONE')

  -- {{{ COLORS & LABELS
  local colors = {
      bg          = '#282C34',
      dark_bg     = '#2c323c',
      yellow      = '#FFE082',
      dark_yellow = '#FFCB6B',
      cyan        = '#89DDF3',
      green       = '#98c379',
      orange      = '#FF8800',
      purple      = '#C792EA',
      blue        = '#569CD6',
      red         = '#E06C75',
      error_red   = '#F44747',
      grey        = '#858585',
  }

  local mode_color = {
      n = colors.green,
      i = colors.blue,
      v = colors.purple,
      [''] = colors.purple,
      V = colors.purple,
      c = colors.dark_yellow,
      no = colors.blue,
      s = colors.orange,
      S = colors.orange,
      [''] = colors.orange,
      ic = colors.yellow,
      R = colors.red,
      Rv = colors.red,
      cv = colors.blue,
      ce = colors.blue,
      r = colors.cyan,
      rm = colors.cyan,
      ['r?'] = colors.cyan,
      ['!'] = colors.blue,
      t = colors.blue
  }

  local mode_label = {
      n      = 'NORMAL',
      i      = 'INSERT',
      v      = 'VISUAL',
      [''] = 'V-BLCK',
      V      = 'V-LINE',
      c      = 'COMMND',
      s      = 'SELECT',
      S      = 'S-LINE',
      [''] = 'S-BLCK',
      R      = 'REPLCE',
      Rv     = 'VIRTUL',
      rm     = '--MORE',
      t      = 'TERMNL'
  }
  -- }}}
  -- LEFT {{{
 gls.left[1] = {
     Custom1 = {
         provider = function()
             vim.api.nvim_command('hi GalaxyCustom1 guibg=NONE guifg=' .. mode_color[vim.fn.mode()])
             return " "
         end,
         highlight = {colors.red, colors.bg}
     }
 }

  gls.left[2] = {
      ViMode = {
          provider = function()
              -- auto change color according the vim mode
              vim.api.nvim_command('hi GalaxyViMode guifg=#0f0f0f guibg=' .. mode_color[vim.fn.mode()])
              return " " .. mode_label[vim.fn.mode()] .. " "
          end,
      }
  }

  print(vim.fn.getbufvar(0, 'ts'))
  vim.fn.getbufvar(0, 'ts')

  gls.left[3] = {
      FilePresentIcon = {
          provider = function()
              return '   '
          end,
          condition = buffer_not_empty,
          separator = ' ',
          separator_highlight = {'NONE', colors.bg},
          highlight = {colors.purple, colors.bg}
      }
  }

  gls.left[4] = {
    FileName = {
        provider = 'FileName',
        provider = function()
          return vim.fn.expand("%")
        end,
        condition = buffer_not_empty,
        separator = '',
        separator_highlight = {'NONE', colors.bg},
        highlight = {colors.grey, colors.bg},
    }
  }

  gls.left[5] = {
      GitIcon = {
          provider = function()
              return '   '
          end,
          condition = condition.check_git_workspace,
          separator = ' ',
          separator_highlight = {'NONE', colors.bg},
          highlight = {colors.orange, colors.bg}
      }
  }

  gls.left[6] = {
      GitBranch = {
          provider = 'GitBranch',
          condition = condition.check_git_workspace,
          separator = ' ',
          separator_highlight = {'NONE', colors.bg},
          highlight = {colors.grey, colors.bg}
      }
  }

  gls.left[7] = {
      DiffAdd = {
          provider = 'DiffAdd',
          condition = condition.hide_in_width,
          icon = '  ',
          highlight = {colors.green, colors.bg}
      }
  }

  gls.left[8] = {
      DiffModified = {
          provider = 'DiffModified',
          condition = condition.hide_in_width,
          icon = ' 柳',
          highlight = {colors.blue, colors.bg}
      }
  }

  gls.left[9] = {
      DiffRemove = {
          provider = 'DiffRemove',
          condition = condition.hide_in_width,
          icon = '  ',
          highlight = {colors.red, colors.bg}
      }
  }
 gls.left[10] = {
     Custom4 = {
        provider = function()
            vim.api.nvim_command('hi GalaxyCustom4 guibg=NONE guifg=' .. colors.bg )
            return ""
        end,
     }
  }
 -- }}}
  -- RIGHT {{{
 gls.right[1] = {
     Custom5 = {
        provider = function()
            vim.api.nvim_command('hi GalaxyCustom5 guibg=NONE guifg=' .. colors.bg )
            return ""
        end,
     }
  }
  gls.right[2] = {DiagnosticError = {provider = 'DiagnosticError', icon = '  ', highlight = {colors.error_red, colors.bg} }}
  gls.right[3] = {DiagnosticWarn  = {provider = 'DiagnosticWarn',  icon = '  ', highlight = {colors.yellow, colors.bg} }}
  gls.right[4] = {DiagnosticHint  = {provider = 'DiagnosticHint',  icon = '  ', highlight = {colors.blue, colors.bg} }}
  gls.right[5] = {DiagnosticInfo  = {provider = 'DiagnosticInfo',  icon = '  ', highlight = {colors.blue, colors.bg} }}

  local connected_to_lsp = function()
    local tbl = {['dashboard'] = true, [' '] = true}

    if tbl[vim.bo.filetype] then
      return false
    end

    if buffer_empty() then
      return false
    end

    return true
  end

  gls.right[6] = {
      ShowLspClientIcon = {
          provider = function()
              return ' '
          end,
          condition = connected_to_lsp,
          separator = ' ',
          separator_highlight = {'NONE', colors.bg},
          highlight = {colors.green, colors.bg}
      }
  }

  gls.right[7] = {
      ShowLspClient = {
          provider = 'GetLspClient',
          condition = connected_to_lsp,
          highlight = {colors.grey, colors.bg}
      }
  }

  gls.right[8] = {
      LineInfo = {
          provider = 'LineColumn',
          separator = '  ',
          separator_highlight = {'NONE', colors.bg},
          highlight = {colors.grey, colors.bg}
      }
  }

  gls.right[9] = {
    PerCent = {
        provider = 'LinePercent',
        separator = ' ',
        separator_highlight = {'NONE', colors.bg},
        highlight = {colors.grey, colors.bg}
    }
}

  gls.right[10] = {
      Space = {
          provider = function()
              return ' '
          end,
          separator = ' ',
          separator_highlight = {'NONE', colors.bg},
          highlight = {colors.orange, colors.bg}
      }
  }

 gls.right[11] = {
     Custom2 = {
         provider = function()
             vim.api.nvim_command('hi GalaxyCustom2 guibg=NONE guifg=' .. colors.bg )
             return ""
         end,
         highlight = {colors.red, colors.bg}
     }
 }
  -- }}}
  -- SHORT LINE {{{
  gls.short_line_left[1] = {
      Space = {
          provider = function()
              return ' '
          end,
          separator = '',
          separator_highlight = {'NONE', colors.bg},
          highlight = {colors.orange, colors.bg}
      }
  }

  gls.short_line_left[2] = {
      BufferType = {
          provider = 'FileTypeName',
          separator = '  ',
          separator_highlight = {colors.grey, colors.bg},
          highlight = {colors.grey, colors.bg}
      }
  }

  gls.short_line_left[3] = {
      SFileName = {provider = 'SFileName', condition = condition.buffer_not_empty, highlight = {colors.grey, colors.bg}}
  }

  gls.short_line_right[1] = {FileIcon = {provider = 'FileIcon', highlight = {colors.grey, colors.bg}, condition = buffer_not_empty }}
  -- }}}
EOF
  " }}}
" GITSIGNS {{{
lua <<EOF
require('gitsigns').setup {
  signs = {
    add          = {hl = 'DiffAdd'   , text = '▌', numhl='GitSignsAddNr'},
    change       = {hl = 'DiffChange', text = '▌', numhl='GitSignsChangeNr'},
    topdelete    = {hl = 'DiffDelete', text = '▔', numhl='GitSignsDeleteNr'},
    delete       = {hl = 'DiffDelete', text = '▁', numhl='GitSignsDeleteNr'},
    changedelete = {hl = 'DiffChange', text = '▁', numhl='GitSignsChangeNr'},
  },
  numhl = false,
}
EOF
" }}}
" GUTENTAGS {{{
  " enable gtags module
  let g:gutentags_modules = ['ctags', 'gtags_cscope']

  " config project root markers.
  let g:gutentags_project_root = ['.root', '.git']

  " generate datebases in cache directory, prevent gtags files polluting project
  let g:gutentags_cache_dir = expand('~/.cache/tags')

  let g:gutentags_generate_on_new          = 1
  let g:gutentags_generate_on_missing      = 1
  let g:gutentags_generate_on_write        = 1
  let g:gutentags_generate_on_empty_buffer = 0
  let g:gutentags_ctags_executable         = '/usr/local/bin/ctags'

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
  let g:Hexokinase_highlighters  = ['backgroundfull']
  let g:Hexokinase_ftEnabled     = ['css', 'html', 'javascript', 'sass', 'slim', 'vim']
  let g:Hexokinase_optInPatterns = ['full_hex', 'triple_hex', 'rgb', 'rgba', 'hsl', 'hsla']
" }}}
  " INDENT GUIDES {{{
lua <<EOF
  require('indent_guides').setup({
    exclude_filetypes = {'help','dashboard','dashpreview','NvimTree','vista','sagahover', 'defx', 'fzf', 'terminal'};
    even_colors = { fg = '#2E323A', bg = '#34383F' };
    odd_colors  = { fg = '#34383F', bg = '#2E323A' };
  })
EOF
  " }}}
  " ILLUMINATE {{{
    " augroup illuminate_augroup
    "   autocmd!
    "   autocmd VimEnter * hi illuminatedCurWord gui=bold
    "   autocmd VimEnter * hi illuminatedWord    gui=bold
    " augroup END

    " let g:Illuminate_ftblacklist = ['defx', 'NvimTree']
    " let g:Illuminate_delay = 5000
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
" NUMB {{{
lua <<EOF
require('numb').setup()
EOF
" }}}
" NVIM COMPE {{{
lua <<EOF
require('compe').setup {
  enabled = true;
  autocomplete = true;
  debug = false;
  min_length = 1;
  preselect = 'enable';
  throttle_time = 80;
  source_timeout = 200;
  incomplete_delay = 400;
  max_abbr_width = 100;
  max_kind_width = 100;
  max_menu_width = 100;
  documentation = true;

  source = {
    path = { menu = '[P]' };
    buffer = { menu = '[B]' };
    calc = { menu = '[C]' };
    tags = { menu = '[T]' };
    nvim_lsp = { menu = '[L]' };
    nvim_lua = false;
    vsnip = false;
  };
}
EOF

set completeopt=menuone,noselect

inoremap <silent><expr> <CR>  compe#confirm('<CR>')
inoremap <silent><expr> <C-e> compe#close('<C-e>')

inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ compe#complete()
" }}}
  " NVIM TREESITTER {{{
lua <<EOF
  require'nvim-treesitter.configs'.setup {
    ensure_installed = "all",
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = true,
      custom_captures = {
        ["variable.builtin"] = "PreProc",
      }
    },
    indent = {
      enable = true
    },
  }
EOF
  " }}}
  " NVIM LSP {{{
lua <<EOF
local lspconfig = require "lspconfig"

require('vim.lsp.protocol').CompletionItemKind = {
    ' [text]';        -- = 1;
    ' [method]';      -- = 2;
    ' [function]';    -- = 3;
    ' [constructor]'; -- = 4;
    'ﰠ [field]';       -- = 5;
    '𝒙 [variable]';    -- = 6;
    ' [class]';       -- = 7;
    ' [interface]';   -- = 8;
    ' [module]';      -- = 9;
    ' [property]';    -- = 10;
    ' [unit]';        -- = 11;
    ' [value]';       -- = 12;
    ' [enum]';        -- = 13;
    ' [key]';         -- = 14;
    '﬌ [snippet]';     -- = 15;
    ' [color]';       -- = 16;
    ' [file]';        -- = 17;
    ' [refrence]';    -- = 18;
    ' [folder]';      -- = 19;
    ' [enumMember]';  -- = 20;
    ' [constant]';    -- = 21;
    ' [struct]';      -- = 22;
    ' [event]';       -- = 23;
    ' [operator]';    -- = 24;
    ' [typeParam]';   -- = 25;
}

require('lspsaga').init_lsp_saga()

local map = function(mode, key, result, noremap)
    if noremap == nil then
        noremap = true
    end
    vim.api.nvim_buf_set_keymap(0, mode, key, result, {noremap = noremap, silent = true})
end

_G.formatting = function()
    vim.lsp.buf.formatting(vim.g[string.format("format_options_%s", vim.bo.filetype)] or {})
    vim.cmd [[call TrimEndLines()]]
    vim.cmd [[call TrimWhitespace()]]
end

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, { virtual_text = false, underline = true, signs = true, }
)

vim.lsp.handlers["textDocument/formatting"] = function(err, _, result, _, bufnr)
    if err ~= nil or result == nil then
        return
    end
    if not vim.api.nvim_buf_get_option(bufnr, "modified") then
        local view = vim.fn.winsaveview()
        vim.lsp.util.apply_text_edits(result, bufnr)
        vim.fn.winrestview(view)
        if bufnr == vim.api.nvim_get_current_buf() then
            vim.cmd [[noautocmd :update]]
            -- vim.cmd [[GitGutter]]
        end
    end
end

-- Show Diagnostic Popup on cursor hover
vim.cmd [[autocmd CursorHold * lua vim.lsp.diagnostic.show_line_diagnostics()]]

local on_attach = function(client)
    -- Illuminate handles highlighting keywords
    -- require 'illuminate'.on_attach(client)

    if client.resolved_capabilities.document_formatting then
      -- vim.cmd [[augroup Format]]
      -- vim.cmd [[autocmd! * <buffer>]]
      -- vim.cmd [[autocmd BufWritePost <buffer> lua formatting()]]
      -- vim.cmd [[augroup END]]

      map("n", "<F8>", "<cmd>update<cr><cmd>lua formatting()<cr>")
    end

    if client.resolved_capabilities.signature_help then
      vim.cmd [[autocmd CursorHoldI * silent! lua vim.lsp.buf.signature_help()]]
    end

    if client.resolved_capabilities.goto_definition then
        map("n", "<C-]>", "<cmd>lua vim.lsp.buf.definition()<CR>")
    end

    if client.resolved_capabilities.document_highlight then
        vim.api.nvim_command [[autocmd CursorHold  <buffer> lua vim.lsp.buf.document_highlight()]]
        vim.api.nvim_command [[autocmd CursorHoldI <buffer> lua vim.lsp.buf.document_highlight()]]
        vim.api.nvim_command [[autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()]]
    end

    if client.resolved_capabilities.find_references then
        map("n", "<Leader>*", "<cmd>lua vim.lsp.buf.references()<CR>")
    end

    if client.resolved_capabilities.rename then
        -- map("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>")
        map("n", "<leader>rn", "<cmd>lua require('lspsaga.rename').rename()<CR>")
    end

    if client.resolved_capabilities.code_action then
        vim.cmd [[augroup CodeAction]]
        vim.cmd [[autocmd! * <buffer>]]
        map("n", ",", "<cmd>Lspsaga code_action<CR>")
        vim.cmd [[augroup END]]
    end
end

lspconfig.efm.setup {
    on_attach = on_attach,
    init_options = { documentFormatting = true },
    settings = {
      rootMarkers = {".git/"},
      languages = {
        javascript = {
          lintCommand = "eslint_d -f unix --stdin --stdin-filename ${INPUT}",
          lintIgnoreExitCode = true,
          lintStdin = true,
          lintFormats = {"%f:%l:%c: %m"}
        },
        eruby = {
          lintCommand = "erb -x -T - | ruby -c",
          lintStdin = true,
          lintOffset = 1,
          formatCommand = "htmlbeautifier"
        },
        ruby = {
          lintCommand = "rubocop-daemon-wrapper --format emacs --force-exclusion --stdin ${INPUT}",
          lintIgnoreExitCode = true,
          lintStdin = true,
          lintFormats = {"%f:%l:%c: %m"},
          formatCommand = "rubocop-daemon-wrapper --format emacs --force-exclusion -A --stdin ${INPUT}",
          formatIgnoreExitCode = true,
          formatStdin = true
        }
      }
    }
}

lspconfig.solargraph.setup {
  on_attach = on_attach,
  init_options = { documentFormatting = false },
  on_init = function(client)
        client.config.flags = {}
        if client.config.flags then
          client.config.flags.allow_incremental_sync = true
        end
    end
  }
EOF

sign define LspDiagnosticsSignError       text= numhl=LspDiagnosticsSignError
sign define LspDiagnosticsSignWarning     text= numhl=LspDiagnosticsSignWarning
sign define LspDiagnosticsSignInformation text= numhl=LspDiagnosticsSignInformation
sign define LspDiagnosticsSignHint        text= numhl=LspDiagnosticsSignHint
  " }}}
  " NVIM TREE {{{
lua <<EOF
local g = vim.g

g.nvim_tree_side = "left"
g.nvim_tree_width = 30
g.nvim_tree_ignore = {".git", "node_modules", ".cache"}
g.nvim_tree_auto_open = 0
g.nvim_tree_auto_close = 1
g.nvim_tree_quit_on_open = 1
g.nvim_tree_follow = 1
g.nvim_tree_indent_markers = 1
g.nvim_tree_hide_dotfiles = 0
g.nvim_tree_git_hl = 1
g.nvim_tree_root_folder_modifier = ":~"
g.nvim_tree_tab_open = 1
g.nvim_tree_allow_resize = 1

g.nvim_tree_show_icons = {
    git = 1,
    folders = 1,
    files = 1
}

g.nvim_tree_icons = {
    default = " ",
    symlink = " ",
    git = {
        unstaged = "✗",
        staged = "✓",
        unmerged = "",
        renamed = "➜",
        untracked = "★"
    },
    folder = {
        default = "›",
        open = "⌄",
        symlink = ""
    }
}

local get_lua_cb = function(cb_name)
    return string.format(":lua require'nvim-tree'.on_keypress('%s')<CR>", cb_name)
end

-- Mappings for nvimtree
vim.api.nvim_set_keymap("n", "-", ":NvimTreeToggle<CR>", { noremap = true, silent = true })
g.nvim_tree_bindings = {
    ["<CR>"]           = get_lua_cb("edit"),
    ["l"]              = get_lua_cb("edit"),
    ["v"]              = get_lua_cb("vsplit"),
    ["s"]              = get_lua_cb("split"),
    ["t"]              = get_lua_cb("tabnew"),
    ["h"]              = get_lua_cb("close_node"),
    ["<Tab>"]          = get_lua_cb("preview"),
    ["n"]              = get_lua_cb("create"),
    ["dd"]             = get_lua_cb("remove"),
    ["r"]              = get_lua_cb("rename"),
    ["x"]              = get_lua_cb("cut"),
    ["yy"]             = get_lua_cb("copy"),
    ["p"]              = get_lua_cb("paste"),
    ["-"]              = get_lua_cb("close"),
    ["q"]              = get_lua_cb("close"),

    ["<2-LeftMouse>"]  = get_lua_cb("edit"),
    ["<2-RightMouse>"] = get_lua_cb("cd"),
    ["<C-]>"]          = get_lua_cb("cd"),
    ["I"]              = get_lua_cb("toggle_ignored"),
    ["H"]              = get_lua_cb("toggle_dotfiles"),
    ["R"]              = get_lua_cb("refresh"),
    ["<C-r>"]          = get_lua_cb("full_rename"),
    ["[c"]             = get_lua_cb("prev_git_item"),
    ["]c"]             = get_lua_cb("next_git_item")
}
EOF
  " }}}
  " TURBUX (Test Runner) {{{
    let g:no_turbux_mappings = 1
      nnoremap <silent><leader>m :call SendFocusedTestToTmux(expand('%'), line('.'))<CR>

    nnoremap <silent><leader>M :call SendTestToTmux(expand('%'))<CR>

    let g:turbux_custom_runner = 'TurbuxCustomRunner' " default: (unset)
    function! TurbuxCustomRunner(command)
      call OpenTerminalDrawer()
      call chansend(g:terminal_drawer.terminal_job_id, [a:command, ""])
      return
    endfunction
  " }}}
" }}}
" General Settings {{{
  filetype plugin on
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
  " set smartindent
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
  set scrolloff=6          " Keep n lines above/below cursor
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
  set mouse=a               " Allow mouse to interact with vim

  " Make Dirs {{{
    if !isdirectory($HOME . "/.cache/nvim/backup")
      call mkdir($HOME . "/.cache/nvim/backup", "p", 0700)
    endif

    if !isdirectory($HOME . "/.cache/nvim/undo")
      call mkdir($HOME . "/.cache/nvim/undo", "p", 0700)
    endif
  " }}}
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
      " autocmd FileChangedShellPost * silent redraw!
      " autocmd FileChangedShellPost * echohl WarningMsg | echo "File changed on disk - Buffer reloaded" | echohl None
    augroup END
" }}}
" AUTOSAVE CURRENT BUFFER {{{
  augroup autosavebuffer
    autocmd!
    " We use a timer to allow endwise to finish it's thing before saving
    autocmd InsertLeave * nested call timer_start(100, { -> execute("silent! update") })
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
      autocmd TermOpen * setlocal listchars= nonumber norelativenumber nowrap winfixwidth noruler signcolumn=no noshowmode scrolloff=0
      autocmd TermOpen * startinsert
      autocmd TermClose * set showmode ruler
      autocmd WinEnter term://* startinsert
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
  " QUICKFIX {{{
    augroup quickfix
      autocmd!
      " Delete item from Quickfix
      autocmd BufWinEnter quickfix nnoremap <buffer> <silent> dd
            \ <Cmd>call setqflist(filter(getqflist(), {idx -> idx != line('.') - 1}), 'r') <Bar> cc<CR>

      " Resize QF buffer on open
      autocmd BufWinEnter quickfix execute('resize ' . min([10, len(getqflist())]))
      autocmd BufWinEnter quickfix lua require("galaxyline").disable_galaxyline()
      autocmd BufWinEnter quickfix setl nobuflisted noshowmode noruler laststatus=0 noshowcmd
    augroup END
  " }}}
  " REMOVE TRAILING WHITESPACE && EMPTY LINES ON SAVE {{{
    " augroup stripWhitespaceOnSave
      " autocmd!
      " autocmd BufWritePre * :call TrimWhitespace()
      " autocmd BufWritePre * :call TrimEndLines()
    " augroup END
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

    if !exists('g:terminal_drawer')
      let g:terminal_drawer = { 'win_id': v:null, 'buffer_id': v:null, 'terminal_job_id': v:null, 'state': 'closed' }
    endif

    function! ToggleTerminalDrawer() abort
      if win_gotoid(g:terminal_drawer.win_id)
        call CloseTerminalDrawer()
      else
        call OpenTerminalDrawer()
      endif
    endfunction

    function! CloseTerminalDrawer() abort
      if g:terminal_drawer.state == 'closed'
        " Don't closed terminal if already closed
        return
      endif

      hide
      set laststatus=2 showmode ruler
      let g:terminal_drawer.state = 'closed'
      stopinsert
    endfunction

    function! SmartCloseTerminal() abort
      if win_gotoid(g:terminal_drawer.win_id)
        call CloseTerminalDrawer()
      endif
    endfunction

    function! OpenTerminalDrawer() abort
      if g:terminal_drawer.state == 'open'
        " Don't open terminal if already open
        return
      endif

      exec g:terminal_drawer_position . " new"
      if !g:terminal_drawer.buffer_id
        call termopen($SHELL, {"detach": 0})
        let g:terminal_drawer.buffer_id = bufnr("")
      else
        exec 'buffer' g:terminal_drawer.buffer_id
        call RemoveEmptyBuffers()
      endif

      exec 'resize' float2nr(&lines * g:terminal_drawer_height)
      setlocal ft=terminal
      setlocal laststatus=0 noshowmode noruler
      setlocal nobuflisted modifiable

      echo ''
      startinsert!
      let g:terminal_drawer.win_id = win_getid()
      let g:terminal_drawer.terminal_job_id = b:terminal_job_id
      let g:terminal_drawer.state = 'open'

      tnoremap <buffer><Esc> <C-\><C-n>
      nnoremap <buffer><cr> i
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

      call nvim_open_win(nvim_create_buf(v:false, v:true), v:true, opts)
      call InvertBackground()
      autocmd BufWipeout <buffer> call ResetBackground()
    endfunction
  " }}}
  " CHECK BACK SPACE {{{
    " Used for Autocompletion <TAB>
    function! s:check_back_space() abort
      let col = col('.') - 1
      return !col || getline('.')[col - 1]  =~ '\s'
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
      hi ActiveWindow   guibg=#282C34
      hi InactiveWindow guibg=NONE
      set winhighlight=Normal:ActiveWindow,NormalNC:InactiveWindow
    endfunction

    function! ResetBackground()
      hi ActiveWindow   guibg=NONE
      hi InactiveWindow guibg=#282C34
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
    " complete_info()["selected"] is -1 when nothing is selected
    imap <silent><expr> <CR>
      \ (pumvisible() ?
        \ (complete_info()["selected"] == -1 ? "\<C-g>u\<CR>\<Plug>DiscretionaryEnd" : "\<C-y>")
        \ : "\<CR>\<Plug>DiscretionaryEnd" )
  "}}}
  " REMOVE TRAILING WHITESPACE {{{
    function! TrimWhitespace()
      let l:save = winsaveview()
      keeppatterns %s/\s\+$//e
      call winrestview(l:save)
    endfunction
  " }}}
  " REMOVE EMPTY LINES AT EOF {{{
    function! TrimEndLines()
      let save_cursor = getpos(".")
      silent! %s#\($\n\s*\)\+\%$##
      call setpos('.', save_cursor)
    endfunction
  " }}}
  " QUICKFIX WRAPAROUND {{{
    " from https://github.com/romainl/vim-qf/blob/master/autoload/qf/wrap.vim
    function! QfWrapCommand(direction, prefix)
        if a:direction == "up"
            try
                execute a:prefix . "previous"
            catch /^Vim\%((\a\+)\)\=:E553/
                execute a:prefix . "last"
            catch /^Vim\%((\a\+)\)\=:E\%(325\|776\|42\):/
            endtry
        else
            try
                execute a:prefix . "next"
            catch /^Vim\%((\a\+)\)\=:E553/
                execute a:prefix . "first"
            catch /^Vim\%((\a\+)\)\=:E\%(325\|776\|42\):/
            endtry
        endif

        if &foldopen =~ 'quickfix' && foldclosed(line('.')) != -1
            normal! zv
        endif
      endfunction
  " }}}
  " SMART INSERT {{{
    " Smart-indent line if it's empty
    function! SmartInsert()
      if len(getline('.')) == 0
        return "\"_cc"
      else
        return "i"
      endif
    endfunction
  " }}}
" }}}
" Commands {{{
  command! Format call FormatFile()

  function! FormatFile() abort
    call TrimEndLines()
    call TrimWhitespace()
    execute 'lua formatting()'
  endfunction

  " Opens decrypted rails credentials - uses https://gist.github.com/rf-/33fc88d3071f4254b80e
  command! -nargs=0 -bang Ecredendtials call EcredentialsRails()

  function! EcredentialsRails() abort
    if g:terminal_drawer.terminal_job_id == v:null
      echom "No Terminal Available"
      return
    endif

    call jobsend(g:terminal_drawer.terminal_job_id, "rails credentials:edit\n")
  endfunction
" }}}
" Key Mappings {{{
  let mapleader = "\\"

  nnoremap <leader>vi :e $MYVIMRC<cr>
  nnoremap <leader>pu :PlugUpdate<cr>
  nnoremap <leader>h  :Helptags<cr>
  nnoremap <leader>bb obinding.pry<esc>:w<cr>^
  nnoremap <leader>gx :GBranches<cr>

  " ERB Stuff
  inoremap <leader>5 <%  %><left><left><left>
  inoremap <leader>% <%=  %><left><left><left>
  inoremap <leader>e <% end %>

  inoremap <silent><esc> <esc>:update<cr>:Format<cr>


  " Fast Find and Replace
  nnoremap R :%s/\<<C-r><C-w>\>//g<Left><Left><C-r><C-w>

  " Code Action Menu
  nnoremap <silent><Leader>ca :lua vim.lsp.buf.code_action()<CR>
  vnoremap <silent><Leader>ca :lua vim.lsp.buf.code_action()<CR>

  " Open Last Buffer
  nnoremap <Leader><Leader> <C-^>

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

  " rebind 'i' to do a smart-indent if its a blank line
  nnoremap <expr> i SmartInsert()


  " " Change text without putting the text into register,
  " nnoremap c "_c
  " nnoremap C "_C
  " nnoremap cc "_cc

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

  noremap H g^
  noremap L g_

  " Close split using c-q, close pane keeping split with c-w
  noremap  <C-q> :call SmartCloseTerminal()<cr>:bw<Cr>
  noremap  <C-w> :BufferClose<Cr>
  noremap  <C-e> <C-w>c<Cr>

  nnoremap <silent><f7> :BufferPrevious<cr>
  nnoremap <silent><f9> :BufferNext<cr>

  " buffer splits
  nmap <silent><nowait><leader>sh  :leftabove  vnew<CR>:bprev<CR>:call RemoveEmptyBuffers()<CR>
  nmap <silent><nowait><leader>sl  :rightbelow vnew<CR>:bprev<CR>:call RemoveEmptyBuffers()<CR>
  nmap <silent><nowait><leader>sk  :leftabove  new<CR>:bprev<CR>:call RemoveEmptyBuffers()<CR>
  nmap <silent><nowait><leader>sj  :rightbelow new<CR>:bprev<CR>:call RemoveEmptyBuffers()<CR>

  " Enter inserts newline without leaving Normal mode
  nmap <s-cr> O<Esc>
  nmap <cr>   o<Esc>

  " Center Search Results
  nnoremap <silent> n nzz
  nnoremap <silent> N Nzz
  nnoremap <silent> * *zz
  nnoremap <silent> # #zz

  " use tab and shift tab to indent and outdent code
  nnoremap <Tab>   >>
  nnoremap <S-Tab> <<
  vnoremap <Tab>   >><Esc>gv
  vnoremap <S-Tab> <<<Esc>gv

  " jump list next (F20 is what c-i sends, thanks to Karabiner. This addresses collision with Tab)
  nnoremap <F20> <c-i>

  " " Quicker window movement
  tnoremap <C-h> <C-\><C-n><C-w>h
  tnoremap <C-j> <C-\><C-n><C-w>j
  tnoremap <C-k> <C-\><C-n><C-w>k
  tnoremap <C-l> <C-\><C-n><C-w>l

  " If you're in the terminal and start repeating 'j' or 'k', you're focused on the wrong window
  tmap jj <C-k>
  tmap kk <C-k>

  " Moves selected Lines up and Down with alt-j/k
  nnoremap <silent> ∆ :m .+1<CR>==
  nnoremap <silent> ˚ :m .-2<CR>==
  inoremap <silent> ∆ <Esc>:m .+1<CR>==gi
  inoremap <silent> ˚ <Esc>:m .-2<CR>==gi
  vnoremap <silent> ∆ :m '>+1<CR>gv=gv
  vnoremap <silent> ˚ :m '<-2<CR>gv=gv

  " Quickfix Navigation
  nnoremap <silent> <Up>    :<C-u> call QfWrapCommand('up', 'c')<CR>
  nnoremap <silent> <Down>  :<C-u> call QfWrapCommand('down', 'c')<CR>
  nnoremap <silent> <Left>  :cpfile<CR>
  nnoremap <silent> <Right> :cnfile<CR>

  " Location List Navigation
  nnoremap <silent> <S-Up>    :<C-u> call QfWrapCommand('up', 'l')<CR>
  nnoremap <silent> <S-Down>  :<C-u> call QfWrapCommand('down', 'l')<CR>
  nnoremap <silent> <S-Left>  :lpfile<CR>
  nnoremap <silent> <S-Right> :lnfile<CR>
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

      autocmd ColorScheme * call onedark#set_highlight("Constant",     { "fg": s:dark_yellow })
      autocmd ColorScheme * call onedark#set_highlight("keyword",      { "fg": s:purple      })
      autocmd ColorScheme * call onedark#set_highlight("number",       { "fg": s:red         })
      autocmd ColorScheme * call onedark#set_highlight("boolean",      { "fg": s:red         })
      autocmd ColorScheme * call onedark#set_highlight("label",        { "fg": s:red         })
      autocmd ColorScheme * call onedark#set_highlight("CursorLineNr", { "fg": s:yellow      })
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
  highlight ActiveWindow   guibg=NONE
  highlight InactiveWindow guibg=#282C34
  set winhighlight=Normal:ActiveWindow,NormalNC:InactiveWindow

  " Set Transparent Background
  highlight Normal guibg=NONE

  highlight IndentBlanklineEven guifg=#2E323A guibg=#34383F blend=90
  highlight IndentBlanklineOdd  guifg=#34383F guibg=#2E323A blend=90

  highlight DiffAdd    guifg=#98c379 guibg=NONE gui=NONE
  highlight DiffChange guifg=#569CD6 guibg=NONE gui=NONE
  highlight DiffDelete guifg=#e06c75 guibg=NONE gui=NONE

  " LSP Virtual Text
  highlight LspDiagnosticsVirtualTextError       guifg=#E06C75 ctermfg=Red
  highlight LspDiagnosticsVirtualTextWarning     guifg=#ffe082 ctermfg=Yellow
  highlight LspDiagnosticsVirtualTextHint        guifg=#89DDF3 ctermfg=White
  highlight LspDiagnosticsVirtualTextInformation guifg=#89DDF3 ctermfg=White

  " Underline the offending code
  highlight LspDiagnosticsUnderlineError       guifg=NONE ctermfg=NONE cterm=underline gui=bold
  highlight LspDiagnosticsUnderlineWarning     guifg=NONE ctermfg=NONE cterm=underline gui=bold
  highlight LspDiagnosticsUnderlineHint        guifg=NONE ctermfg=NONE cterm=underline gui=bold
  highlight LspDiagnosticsUnderlineInformation guifg=NONE ctermfg=NONE cterm=underline gui=bold

  " LSP Sign Column
  highlight LspDiagnosticsSignInformation guifg=#82AAFF
  highlight LspDiagnosticsSignWarning     guifg=#FFCB6B

  " BarBar
  highlight BufferTabpageFill   guibg=#22252A guifg=#3E4551

  highlight BufferCurrent       guibg=none guifg=#98c379 gui=bold
  highlight BufferCurrentMod    guibg=none guifg=#E06C75 gui=bold
  highlight BufferCurrentSign   guibg=none guifg=#82AAFF
  highlight BufferCurrentTarget guibg=none gui=bold
  highlight BufferCurrentIcon   guibg=none
  highlight BufferCurrentIndex  guibg=none

  highlight BufferVisible       guibg=#282C34 guifg=#90AB7B
  highlight BufferVisibleMod    guibg=#282C34 guifg=#E06C75
  highlight BufferVisibleSign   guibg=#282C34 guifg=#23282C
  highlight BufferVisibleTarget guibg=#282C34 gui=BOLD
  highlight BufferVisibleIcon   guibg=#282C34
  highlight BufferVisibleIndex  guibg=#282C34

  highlight BufferInactive       guibg=#22252A guifg=#7a7c7e gui=italic
  highlight BufferInactiveIcon   guibg=#22252A
  highlight BufferInactiveIndex  guibg=#22252A
  highlight BufferInactiveMod    guibg=#22252A guifg=#E06C75 gui=italic
  highlight BufferInactiveSign   guibg=#22252A guifg=#4a4c4e
  highlight BufferInactiveTarget guibg=#22252A

  " Code Biscuit
  highlight BiscuitColor guifg=#858585
" }}}
" SETUP {{{
  " Launch a terminal and close it when you open nvim
  call OpenTerminalDrawer()
  call CloseTerminalDrawer()
" }}}
