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
