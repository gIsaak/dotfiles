-- Lsp mappings
-- global mappings
local opts = { noremap=true, silent=true, buffer=true}
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)
-- per-buffer mappings
local bopts = { noremap=true, silent=true, buffer=0}
local on_attach = function()
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, bopts)
    vim.keymap.set('n', '<space>k', vim.lsp.buf.signature_help, bopts)
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bopts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bopts)
    vim.keymap.set('n', 'gt', vim.lsp.buf.type_definition, bopts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bopts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, bopts)
    vim.keymap.set('n', '<space>r', vim.lsp.buf.rename, bopts)
    vim.keymap.set('n', '<space>a', vim.lsp.buf.code_action, bopts)
end
 -- Setup lspconfig.
local lspconfig = require('lspconfig')
-- nvim-cmp integration
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
local servers = {
  pylsp = true,
  texlab = true,
  ccls = true,
  sumneko_lua = {
    settings = {
      Lua = {
        diagnostics = {
          globals = {'vim'},
        },
        workspace = {
          library = vim.api.nvim_get_runtime_file("", true),
        },
      },
    },
  },
}

local setup_server = function(server, config)
  if not config then
    return
  end
  if type(config) ~= "table" then
    config = {}
  end
  config = vim.tbl_deep_extend("force", {
    capabilities = capabilities,
    on_attach = on_attach,
  }, config)
  lspconfig[server].setup(config)
end

for server, config in pairs(servers) do
  setup_server(server, config)
end

