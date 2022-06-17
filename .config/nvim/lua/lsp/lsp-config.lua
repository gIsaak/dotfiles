local api = vim.api
-- LSP global mappings
local opts = { noremap=true, silent=true, buffer=true }
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)
-- per-buffer mappings
local bopts = { noremap=true, silent=true, buffer=0}
local on_attach = function()
  vim.keymap.set('n', 'K',          vim.lsp.buf.hover, bopts)
  vim.keymap.set('n', '<leader>sh', vim.lsp.buf.signature_help, bopts)
  vim.keymap.set('n', 'gD',         vim.lsp.buf.declaration, bopts)
  vim.keymap.set('n', 'gd',         vim.lsp.buf.definition, bopts)
  vim.keymap.set('n', 'gt',         vim.lsp.buf.type_definition, bopts)
  vim.keymap.set('n', 'gi',         vim.lsp.buf.implementation, bopts)
  vim.keymap.set('n', 'gr',         vim.lsp.buf.references, bopts)
  vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, bopts)
  vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, bopts)
  vim.keymap.set('n', '<leader>cl', vim.lsp.codelens.run, bopts)
  vim.keymap.set('n', '<leader>o',  vim.lsp.buf.formatting, bopts)
end
-- Setup lspconfig.
local lspconfig = require('lspconfig')
-- nvim-cmp integration
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
local servers = {
  pylsp = true,
  texlab = true,
  ccls = true,
  bashls = true,
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


-- Metals specific setup
vim.opt_global.shortmess:remove("F"):append("c")
local metals_config = require('metals').bare_config()

metals_config.settings = {
  showImplicitArguments = true,
  showImplicitConversionsAndClasses = true,
  showInferredType = true,
}

metals_config.init_options.statusBarProvider = "on"
metals_config.capabilities = capabilities

local lsp_group = api.nvim_create_augroup("lsp", { clear = true })

-- Metals specific mappings
metals_config.on_attach = function(_, bufnr)
  on_attach()
  vim.keymap.set('v', 'K', function() return require('metals').type_of_range() end)
  vim.keymap.set('n', '<leader>ws', function() return require('metals').hover_worksheet() end)
  vim.keymap.set('n', '<leader>tt', function() return require('metals.tvp').toggle_tree_view() end)
  vim.keymap.set('n', '<leader>tr', function() return require('metals.tvp').reveal_in_tree() end)
  vim.keymap.set('n', '<leader>st', function() return require('metals').toggle_setting('showImplicitArguments')() end)
  vim.keymap.set('n', '<leader>T',
    function()
      local testSub = { ".scala", "Spec.scala", "Test.scala" }
      local testName = vim.fn.expand('%:p'):gsub("main","test",1)
      for _, v in pairs(testSub) do
        local testPath = testName:gsub(".scala$", v, 1)
        if (vim.fn.filereadable(testPath) == 1) then
          return vim.api.nvim_command('edit ' .. testPath);
        end
      end
      return print("No scala tests found");
    end) -- go to test if present

  -- Use Metals document_highlight and codelens when serverso do not support them
  api.nvim_create_autocmd("CursorHold", {
    callback = vim.lsp.buf.document_highlight,
    buffer = bufnr,
    group = lsp_group,
  })
  api.nvim_create_autocmd("CursorMoved", {
    callback = vim.lsp.buf.clear_references,
    buffer = bufnr,
    group = lsp_group,
  })
  api.nvim_create_autocmd({ "BufEnter", "CursorHold", "InsertLeave" }, {
    callback = vim.lsp.codelens.refresh,
    buffer = bufnr,
    group = lsp_group,
  })
end

local nvim_metals_group = api.nvim_create_augroup("nvim-metals", { clear = true })
api.nvim_create_autocmd("FileType", {
  pattern = { "scala", "sbt", "java" },
  callback = function()
    require("metals").initialize_or_attach(metals_config)
  end,
  group = nvim_metals_group,
})

-- UI
-- round borders
vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, {
  border = 'rounded',
})

vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, {
  border = 'rounded',
})

-- diagnostic signs
local signs = {
  Error = '' .. ' ',
  Warn = '' .. ' ',
  Hint = '' .. ' ',
  Info = '' .. ' ',
}

for type, icon in pairs(signs) do
  local hl = 'DiagnosticSign' .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = '' })
end

