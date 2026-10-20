require("183.plugins.quickopts")
require("183.plugins.builtins")

for _, ft in ipairs(QOPTS.get().filetypes) do
    vim.filetype.add(ft)
end

-- merge plugin specs from config and options
local specs = vim.tbl_deep_extend(
    "force",
    require("183.plugins.specs"),
    QOPTS.get().plugins
)

-- hooks
vim.api.nvim_create_autocmd("PackChanged", {
    callback = function(ev)
        local hook, kind =
            (ev.data.spec.data or {}).hook, ev.data.kind

        vim.defer_fn(function()
            if type(hook) == "function" then
                local ok, result, _ = pcall(hook, kind)
                if not ok then
                    vim.notify(
                        "couldnt run "
                            .. kind
                            .. " hook for "
                            .. ev.data.spec.src
                            .. "\n"
                            .. result,
                        vim.log.levels.ERROR
                    )
                end
            end

            if type(hook) == "string" then
                vim.cmd(hook)
            end
        end, 5000)
    end,
})

---@type 183.PluginSpec[]
local enabled = {}

-- filter for enabled plugins
for _, spec in pairs(specs) do
    local cond = spec.cond

    if type(cond) == "function" then
        cond = cond()
    end

    if cond ~= false then
        table.insert(enabled, spec)
    end
end

-- sort enabled plugins by priority
table.sort(enabled, function(a, b)
    local pa = a.priority or 0
    local pb = b.priority or 0

    return pa > pb
end)

-- install and load
local repos = {}
for _, spec in ipairs(enabled) do
    repos[#repos + 1] = spec.repo
end
vim.pack.add(repos)

-- configure
for _, spec in ipairs(enabled) do
    if type(spec.config) == "function" then
        spec.config()
    end
end
