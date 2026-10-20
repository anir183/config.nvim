_G.PALETTE = { actions = {} }

---@class 183.PaletteAction
---@field id string
---@field desc string
---@field category string
---@field action string|fun()

---@param action 183.PaletteAction
function PALETTE.add(action)
    assert(
        type(action) == "table",
        "palette action must be a table"
    )
    assert(
        type(action.id) == "string" and action.id ~= "",
        "palette action needs an id"
    )
    assert(
        type(action.desc) == "string" and action.desc ~= "",
        "palette action needs a description"
    )
    assert(
        type(action.category) == "string"
            and action.category ~= "",
        "palette action needs a category"
    )
    assert(
        type(action.action) == "string"
            or type(action.action) == "function",
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
    local action = assert(
        PALETTE.actions[id],
        ("unknown palette action: %s"):format(id)
    )
    for key, value in pairs(changes) do
        action[key] = value
    end
end

---@return 183.PaletteAction[]
local function get_actions()
    local actions = vim.tbl_values(PALETTE.actions)
    table.sort(actions, function(a, b)
        return a.desc:lower() < b.desc:lower()
    end)
    return actions
end

---@param action 183.PaletteAction
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
                ("palette action '%s' failed:\n%s"):format(
                    action.desc,
                    err
                ),
                vim.log.levels.ERROR
            )
        end
    end, 10)
end

---@param actions 183.PaletteAction[]
---@param prompt string
local function select_actions(actions, prompt)
    if #actions == 0 then
        vim.notify(
            "no palette actions available",
            vim.log.levels.INFO
        )
        return
    end

    vim.ui.select(
        vim.tbl_map(function(action)
            return action.category .. ": " .. action.desc
        end, actions),
        { prompt = prompt },
        function(_, index)
            if index then
                execute(actions[index])
            end
        end
    )
end

function PALETTE.open()
    select_actions(get_actions(), "palette: ")
end
