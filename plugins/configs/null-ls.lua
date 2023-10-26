-- prevent multiple auto-formatters running at once
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
local null_ls = require("null-ls")

-- prettier activates on save, eslint activates on write
-- eslint has a lot of delays and can be interrupted by prettier
-- generate .clang-format via:
--  ~/.local/share/nvim/mason/bin/clang-format --style LLVM --dump-config > .clang-format
local opts = {
  sources = {
    -- null_ls.builtins.diagnostics.eslint,
    -- null_ls.builtins.formatting.prettier,
    null_ls.builtins.formatting.clang_format,
  },
  on_attach = function(client, bufnr)
    if client.supports_method("textDocument/formatting") then
      -- clean auto-formatting
      vim.api.nvim_clear_autocmds({
        group = augroup,
        buffer = bufnr,
      })
      -- format on save
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = augroup,
        buffer = bufnr,
        -- command = "EslintFixAll",
        callback = function()
          vim.lsp.buf.format({ bufnr = bufnr })
        end
      })
    end
  end
}

return opts
