--[[ utilities related types ]]

---@class (exact) 183.utils.types.Constants.LazyPriorities
---@field highest? integer
---@field high? integer
---@field default? integer
---@field low? integer

---@class (exact) 183.utils.types.Constants
---@field augrp? { name: string, id: integer }
---@field path? { separator: string, config: string, data: string, state: string }
---@field strings? { cmd_prefix: string, hl_fmt: string, pattern_num: string }
---@field lazy? { install_path: string, lock_file_path: string, repo_url: string, priorities: 183.utils.types.Constants.LazyPriorities }
---@field log? { dir_name: string, max_failed_write_tries: integer, labels: string[] }

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
