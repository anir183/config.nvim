---@type 183.PluginSpec
---@diagnostic disable-next-line: missing-fields
local plugin = {}

plugin.repo = "https://github.com/OXY2DEV/markview.nvim"
plugin.config = function()
    -- action palette
    local function add(id, desc, action)
        PALETTE.add({
            id = "markview." .. id,
            desc = desc,
            category = "markview",
            action = action,
        })
    end

    add("gtoggle", "toggle markview globally", "Markview Toggle")
    add(
        "btoggle",
        "toggle markview in buffer",
        "Markview toggle"
    )
    add("genable", "enable markview globally", "Markview Enable")
    add(
        "benable",
        "enable markview in buffer",
        "Markview enable"
    )
    add(
        "gdisable",
        "disable markview globally",
        "Markview Disable"
    )
    add(
        "bdisable",
        "disable markview in buffer",
        "Markview disable"
    )
    add(
        "splittoggle",
        "toggle split view",
        "Markview splitToggle"
    )
end

return plugin
