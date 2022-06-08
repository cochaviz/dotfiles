try
    lua require('plugins')
catch
    PackerInstall
endtry

lua require('neoscroll').setup()
lua require('telescope').setup()
lua require('nvim-tree').setup()
lua require('lsp')

lua require'flutter-tools'.setup {}

lua <<EOF
require'nvim-treesitter.configs'.setup {
  rainbow = {
    enable = true,
    extended_mode = true, -- Highlight also non-parentheses delimiters, boolean or table: lang -> boolean
    max_file_lines = 1000, -- Do not enable for files with more than 1000 lines, int
  },
  autotag = {
    enable = true;
  },
}
EOF

""" abbreviations
cabbr <expr> %% expand('%:p:h')
command E e %%/


""" keybindings
imap jk <Esc>
nmap <C-j> 10j
nmap <C-k> 10k

map <Leader>e :NvimTreeToggle <CR>
map <Leader>bt :TexlabBuild <CR>

map <leader>q <cmd>call BufferCloseIfLast() <CR>

function BufferCloseIfLast()
	if len(getbufinfo({'buflisted':1})) - 1
		call feedkeys(":BufferClose\<CR>")
	else
		call feedkeys(":q\<CR>")
	endif
endfunction

" Use <Tab> and <S-Tab> to navigate through popup menu
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Telescope
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

" Minimap
nnoremap <leader>ms <cmd>Minimap<cr>
nnoremap <leader>mr <cmd>MinimapRefresh<cr>
nnoremap <leader>mc <cmd>MinimapClose<cr>
nnoremap <leader>mt <cmd>MinimapToggle<cr>

" BarBar
nmap <leader>g <cmd>BufferPick<cr>
nmap <Tab> <cmd>BufferNext<cr>
nmap <S-Tab> <cmd>BufferPrevious<cr>

" Color-matched brackets
let g:rainbow_active = 1

" Auto-update packages when writing to plugins.lua
autocmd BufWritePost plugins.lua PackerSync

" Auto-format on saving
augroup fmt
  autocmd!
  autocmd BufWritePre * try | undojoin | Neoformat | catch /^Vim\%((\a\+)\)\=:E790/ | finally | silent Neoformat | endtry
augroup END

" Markdown Preview
let g:mkdp_auto_start = 1
let g:mkdp_auto_close = 1
let g:mkdp_browser = 'firefox'
let g:mkdp_browserfunc = 'OpenMarkDownPreview'

function OpenMarkDownPreview(url)
	call system('xdotool search --name "「README」" | grep -oP "\d+" || firefox --new-window ' . a:url)
endfunction

"""Treesitter
lua <<EOF
require'nvim-treesitter.configs'.setup {
	ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
	indent = {
		enable = true,
	},
	highlight = {
		enable = true,
	},
	incremental_selection = {
		enable = true,
		keymaps = {
			init_selection = "gnn",
			node_incremental = "grn",
			scope_incremental = "grc",
			node_decremental = "grm",
		},
	},
}
EOF

""" Beautifying
set nu rnu
set termguicolors
let g:indentLine_char = '⎸'

" Minimap
let g:minimap_width = 10
let g:minimap_auto_start = 0
let g:minimap_auto_start_win_enter = 0

lua << EOF
vim.g.onedark_override = {
      black = "#1c1c1c",
}
EOF

" Colorscheme
" colorscheme onedark
colorscheme xresources

" Settings for file-types
autocmd BufRead,BufNewFile *.c,*.cpp,*.h,*.hpp
      \ set shiftwidth=2
autocmd BufRead,BufNewFile *.lua
      \ set shiftwidth=2

""" Other
set clipboard+=unnamedplus
set autowriteall
set tabstop=8 softtabstop=0 expandtab shiftwidth=4 smarttab

""" Set auto line-break in certain files
autocmd BufRead,BufNewFile	*.md,*.txt set tw=100

""" completion-nvim
" Use <Tab> and <S-Tab> to navigate through popup menu
" inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
" inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
" 
" " Set completeopt to have a better completion experience
" set completeopt=menuone,noinsert,noselect
" 
" " Avoid showing message extra message when using completion
" set shortmess+=c
" 
" " Use completion-nvim in every buffer
" autocmd BufEnter * lua require'completion'.on_attach()
" 
" " snippet source
" let g:completion_enable_snippet = 'Ultisnips'
" 
" " Completion sources config
" let g:completion_chain_complete_list = {
"     \ 'markdown': [
"     \    {'complete_items': ['ts', 'lsp', 'snippet', 'buffers']},
"     \    {'mode': '<c-p>'},
"     \    {'mode': '<c-n>'},
"     \],
"     \ 'text': [
"     \    {'complete_items': ['ts', 'lsp', 'snippet', 'buffers']},
"     \    {'mode': '<c-p>'},
"     \    {'mode': '<c-n>'},
"     \],
"     \'default': {
"     \     'default': [
"     \         {'complete_items': ['ts', 'lsp']},
"     \         {'mode': '<c-p>'},
"     \         {'mode': '<c-n>'},
"     \     ],
"     \     'string': [
"     \         {'complete_items': ['path']},
"     \      ],
"     \     'comment': []
"     \}
" \}
" 
"""SUPER COOL TERMINAL THINGY

" Terminal Function
let g:term_buf = 0
let g:term_win = 0
function! TermToggle(height)
    if win_gotoid(g:term_win)
        hide
    else
        botright new
        exec "resize " . a:height
        try
            exec "buffer " . g:term_buf
        catch
            call termopen($SHELL, {"detach": 0})
            let g:term_buf = bufnr("")
            set nonumber
            set norelativenumber
            set signcolumn=no
        endtry
        startinsert!
        let g:term_win = win_getid()
    endif
endfunction

" Toggle terminal on/off (neovim)
if !exists('g:vscode')
    nnoremap <leader>t :call TermToggle(12)<CR>
else
    nmap <leader>t VSCodeCall('workbench.action.terminal.toggleTerminal')
endif

" Terminal go back to normal mode
tnoremap <leader>t <C-\><C-n>:q!<CR>

" Intellij-Specific
set visualbell
set noerrorbells
"set ideajoin
