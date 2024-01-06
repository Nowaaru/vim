vim.lsp.set_log_level("debug") 

return {
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "csharp-language-server",
        "typescript-language-server",
        "vim-language-server",
        "yaml-language-server",
        "json-lsp",
        "neocmakelsp",
        "nil",

        "dprint",
        "yamllint",
        "cpplint",
      }
    }
  }
}
