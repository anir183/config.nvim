--[[ utilities related types ]]

---@class (exact) 183.utils.types.Constants.LazyPriorities
---@field highest? integer
---@field high? integer
---@field default? integer
---@field low? integer

---@class (exact) 183.utils.types.Constants.EnvKeys
---@field mode? string
---@field shell? string

---@class (exact) 183.utils.types.Constants
---@field default_colorscheme? string
---@field augrp? { name: string, id: integer }
---@field path? { separator: string, config: string, data: string, state: string }
---@field strings? { cmd_prefix: string, hl_fmt: string, pattern_num: string }
---@field env_keys? 183.utils.types.Constants.EnvKeys keys to check from host environment for configuration values
---@field lazy? { install_path: string, lock_file_path: string, repo_url: string, priorities: 183.utils.types.Constants.LazyPriorities }

---@class (exact) 183.utils.types.Functions
---@field map? fun(mode: string | string[], lhs: string, rhs: string | function, opts: vim.keymap.set.Opts): nil
---@field mmap? fun(lhs: string, actions: table<string, string | function>, opts: vim.keymap.set.Opts): nil
---@field feedkeys? fun(keys: string, mode?: string): nil
---@field deep_loop_table? fun(obj: table, callback: fun(path: string[], key: string, value: any), path?: string[]) loop through a table and all sub-tabes and perform operation on all non-table values
---@field is_unix? fun(): boolean
---@field is_windows? fun(): boolean
---@field join_path? fun(...: any): string
---@field fmt_str? fun(hl_grp: string | number, ...: any): string format string in a highlight group
---@field split_str? fun(str: string, sep?: string): string[]
---@field is_num? fun(str: string): boolean
