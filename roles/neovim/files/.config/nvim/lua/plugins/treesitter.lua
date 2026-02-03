local M = {}

function M.setup()

  require('nvim-treesitter.configs').setup({
    ensure_installed = { "python", "lua", "vim", "javascript", "html", "css", "markdown", "markdown_inline", "yaml", "typescript", "terraform", "regex", "php", "nginx", "make", "json", "jq", "helm", "gitignore", "gitcommit", "git_rebase", "git_config", "dockerfile", "bash", "jinja", "jinja_inline" },
    highlight = { enable = true },
    indent = { enable = true },
    textobjects = {
      select = {
        enable = true,
        lookahead = true,
        keymaps = {
          ["af"] = "@function.outer",
          ["if"] = "@function.inner",
          ["ac"] = "@class.outer",
          ["ic"] = "@class.inner",
          ["a,"] = { query = "@parameter.outer", desc = "outside a parameter" },
          ["i,"] = { query = "@parameter.inner", desc = "inside a parameter" },
          ["al"] = { query = "@loop.outer", desc = "around a loop" },
          ["il"] = { query = "@loop.inner", desc = "inside a loop" },
          ["ai"] = { query = "@conditional.outer", desc = "around a conditional" },
          ["ii"] = { query = "@conditional.inner", desc = "inside a conditional" },
          ["a/"] = { query = "@comment.outer", desc = "around a comment" },
        },
      },
      move = {
        enable = true,
        set_jumps = true, -- whether to set jumps in the jumplist
        goto_next_start = {
          ["]f"] = "@function.outer",
          ["]c"] = "@class.outer",
          ["]p"] = "@parameter.inner",
        },
        goto_previous_start = {
          ["[f"] = "@function.outer",
          ["[c"] = "@class.outer",
          ["[p"] = "@parameter.inner",
        },
      },

      -- === 4. INCREMENTAL SELECTION ===
      -- A powerful feature to progressively select larger syntax nodes
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<CR>",      -- Key to start selection
          node_incremental = "<CR>",   -- Key to expand selection to the next node
          scope_incremental = "<S-CR>",-- Key to expand to the current scope (e.g. function)
          node_decremental = "<BS>",   -- Key to shrink selection
        },
      },
    },
  })
end

return M
