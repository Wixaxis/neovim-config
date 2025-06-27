local M = {}
M.rename_symbol = function() vim.lsp.buf.rename() end
M.code_action = function() vim.lsp.buf.code_action() end
M.go_to_definition = function() vim.lsp.buf.definition() end
M.go_to_declaration = function() vim.lsp.buf.declaration() end
M.find_references = function() Snacks.picker.lsp_references() end
M.go_to_implementation = function() vim.lsp.buf.implementation() end
M.go_to_type_definition = function() vim.lsp.buf.type_definition() end
M.hover = function() vim.lsp.buf.hover() end
M.function_signature = function() vim.lsp.buf.signature_help() end
M.format = function() vim.lsp.buf.format { async = true } end
return M
