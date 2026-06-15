return {
  {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFileHistory" },
    keys = {
      { "<leader>gd", "<cmd>DiffviewOpen<cr>",          desc = "Diff View (working tree)" },
      { "<leader>gh", "<cmd>DiffviewFileHistory %<cr>", desc = "File Git History" },
      { "<leader>gH", "<cmd>DiffviewFileHistory<cr>",   desc = "Repo Git History" },
    },
    opts = {},
  },
}
