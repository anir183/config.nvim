--[[ utilities related types ]]

---@class (exact) 183.utils.types.Constants.LazyPriorities
---@field highest? integer
---@field high? integer
---@field default? integer
---@field low? integer

---@class (exact) 183.utils.types.Constants.EnvKeys
---@field mode? string
---@field shell? string
---@field logging_opts? { logs_dir_parent: string, output: { notify: string, print: string, vim_print: string, file: string } }

---@class (exact) 183.utils.types.Constants
---@field default_colorscheme? string
---@field augrp? { name: string, id: integer }
---@field path? { separator: string, config: string, data: string, state: string }
---@field strings? { cmd_prefix: string, hl_fmt: string, pattern_num: string }
---@field env_keys? 183.utils.types.Constants.EnvKeys keys to check from host environment for configuration values
---@field lazy? { install_path: string, lock_file_path: string, repo_url: string, priorities: 183.utils.types.Constants.LazyPriorities }
---@field log? { dir_name: string, max_failed_write_tries: integer, labels: string[] }

---@class (exact) 183.utils.types.Functions
---@field map? fun(mode: string | string[], lhs: string, rhs: string | function, opts: vim.keymap.set.Opts): nil
---@field nmap? fun(lhs: string, rhs: string | function, opts: vim.keymap.set.Opts): nil
---@field mmap? fun(lhs: string, actions: table<string, string | function>, opts: vim.keymap.set.Opts): nil
---@field feedkeys? fun(keys: string, mode?: string): nil
---@field deep_loop_table? fun(obj: table, callback: fun(path: string[], key: string, value: any), path?: string[]) loop through a table and all sub-tabes and perform operation on all non-table values
---@field is_unix? fun(): boolean
---@field is_windows? fun(): boolean
---@field join_path? fun(...: any): string
---@field fmt_str? fun(hl_grp: string | number, ...: any): string format string in a highlight group
---@field split_str? fun(str: string, sep?: string): string[]
---@field is_num? fun(str: string): boolean

---@class (exact) 183.utils.types.LoggingOpts.Outputs
---@field notify? vim.log.levels
---@field print? vim.log.levels
---@field vim_print? vim.log.levels
---@field file? vim.log.levels

---@class (exact) 183.utils.types.LoggingOpts
---@field output? 183.utils.types.LoggingOpts.Outputs
---@field logs_dir_parent? string
---@field display_after_ready? boolean wait until vim is ready (VimEnter event triggered) before showing logs so that config flow is not interrupted

---@module "io"
---@class (exact) 183.utils.types.Logging.RuntimeVars
---@field log_file? file*
---@field log_file_path? string
---@field log_file_ready? boolean
---@field failed_write_tries? integer
---@field display_ready? boolean
---@field display_backlog? table<string, { reqd_level: vim.log.levels, data: any }>

---@class (exact) 183.utils.types.Logging
---@field runtime_vars? 183.utils.types.Logging.RuntimeVars
---@field setup_log_file? fun(): nil NEEDS TO EXECUTE BEFORE USING LOGGING WITH OUTPUT "file"
---@field print? fun(reqd_level: vim.log.levels, data: table): nil log provided data at given log-level
---@field trace? fun(f: integer | function): nil log code trace
---@field debug? fun(...: any): nil log data at debug level
---@field info? fun(...: any): nil log data at information level
---@field warn? fun(...: any): nil log data at warning level
---@field error? fun(...: any): nil log data at error level
