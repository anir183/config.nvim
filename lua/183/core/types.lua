--[[ core config related types ]]

---@class (exact) 183.core.types.Keymap
---@field category? string
---@field mode? string | string[]
---@field lhs string
---@field rhs string | function
---@field opts? vim.keymap.set.Opts
---
---@class (exact) 183.core.types.LspKeymap
---@field mode? string | string[]
---@field lhs string
---@field rhs function

---@class (exact) 183.core.types.Options
---@field set_colorscheme? fun(): nil
---@field set_signcolumn? fun(): nil
---@field set_folding? fun(): nil
---@field set_indentation? fun(): nil
---@field set_editor_rendering? fun(): nil
---@field set_editor_behaviour? fun(): nil
---@field set_save_files? fun(): nil

---@class (exact) 183.core.types.Module
---@field init_options? fun(): nil
---@field init_keymaps? fun(): nil
---@field init_lsp_keymaps? fun(): nil
