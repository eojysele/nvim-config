local P = {}

-- Set leader key to space
vim.g.mapleader = " "

-- key_mapping --
local key_map = function(mode, key, result)
    vim.keymap.set(mode, key, result)
end

--------------------------
-- General keys mapping --
--------------------------
-- Window management
-- Splits
key_map("n", "<leader>v", "<C-w>v") -- split window vertically
key_map("n", "<leader>h", "<C-w>s") -- split window horizontally
key_map("n", "<leader>s=", "<C-w>=") -- make split windows equal width & height
key_map("n", "<leader>sj", "<C-w>j") -- to lower split
key_map("n", "<leader>sk", "<C-w>k") -- to upper split
key_map("n", "<leader>sh", "<C-w>h") -- to left split
key_map("n", "<leader>sl", "<C-w>l") -- to right split
key_map("n", "<leader>sx", ":close<CR>") -- close current split window

-- Buffers
key_map("n", "<leader>bp", ":bprev<CR>") -- go to prev buffer
key_map("n", "<leader>bn", ":bnext<CR>") -- go to next buffer

-- Nvim-tree
key_map("n", "<leader>e", ":NvimTreeToggle<CR>") -- toggle file explorer

-- Symbols-outline
key_map("n", "<leader>l", ":SymbolsOutline<CR>")

-- Default keys (lsp)
key_map("n", "gd", vim.lsp.buf.definition) -- go to definition
key_map("n", "gD", vim.lsp.buf.declaration) -- go to declaration
key_map("n", "gr", vim.lsp.buf.references)
key_map("n", "gi", vim.lsp.buf.implementation) -- go to implementation
key_map("n", "K", vim.lsp.buf.hover) -- hover text
key_map("n", "<C-k>", vim.lsp.buf.signature_help) -- show signature
key_map("n", "<leader>wa", vim.lsp.buf.add_workspace_folder) -- add workspace folder
key_map("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder) -- remove workspace folder
key_map("n", "<leader>wl", function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end) --list workspace folder
key_map("n", "<leader>D", vim.lsp.buf.type_definition) -- go to type definition
key_map("n", "<leader>rn", vim.lsp.buf.rename) --rename
key_map("n", "<leader>ca", vim.lsp.buf.code_action) -- code actions
key_map("n", '<leader>f', function() vim.lsp.buf.format { async = true } end) -- format file

-- Debug
key_map("n", "<leader>bb", "<cmd>lua require'dap'.toggle_breakpoint()<CR>") -- set breakpoint
key_map("n", "<leader>bc", "<cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>") -- set condition breakpoint
key_map("n", "<leader>bl", "<cmd>lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>") -- set log point
key_map("n", "<leader>br", "<cmd>lua require'dap'.clear_breakpoints()<CR>") -- clear breakpoints
key_map("n", "<leader>ba", "<cmd>Telescope dap list_breakpoints<CR>") -- list breakpoints
key_map("n", "<leader>dc", "<cmd>lua require'dap'.continue()<CR>") -- continue
key_map("n", "<leader>dj", "<cmd>lua require'dap'.step_over()<CR>") -- step over
key_map("n", "<leader>dk", "<cmd>lua require'dap'.step_into()<CR>") -- step into
key_map("n", "<leader>do", "<cmd>lua require'dap'.step_out()<CR>") -- step out
key_map("n", "<leadet>dd", "<cmd>lua require'dap'.disconnect()<CR>") -- disconnect
key_map("n", "<leader>dt", "<cmd>lua require'dap'.terminate()<CR>") -- terminate
key_map("n", "<leader>dr", "<cmd>lua require'dap'.repl.toggle()<CR>") -- open REPL
key_map("n", "<leader>dl", "<cmd>lua require'dap'.run_last()<CR>") -- run last
key_map("n", "<leader>di", function() require "dap.ui.widgets".hover() end) -- variables
key_map("n", "<leader>d/", function() local widgets = require "dap.ui.widgets"; widgets.centered_float(widgets.scopes) end) -- scopes
key_map("n", "<leader>df", "<cmd>Telescope dap frames<CR>") -- list frames
key_map("n", "<leader>dh", "<cmd>Telescope dap commands<CR>") -- list commands

-- Searching
key_map("n", "<leader>ff", "<cmd>Telescope find_files<CR>") -- find file
key_map("n", "<leader>fb", "<cmd>Telescope buffers<CR>") -- find buffer
key_map("n", "<leader>fm", "<cmd>Telescope marks<CR>") -- find mark
key_map("n", "<leader>fr", "<cmd>Telescope lsp_references<CR>") -- find references
key_map("n", "<leader>fs", "<cmd>Telescope lsp_document_symbols<CR>") -- find symbols
key_map("n", "<leader>fc", "<cmd>Telescope lsp_incoming_calls<CR>") -- find incoming calls
key_map("n", "<leader>fo", "<cmd>Telescope lsp_outgoing_calls<CR>") -- find outgoing calls
key_map("n", "<leader>fi", "<cmd>Telescope lsp_implementations<cCR>") -- Find implementations
key_map("n", "<leader>fx", "<cmd>Telescope diagnostics bufnr=0<CR>") -- Find implementations

--------------------------------------
-- Unique keys mapping for language --
--------------------------------------

-- Java
function P.java_key_map(bufnr)
    local jdtls = require("jdtls")
    key_map("n", "<leader>oi", jdtls.organize_imports) -- organize imports
    key_map("n", "<leader>ve", jdtls.extract_variable) -- extract variable
    key_map("n", "<leader>ce", jdtls.extract_constant) -- extract constant
    key_map("v", "<leader>me", [[<ESC><CMD>lua require('jdtls').extract_method(true)<CR>]]) -- extract method
    key_map("n", "<leader>tc", jdtls.test_class) -- test class
    key_map("n", "<leader>tm", jdtls.test_nearest_method) -- test method

    -- Spring Boot App
    local spring_app = require('eojysele.auxiliary-scripts.language.java.run-spring-app')
    key_map("n", "<F9>", function() spring_app.run_spring_boot() end)
    key_map("n", "<F10>", function() spring_app.run_spring_boot(true) end) -- run in debug

end

return P
