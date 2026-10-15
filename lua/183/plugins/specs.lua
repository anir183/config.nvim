---@alias Hooks "install"|"update"|"delete"

---@class 183.PluginSpec
---@field repo string|vim.pack.Spec|{ data?: { hook: Hooks|fun(kind: Hooks): nil } }
---@field cond boolean|fun(): boolean
---@field priority? integer
---@field config function

---@type table<string, 183.PluginSpec>
local M = {
}

return M
