--nvim Package Manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  "lervag/vimtex",
  "neovim/nvim-lspconfig",
  "vigoux/ltex-ls.nvim",
  "PatrBal/vim-textidote",
  "hrsh7th/cmp-nvim-lsp",
  "hrsh7th/nvim-cmp",
  "hrsh7th/cmp-buffer",
  "micangl/cmp-vimtex",
  "sirver/ultisnips",
  "honza/vim-snippets",
  "pocco81/auto-save.nvim",
  "ryanoasis/vim-devicons",
  "nvim-telescope/telescope.nvim",
  "nvim-telescope/telescope-file-browser.nvim",
  "fhill2/telescope-ultisnips.nvim",
  "sharkdp/fd",
  "nvim-lua/plenary.nvim",
  "BurntSushi/ripgrep",
  "nvim-treesitter/nvim-treesitter",
  "jiangmiao/auto-pairs",
  "folke/tokyonight.nvim",
  "catppuccin/nvim",
  "startup-nvim/startup.nvim",
  "neovim/nvim-lspconfig",
  "williamboman/nvim-lsp-installer",
  "mhinz/vim-startify",
  "mhinz/vim-janah",
  "akinsho/bufferline.nvim",
  "junegunn/goyo.vim",
  "dpelle/vim-grammalecte",
  "vim-airline/vim-airline",
  "vim-airline/vim-airline-themes",
  "preservim/nerdtree"
})

--Revenir au document là où on l'a quitté
vim.api.nvim_create_autocmd("BufReadPost", {
    callback = function()
        local last_pos = vim.fn.line("'\"")
        if last_pos > 1 and last_pos <= vim.fn.line("$") then
            vim.cmd("normal! g'\"")
        end
    end,
})

-- Key mapping using the modern API
vim.keymap.set('n', '<Leader>n', function()
    if vim.wo.number then
        vim.wo.number = false      -- Disable absolute line numbers
        vim.wo.relativenumber = false -- Disable relative line numbers
    else
        vim.wo.number = true       -- Enable absolute line numbers
        vim.wo.relativenumber = true  -- Enable relative line numbers
    end
end, { noremap = true, silent = true })


-- Key mapping for toggling line numbers
vim.api.nvim_set_keymap('n', '<Leader>n', ':lua toggle_line_numbers()<CR>', { noremap = true, silent = true })

--Toggle numbers & spell
vim.keymap.set('n', '<leader>s', ':set spell!<cr>')
vim.keymap.set('n', '<leader>f', ':NERDTreeToggle <CR>')
vim.keymap.set('n', '<leader>b', ':Bookmark<CR>')

--scrolloff pour supprimer l'écran qui saute en changeant de mode
vim.o.scrolloff = 5  

--Set spell
vim.opt.spelllang = 'fr'
vim.opt.spell = true

--autocomplete $
vim.api.nvim_set_keymap('i', '$', '$$<Left>', { noremap = true, silent = true })  

--Set number
vim.opt.number = false

--NERDTree open right
vim.g.NERDTreeWinPos = "right"

--Telescope
require("telescope").load_extension "file_browser"
require('telescope').load_extension "ultisnips"
-- require'telescope.builtin'.grep_string{ shorten_path = true, word_match = "-w", only_sort_text = true, search = '' }
vim.keymap.set("n", "<leader>fb", ":Telescope file_browser<CR>")
vim.keymap.set("n", "<leader>fB", ":Telescope buffers<CR>")
vim.keymap.set("n", "<leader>ff", ":Telescope find_files<CR>")
vim.keymap.set("n", "<leader>fg", ":Telescope live_grep<CR>")
vim.keymap.set("n", "<leader>fi", ":Telescope ultisnips<CR>")

-- Configuration de vim-startify
vim.g.startify_lists = {
    { type = 'files', header = {'   Recent Files'} },
    { type = 'dir', header = {'   Current Directory'} },
    { type = 'sessions', header = {'   Sessions'} },
}

--Afficher les bookmarks au démarrage.
vim.g.NERDtreeShowBookmarks = 1

--NERDTree Ignore
vim.g.NERDTreeIgnore = { '\\.aux$', '\\.log$', '\\.toc$', '\\.lof$', '\\.lot$', '\\.idx$', '\\.ilg$', '\\.ind$', '\\.out$', '\\.bbl$', '\\ERROR$', '\\.bcf$', '\\.blg$', '\\.fls$', '\\.xml$', '\\.ptc$', '\\.fdb_latexmk$', '\\.synctex(busy)$', '\\.synctex.gz$'}

-- Ouvrir NERDTree au démarrage et remettre le curseur dans la fenêtre principale  
vim.api.nvim_create_autocmd("VimEnter", {  
    callback = function()  
        -- Vérifier si Neovim a été lancé sans fichier ou argument  
        if vim.fn.argc() == 0 then  
            vim.cmd("NERDTree") -- Lancer NERDTree  
            vim.cmd("wincmd p") -- Revenir à la fenêtre principale  
        end  
    end  
})  

-- Fermer Neovim si NERDTree est la dernière fenêtre restante  
vim.api.nvim_create_autocmd("BufEnter", {  
    callback = function()  
        -- Vérifier s'il ne reste qu'une fenêtre ouverte et que c'est NERDTree  
        if vim.fn.winnr('$') == 1 and vim.fn.exists("t:NERDTreeBufName") ~= 0 then  
            vim.cmd("quit") -- Fermer Neovim  
        end  
    end  
})

--
--Switch between buffers
vim.keymap.set('n', '<A-k>', '<C-w><Right>', { noremap = true, silent = true })
vim.keymap.set('n', '<A-j>', '<C-w><Left>', { noremap = true, silent = true })
vim.keymap.set('i', '<C-s>', '<Esc>:w<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<C-s>', '<Esc>:w<CR>', { noremap = true, silent = true })
--vim.keymap.set('n', '<C-A-k>', '<C-w><Up>', { noremap = true, silent = true })

--Switch between tabs
vim.keymap.set("n", "<C-k>", ":tabn<CR>")
vim.keymap.set("n", "<C-j>", ":tabp<CR>")

--colorscheme
vim.cmd[[colorscheme catppuccin-frappe]]

require('catppuccin').setup({
    flavour = "frappe", -- ou "macchiato" "latte", "frappe", "mocha"
})

--Theme color tokyonight
--colorscheme tokyonight-night
--colorscheme tokyonight-storm
--colorscheme tokyonight-day
--colorscheme tokyonight-moon

--Correction du dernier mot (Gilles Castel) --Raccourci <C-l> en Insert
vim.api.nvim_set_keymap('i', '<C-l>', '<C-g>u<Esc>[s1z=`]a<C-g>u', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '<C-g>', '<C-g>u<Esc>[s1zg`]a<C-g>u', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-n>', ']s', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-g>', ']szg', { noremap = true, silent = true })
--vim.api.nvim_set_keymap('i', '<C-b>', '<Esc>]s', { noremap = true, silent = true })


-- vimtex
vim.g.vimtex_view_method = "zathura"
vim.g.maplocalleader = " "
vim.g.vimtex_quickfix_mode = 2
vim.g.vimtex_quickfix_ignore_filters = { "Marginpar on page", "Overfull", "Underfull" }
vim.g.vimtex_quickfix_autoclose_after_keystrokes = 1
vim.g.vimtex_quickfix_open_on_warning = 0
vim.opt.conceallevel = 1
vim.g.tex_conceal = 'abdmg'
--vim.g.vimtex_log_ignore
vim.o.foldmethod = "expr"
vim.o.foldexpr="vimtex#fold#level(v:lnum)"
vim.o.foldtext="vimtex#fold#text()"
vim.o.foldlevel=2

--Textidote
vim.g.textidote_jar = "/home/nabu/.config/nvim/textidote.jar"
vim.g.textidote_lang = "fr"
vim.g.textidote_win_height = "10"
vim.g.textidote_dictionary = "/home/nabu/.config/nvim/spell/fr.utf-8.add"
vim.g.textidote_ignore_rules = "sh:nobreak,sh:figref,sh:d:005,"
--vim.g.textidote_ignore_environments = "equation,tcolorbox"

--vim.g.vimtex_grammar_textidote = {
--             jar = '/home/nabu/.config/nvim/textidote.jar',
--             args = '--check fr',
--            }

            -- Configuration de UltiSnips
vim.g.UltiSnipsExpandTrigger = '<S-Tab>'  -- Touche pour étendre un snippet
vim.g.UltiSnipsJumpForwardTrigger = '<Tab>'  -- Touche pour aller au champ suivant
vim.g.UltiSnipsJumpBackwardTrigger = '<S-Tab>' -- Touche pour aller au champ précédent

-- Mappage pour UltiSnips
vim.api.nvim_set_keymap('i', '<S-Tab>', 'pumvisible() ? "<C-n>" : "<C-r>=UltiSnips#ExpandSnippetOrJump()<CR>"', { expr = true, noremap = true })
vim.api.nvim_set_keymap('i', '<A-Tab>', 'pumvisible() ? "<C-p>" : "<C-r>=UltiSnips#JumpBackward()<CR>"', { expr = true, noremap = true })

vim.g.UltiSnipsEditSplit="vertical"

-- Minimal lsp config
local lspconfig = require("lspconfig")
lspconfig.texlab.setup {}
require('lspconfig').ltex.setup({  
  settings = {  
    ltex = {  
      diagnosticSeverity = "none", -- Remplacez "none" par "error", "warning", etc., selon vos besoins.  
      disabledRules = {  
        en = {"APOS_TYP", "FRENCH_WHITESPACE" }, -- Désactiver les diagnostics liés aux labels inutilisés.  
      motherTongue = "fr", -- Définit la langue de base  
     },   
    },  
  },  
})
--require 'ltex-ls'.setup {
--  on_attach = on_attach,
--  capabilities = capabilities,
--  use_spellfile = false,
--  filetypes = { "latex", "tex", "bib", "markdown", "gitcommit", "text" },
--  settings = {
--    ltex = {
--      enabled = { "latex", "tex", "bib", "markdown", },
--      language = "auto",
--      diagnosticSeverity = "information",
--      sentenceCacheSize = 2000,
--      additionalRules = {
--        enablePickyRules = true,
--        motherTongue = "fr",
--      },
--      disabledRules = {
--        fr = { "APOS_TYP", "FRENCH_WHITESPACE" }
--      },
--      dictionary = (function()
--        -- For dictionary, search for files in the runtime to have
--        -- and include them as externals the format for them is
--        -- dict/{LANG}.txt
--        --
--        -- Also add dict/default.txt to all of them
--        local files = {}
--        for _, file in ipairs(vim.api.nvim_get_runtime_file("dict/*", true)) do
--          local lang = vim.fn.fnamemodify(file, ":t:r")
--          local fullpath = vim.fs.normalize(file, ":p")
--          files[lang] = { ":" .. fullpath }
--        end
--
--        if files.default then
--          for lang, _ in pairs(files) do
--            if lang ~= "default" then
--              vim.list_extend(files[lang], files.default)
--            end
--          end
--          files.default = nil
--        end
--        return files
--      end)(),
--    },
--  },
--}
vim.diagnostic.config({  
    virtual_text = false, -- Empêche l'affichage des annotations dans le texte lui-même.  
    signs =  false,        -- Désactive les signes dans les marges.  
    underline = false,    -- Désactive la mise en évidence des diagnostics dans le texte.  
}) 


-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspConfig", {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = ev.buf }
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "gR", vim.lsp.buf.rename, opts)
    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
  end,
})

vim.opt.textwidth = 80  -- Limite la largeur de texte à 80 caractères
vim.opt.wrap = true      -- Active le retour à la ligne automatique
vim.opt.linebreak = true -- Assure que le retour à la ligne se fait à des mots complets

-- nvim-cmp
local cmp = require("cmp")
cmp.setup({
  sources = cmp.config.sources({
    { name = "buffer" },
    { name = "nvim_lsp" },
  }),
  mapping = cmp.mapping.preset.insert({
    ["<Tab-CR>"] = cmp.mapping.complete(), -- Ouvre le menu de complétion manuellement
    ['<Tab>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }), -- Touche pour aller au champ suivan
    ['<C-Tab>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }), -- Touche pour aller au champ précédent
    ["<C-u>"] = cmp.mapping.scroll_docs(-4),
    ["<C-d>"] = cmp.mapping.scroll_docs(4),
    ["<Space>"] = cmp.mapping.confirm({ select = false}),
  }),
})

--Grammalecte
vim.g.grammalecte_cli_py = '/home/nabu/Documents/Grammalecte-fr-v2.1.1/grammalecte-cli.py'

--Changer pour la fenêtre Quickfix : C-w

-- Passer au buffer suivant
vim.api.nvim_set_keymap('n', '<leader>bn', ':bnext<CR>', { noremap = true, silent = true })

-- Passer au buffer précédent
vim.api.nvim_set_keymap('n', '<leader>bp', ':bprevious<CR>', { noremap = true, silent = true })

-- Passer à un buffer spécifique (par numéro)
vim.api.nvim_set_keymap('n', '<leader>b', ':b<Space>', { noremap = true, silent = true })
