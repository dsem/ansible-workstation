-- lua/plugins/lsp.lua
--
-- A complete, modern LSP configuration for Neovim.
-- This module configures mason, mason-lspconfig, and nvim-lspconfig.
--
-- Happy Friday from Charlottesville! - September 5, 2025

local M = {}

function M.setup()
  -- This is a list of servers that mason-lspconfig will automatically install
  -- and setup for you. Add or remove servers as you see fit.
  -- To find a server name, run `:Mason` and press `i` on a package.
  local servers = {
    -- Web Development
    "html",
    "cssls",
    "tailwindcss",
    -- "ts-standard", -- For TypeScript & JavaScript

    -- Python
    "pyright",

    -- Lua
    "lua_ls",

    -- Shell
    "bashls",

    -- Config Files / DevOps
    "yamlls",
    "jsonls",
    "dockerls",
    "terraformls",
    "helm_ls",
    "taplo", -- For TOML files like pyproject.toml

    -- Vimscript
    "vimls",
  }

  -- The `on_attach` function runs whenever an LSP server attaches to a buffer.
  -- This is where you should define all your LSP-related keymaps.
  local on_attach = function(client, bufnr)
    -- Enable completion triggered by characters (useful for autocompletion)
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    local opts = { noremap = true, silent = true, buffer = bufnr }

    -- See `:help vim.lsp.*` for documentation on any of the below functions
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
    vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
    vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set("n", "<leader>wl", function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts)
    vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, opts)
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
    vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, opts)
  end

  -- This is a crucial step that tells nvim-lspconfig about the capabilities
  -- of your completion engine (nvim-cmp).
  local capabilities = require('cmp_nvim_lsp').default_capabilities()

  -- Configure mason.nvim to handle LSP server installation
  require("mason").setup()

  -- Configure mason-lspconfig.nvim to bridge mason and lspconfig
  local lspconfig = require("lspconfig")
  require("mason-lspconfig").setup({
    ensure_installed = servers,
    handlers = {
      -- The default handler. It will be called for each server that doesn't have a
      -- specific handler defined below. This is where we pass our `on_attach`
      -- and `capabilities` to every server.
      function(server_name)
        lspconfig[server_name].setup({
          on_attach = on_attach,
          capabilities = capabilities,
        })
      end,

      -- You can define custom handlers for specific servers.
      -- For example, we can pass special settings to lua_ls to recognize "vim".
      ["lua_ls"] = function()
        lspconfig.lua_ls.setup({
          on_attach = on_attach,
          capabilities = capabilities,
          settings = {
            Lua = {
              diagnostics = {
                globals = { 'vim' }, -- Tell lua_ls that `vim` is a global
              },
            },
          },
        })
      end,
    }
  })
end

return M
