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
          ["a,"] = "@parameter.outer", -- These work for arguments, too
          ["i,"] = "@parameter.inner",
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
    },
  })
end

return M
