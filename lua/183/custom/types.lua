--[[ custom config related types ]]

---@class (exact) 183.custom.types.Keymap
---@field category? string
---@field mode? string | string[]
---@field lhs string
---@field rhs string | function
---@field opts? vim.keymap.set.Opts

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

---@class (exact) 183.custom.types.GitInfo
---@field initialized_aucmd? boolean if the auto command has been setup
---@field cache_version? integer version of the cached information
---@field cached_info? { cwd: string, branch: string, ahead: integer, behind: integer, staged: integer, modified: integer, untracked: integer }
---@field run_git? fun(cmd: string, args: string[], callback: fun(out: string): nil)
---@field set_branch_cache? fun(cache_ver: integer): nil
---@field set_ahead_behind_cache? fun(cache_ver: integer): nil
---@field set_status_cache? fun(cache_ver: integer): nil
---@field update_cache? fun(): nil
---@field setup? fun(): nil

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
---@field init_keymaps? fun(): nil
