_G.PALETTE = { actions = {} }

---@class PaletteAction
---@field id string
---@field desc string
---@field category string
---@field keymap? string
---@field action string|fun()

---@param action PaletteAction
function PALETTE.add(action)
    assert(type(action) == "table", "palette action must be a table")
    assert(type(action.id) == "string" and action.id ~= "", "palette action needs an id")
    assert(
        type(action.desc) == "string" and action.desc ~= "",
        "palette action needs a description"
    )
    assert(
        type(action.category) == "string" and action.category ~= "",
        "palette action needs a category"
    )
    assert(
        type(action.action) == "string" or type(action.action) == "function",
        "palette action must be a command string or function"
    )

    PALETTE.actions[action.id] = action
end

---@param id string
function PALETTE.remove(id)
    PALETTE.actions[id] = nil
end

---@param id string
---@param changes table
function PALETTE.update(id, changes)
    local action = assert(PALETTE.actions[id], ("unknown palette action: %s"):format(id))
    for key, value in pairs(changes) do
        action[key] = value
    end
end

---@return PaletteAction[]
local function get_actions()
    local actions = vim.tbl_values(PALETTE.actions)
    table.sort(actions, function(a, b)
        return a.desc:lower() < b.desc:lower()
    end)
    return actions
end

-- `vim.ui.select` does not expose the provider's picker width. Use the editor
-- width as a useful estimate, with a cap and a narrow-window fallback.
---@return integer
local function display_width()
    return math.max(1, math.min(80, vim.o.columns - 8))
end

---@param action PaletteAction
---@return string
local function format_action(action)
    local keymap = action.keymap or ""
    local category = "[" .. action.category .. "]"
    local suffix = keymap ~= "" and (keymap .. " " .. category) or category
    local padding = math.max(
        1,
        display_width()
            - vim.fn.strdisplaywidth(action.desc)
            - vim.fn.strdisplaywidth(suffix)
    )

    return action.desc .. string.rep(" ", padding) .. suffix
end

---@param action PaletteAction
local function execute(action)
    vim.defer_fn(function()
        local ok, err = pcall(function()
            if type(action.action) == "string" then
                vim.cmd(action.action)
            else
                action.action()
            end
        end)

        if not ok then
            vim.notify(
                ("Palette action '%s' failed:\n%s"):format(action.desc, err),
                vim.log.levels.ERROR
            )
        end
    end, 10)
end

---@param actions PaletteAction[]
---@param prompt string
local function select_actions(actions, prompt)
    if #actions == 0 then
        vim.notify("No palette actions available", vim.log.levels.INFO)
        return
    end

    local labels = vim.tbl_map(format_action, actions)
    vim.ui.select(labels, { prompt = prompt }, function(_, index)
        if index then
            execute(actions[index])
        end
    end)
end

function PALETTE.open()
    select_actions(get_actions(), "Palette: ")
end

function PALETTE.categories()
    local counts = {}
    for _, action in ipairs(get_actions()) do
        counts[action.category] = (counts[action.category] or 0) + 1
    end

    local categories = vim.tbl_keys(counts)
    table.sort(categories, function(a, b)
        return a:lower() < b:lower()
    end)

    if #categories == 0 then
        vim.notify("No palette actions available", vim.log.levels.INFO)
        return
    end

    local labels = vim.tbl_map(function(category)
        return ("%s (%d actions)"):format(category, counts[category])
    end, categories)

    vim.ui.select(labels, { prompt = "Palette categories: " }, function(_, index)
        if index then
            local category = categories[index]
            local actions = vim.tbl_filter(function(action)
                return action.category == category
            end, get_actions())
            select_actions(actions, ("Palette: %s: "):format(category))
        end
    end)
end
