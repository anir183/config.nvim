--[[ custom config related types ]]

---@class (exact) 183.custom.types.Command
---@field name string
---@field cmd string | fun(args: vim.api.keyset.create_user_command.command_args): nil
---@field opts? vim.api.keyset.user_command

---@class (exact) 183.custom.types.Netrw
---@field is_sidebar_open? boolean
---@field toggle_sidebar? fun(): nil
---@field toggle_fullscreen? fun(): nil
---@field create_commands? fun(): nil
---@field create_keymaps? fun(): nil

---@class (exact) 183.custom.types.StatuslineOpts
---@field mode_labels? table<string, string>
---@field arrangement? string[]

---@class (exact) 183.custom.types.Statusline
---@field components? table<string, fun(): string>
---@field get_component? fun(name: string): string
---@field set_arrangement? fun(): nil

---@class (exact) 183.custom.types.Module
---@field init_netrw? fun(): nil
---@field init_statusline? fun(): nil
---@field init_commands? fun(): nil
