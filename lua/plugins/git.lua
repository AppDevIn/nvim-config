return {
  {
    "lewis6991/gitsigns.nvim",
    opts = {
      signs = {
        add = { text = "│" },
        change = { text = "│" },
        delete = { text = "_" },
        topdelete = { text = "‾" },
        changedelete = { text = "~" },
      },
      on_attach = function(bufnr)
        local gs = require("gitsigns")
        local map = function(mode, l, r, desc)
          vim.keymap.set(mode, l, r, { buffer = bufnr, desc = desc })
        end

        map("n", "]h", gs.next_hunk, "Next hunk")
        map("n", "[h", gs.prev_hunk, "Previous hunk")
        map("n", "<leader>gp", gs.preview_hunk, "Preview hunk")
        map("n", "<leader>gs", gs.stage_hunk, "Stage hunk")
        map("n", "<leader>gr", gs.reset_hunk, "Reset hunk")
        map("n", "<leader>gu", gs.undo_stage_hunk, "Undo stage hunk")
        map("n", "<leader>gb", gs.blame_line, "Blame line")
      end,
    },
  },
  {
    "tpope/vim-fugitive",
    keys = {
      { "<leader>gg", "<cmd>Git<cr>", desc = "Git status" },
      { "<leader>gd", "<cmd>Gdiffsplit<cr>", desc = "Git diff split" },
      { "<leader>gh", "<cmd>0Gclog<cr>", desc = "File history" },
      { "<leader>gc", "<cmd>Git commit<cr>", desc = "Git commit" },
      { "<leader>gP", "<cmd>Git push<cr>", desc = "Git push" },
      { "<leader>gl", "<cmd>Git pull<cr>", desc = "Git pull" },
    },
  },
}
