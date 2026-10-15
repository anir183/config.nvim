-- based on folke/persistence.nvim:
-- https://github.com/folke/persistence.nvim/blob/b20b2a7887bd39c1a356980b45e03250f3dce49c/lua/persistence/init.lua

_G.SESS = {
    _active = false,
    _loading = false,
    min_bufs = 1,
}

local SESS = _G.SESS

local uv = vim.uv or vim.loop
local sessdir = vim.fs.joinpath(vim.fn.stdpath("state"), "sessions")
local sessgrp = vim.api.nvim_create_augroup("sess183", {
    clear = true,
})

local save_timer

local excluded_filetypes = {
    gitcommit = true,
    gitrebase = true,
    jj = true,
}

---@param message string
---@param level? integer
local function notify(message, level)
    vim.notify(message, level or vim.log.levels.INFO, {
        title = "sessions",
    })
end

---@return boolean
local function ensure_dir()
    if vim.fn.isdirectory(sessdir) == 1 then
        return true
    end

    vim.fn.mkdir(sessdir, "p")

    if vim.fn.isdirectory(sessdir) == 1 then
        return true
    end

    notify(
        ("could not create session directory:\n%s"):format(sessdir),
        vim.log.levels.ERROR
    )
    return false
end

-- percent-encode every character except ascii letters, digits, ".", "_", and "-".
-- in particular, encode literal "%" and "~" so the branch delimiter cannot collide
-- with any encoded path or branch name.
---@param value string
---@return string
local function encode(value)
    return (
        value:gsub("[^%w%._%-]", function(char)
            return ("%%%02X"):format(char:byte())
        end)
    )
end

---@param value string
---@return string
local function decode(value)
    return (
        value:gsub("%%(%x%x)", function(hex)
            return string.char(tonumber(hex, 16) or 0)
        end)
    )
end

---@param cwd string
---@param branch? string
---@return string
local function session_name(cwd, branch)
    local name = encode(vim.fs.normalize(cwd))

    if branch and branch ~= "" then
        name = name .. "~b~" .. encode(branch)
    end

    return name .. ".vim"
end

---@param file string
---@return { session: string, dir: string, branch?: string }
local function parse_session(file)
    local name = vim.fn.fnamemodify(file, ":t:r")
    local dir, branch = name:match("^(.-)~b~(.+)$")

    return {
        session = file,
        dir = decode(dir or name),
        branch = branch and decode(branch) or nil,
    }
end

---@return boolean
local function has_enough_buffers()
    if SESS.min_bufs <= 0 then
        return true
    end

    local count = 0

    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
        if
            vim.api.nvim_buf_is_valid(buf)
            and vim.bo[buf].buftype == ""
            and not excluded_filetypes[vim.bo[buf].filetype]
            and vim.api.nvim_buf_get_name(buf) ~= ""
        then
            count = count + 1

            if count >= SESS.min_bufs then
                return true
            end
        end
    end

    return false
end

---@return boolean
local function snacks_explorer_open()
    local ok, is_open = pcall(function()
        local snacks = require("snacks")

        if not snacks.picker or type(snacks.picker.get) ~= "function" then
            return false
        end

        return #snacks.picker.get({ source = "explorer" }) > 0
    end)

    return ok and is_open == true
end

local function cancel_save()
    if save_timer then
        save_timer:stop()
        save_timer = nil
    end
end

local function schedule_save()
    if not SESS._active or SESS._loading then
        return
    end

    cancel_save()

    save_timer = vim.defer_fn(function()
        save_timer = nil

        if SESS._active and not SESS._loading and has_enough_buffers() then
            SESS.save()
        end
    end, 1000)
end

---@param opts? { branch?: boolean }
---@return string
function SESS.current(opts)
    opts = opts or {}

    local branch = opts.branch ~= false and SESS.branch() or nil

    return vim.fs.joinpath(sessdir, session_name(vim.fn.getcwd(), branch))
end

---@return boolean
function SESS.active()
    return SESS._active
end

function SESS.start()
    if SESS._active then
        return
    end

    if not ensure_dir() then
        return
    end

    SESS._active = true

    vim.api.nvim_create_autocmd({
        "BufEnter",
        "BufDelete",
        "WinEnter",
        "WinClosed",
        "TabEnter",
        "TabClosed",
        "DirChanged",
    }, {
        group = sessgrp,
        callback = function()
            if not SESS._loading and has_enough_buffers() then
                schedule_save()
            end
        end,
    })

    vim.api.nvim_create_autocmd("VimLeavePre", {
        group = sessgrp,
        callback = function()
            cancel_save()

            if SESS._active and not SESS._loading and has_enough_buffers() then
                SESS.save()
            end
        end,
    })
end

function SESS.stop()
    SESS._active = false

    cancel_save()

    vim.api.nvim_clear_autocmds({
        group = sessgrp,
    })
end

---@return boolean
function SESS.save()
    if SESS._loading or not has_enough_buffers() then
        return false
    end

    if not ensure_dir() then
        return false
    end

    local sessionoptions = vim.o.sessionoptions

    vim.opt.sessionoptions:remove("blank")

    local ok, err = pcall(
        ---@diagnostic disable-next-line: param-type-mismatch
        vim.cmd,
        "mksession! " .. vim.fn.fnameescape(SESS.current())
    )

    -- always restore the user's original sessionoptions.
    vim.o.sessionoptions = sessionoptions

    if not ok then
        notify(("failed to save session:\n%s"):format(err), vim.log.levels.ERROR)
        return false
    end

    return true
end

---@param opts? { file?: string, last?: boolean }
---@return boolean
function SESS.load(opts)
    opts = opts or {}

    local file = opts.file

    if not file then
        if opts.last then
            file = SESS.last()

            -- do not silently substitute the current session when there is
            -- no previously saved session.
            if not file then
                return false
            end
        else
            file = SESS.current()

            -- fall back to the directory-only session when the branch-specific
            -- session does not exist.
            if vim.fn.filereadable(file) == 0 then
                file = SESS.current({ branch = false })
            end
        end
    end

    if vim.fn.filereadable(file) == 0 then
        return false
    end

    if snacks_explorer_open() then
        notify("close the Snacks explorer before loading a session", vim.log.levels.WARN)
        return false
    end

    -- session restoration triggers buffer, window, and tab events. suppress
    -- autosaving until :source has completed, including on errors.
    cancel_save()
    SESS._loading = true

    local ok, err = pcall(
        ---@diagnostic disable-next-line: param-type-mismatch
        vim.cmd,
        "silent source " .. vim.fn.fnameescape(file)
    )

    SESS._loading = false

    if not ok then
        notify(("failed to load session:\n%s"):format(err), vim.log.levels.ERROR)
        return false
    end

    return true
end

---@return string[]
function SESS.list()
    if not ensure_dir() then
        return {}
    end

    local sessions = vim.fn.glob(vim.fs.joinpath(sessdir, "*.vim"), false, true)

    table.sort(sessions, function(a, b)
        local stat_a = uv.fs_stat(a)
        local stat_b = uv.fs_stat(b)

        if not stat_a then
            return false
        end

        if not stat_b then
            return true
        end

        if stat_a.mtime.sec ~= stat_b.mtime.sec then
            return stat_a.mtime.sec > stat_b.mtime.sec
        end

        return (stat_a.mtime.nsec or 0) > (stat_b.mtime.nsec or 0)
    end)

    return sessions
end

---@return string?
function SESS.last()
    return SESS.list()[1]
end

---@param item { session: string, dir: string, branch?: string }
---@return string
local function format_session(item)
    local text = vim.fn.fnamemodify(item.dir, ":p:~")

    if item.branch then
        text = ("%s [%s]"):format(text, item.branch)
    end

    return text
end

function SESS.select()
    ---@type { session: string, dir: string, branch?: string }[]
    local items = {}

    for _, file in ipairs(SESS.list()) do
        items[#items + 1] = parse_session(file)
    end

    if #items == 0 then
        notify("no saved sessions")
        return
    end

    vim.ui.select(items, {
        prompt = "select session: ",
        format_item = format_session,
    }, function(item)
        if item then
            SESS.load({ file = item.session })
        end
    end)
end

function SESS.delete()
    ---@type { session: string, dir: string, branch?: string }[]
    local items = {}

    for _, file in ipairs(SESS.list()) do
        items[#items + 1] = parse_session(file)
    end

    if #items == 0 then
        notify("no saved sessions")
        return
    end

    vim.ui.select(items, {
        prompt = "delete session: ",
        format_item = format_session,
    }, function(item)
        if not item then
            return
        end

        vim.ui.select({ "no", "yes" }, {
            prompt = ("delete session '%s'?"):format(format_session(item)),
        }, function(choice)
            if choice ~= "yes" then
                return
            end

            if vim.fn.delete(item.session) == 0 then
                notify("session deleted")
            else
                notify("failed to delete session", vim.log.levels.ERROR)
            end
        end)
    end)
end

---@return string?
function SESS.branch()
    local result = vim.system({
        "git",
        "branch",
        "--show-current",
    }, {
        cwd = vim.fn.getcwd(),
        text = true,
    }):wait()

    if result.code ~= 0 then
        return nil
    end

    local branch = vim.trim(result.stdout or "")

    return branch ~= "" and branch or nil
end

SESS.start()
