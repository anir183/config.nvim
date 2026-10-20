---@type 183.PluginSpec
---@diagnostic disable-next-line: missing-fields
local plugin = {}

plugin.repo =
    "https://github.com/theHamsta/nvim-dap-virtual-text"

plugin.config = function()
    ---@type nvim_dap_virtual_text_options
    local opts = {
        display_callback = function(variable)
            local name = variable.name:lower()

            -- Redact variables whose names suggest sensitive data.
            if
                name:match("secret")
                or name:match("token")
                or name:match("password")
                or name:match("passwd")
                or name:match("credential")
                or name:match("api[_%-]?key")
                or name:match("private[_%-]?key")
                or name:match("access[_%-]?key")
                or name:match("auth")
            then
                return " ******"
            end

            local value = variable.value:gsub("%s+", " ")

            if #value > 15 then
                return " " .. value:sub(1, 15) .. "..."
            end

            return " " .. value
        end,
    }

    require("nvim-dap-virtual-text").setup(opts)
end

return plugin
