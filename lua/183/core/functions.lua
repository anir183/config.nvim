-- http://stackoverflow.com/questions/37949298/ddg#37953903
local path_sep = package.config:sub(1, 1)

_G.FUNCS = {}

---@param modes string|string[]
---@param lhs string|string[]
---@param rhs string|function
---@param opts? vim.keymap.set.Opts
function FUNCS.map(modes, lhs, rhs, opts)
    if type(modes) == "string" then
        modes = { modes }
    end

    if type(lhs) == "string" then
        lhs = { lhs }
    end

    for _, mode in ipairs(modes) do
        for _, key in ipairs(lhs) do
            for _, mapping in
                ipairs(vim.api.nvim_get_keymap(mode))
            do
                if mapping.lhs == key then
                    vim.notify(
                        "conflicting global keymap " .. key,
                        vim.log.levels.ERROR
                    )
                    return
                end
            end

            for _, mapping in
                ipairs(vim.api.nvim_buf_get_keymap(0, mode))
            do
                if mapping.lhs == key then
                    vim.notify(
                        "conflicting buffer keymap " .. key,
                        vim.log.levels.ERROR
                    )
                    return
                end
            end
        end
    end

    vim.keymap.set(modes, lhs, rhs, opts)
    return true
end

---@param keys string
---@param mode? string
function FUNCS.feedkeys(keys, mode)
    mode = mode or "n"
    vim.api.nvim_feedkeys(vim.keycode(keys), mode, false)
end

---@param ... any
---@return string
function FUNCS.join_path(...)
    return table.concat({ ... }, path_sep)
end

---@param hl_grp number|string
---@param ... any
---@return string
function FUNCS.str_fmt(hl_grp, ...)
    local fmt_str = "%%#%s#%s%%*"
    return fmt_str:format(hl_grp, ...)
end

---@param str string
---@return boolean
function FUNCS.str_is_num(str)
    local num_regx = "^%-?%d+$"
    return str:match(num_regx)
end
