local M = {
  filetype = {
    javascript = {
      require("formatter.filetypes.javascript").prettier
    },
    typescript = {
      require("formatter.filetypes.typescript").prettier
    },
    ["*"] = {
      require("formatter.filetypes.any").remove_trailing_whitespace
    }
  }
}

-- format file using prettier on save
vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  command = "FormatWriteLock"
})

return M
