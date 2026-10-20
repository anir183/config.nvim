-- lsp
PALETTE.add({
    id = "lsp.info",
    desc = "lsp information",
    category = "lsp",
    action = function()
        vim.cmd("checkhealth vim.lsp")
    end
})
PALETTE.add({
    id = "lsp.log",
    desc = "lsp log",
    category = "lsp",
    action = function()
        local ui = vim.api.nvim_list_uis()[1]
        local width = math.floor((ui.width * 0.7) + 0.5)
        local height = math.floor((ui.height * 0.75) + 0.5)

        vim.api.nvim_open_win(vim.api.nvim_create_buf(false, true), true, {
            relative = "editor",
            width = width,
            height = height,
            col = (ui.width - width) / 2,
            row = (ui.height - height) / 2,
            focusable = true,
            border = "none",
        })

        vim.cmd.edit(FUNCS.join_path(vim.fn.stdpath("state"), "logs", "lsp.log"))
        vim.defer_fn(function()
            FUNCS.map("n", "q", "<cmd>q!<cr>")
        end, 10)
    end
})
PALETTE.add({
    id = "lsp.doc_symbols",
    desc = "list all symbols in buffer",
    category = "lsp",
    action = vim.lsp.buf.document_symbol,
})
PALETTE.add({
    id = "lsp.subtypes",
    desc = "list all subtypes of symbol",
    category = "lsp",
    action = function()
        vim.lsp.buf.typehierarchy("subtypes")
    end,
})
PALETTE.add({
    id = "lsp.supertypes",
    desc = "list all supertypes of symbol",
    category = "lsp",
    action = function()
        vim.lsp.buf.typehierarchy("supertypes")
    end,
})
PALETTE.add({
    id = "lsp.workspace_symbols",
    desc = "list all symbols in current workspace",
    category = "lsp",
    action = function()
        vim.lsp.buf.workspace_symbol("")
    end,
})
PALETTE.add({
    id = "lsp.filter_workspace_symbols",
    desc = "query and filter workspace symbols",
    category = "lsp",
    action = function()
        vim.ui.input({
            prompt = "workspace symbols filter query: ",
        }, function(query)
            if not query then
                return
            end

            vim.lsp.buf.workspace_symbol(query)
        end)
    end,
})
PALETTE.add({
    id = "lsp.workspace_diagnostics",
    desc = "request workspace-wide diagnostics",
    category = "lsp",
    action = vim.lsp.buf.workspace_diagnostics,
})
PALETTE.add({
    id = "lsp.workspace_add_folder",
    desc = "add a folder to the workspace",
    category = "lsp",
    action = vim.lsp.buf.add_workspace_folder,
})
PALETTE.add({
    id = "lsp.workspace_remove_folder",
    desc = "remove a folder from workspace",
    category = "lsp",
    action = function()
        vim.ui.select(vim.lsp.buf.list_workspace_folders(), {
            prompt = "choose workspace folder to remove: ",
        }, function(folder)
            if not folder then
                return
            end

            vim.lsp.buf.remove_workspace_folder(folder)
        end)
    end,
})

-- custom
PALETTE.add({
    id = "custom.center_cursor",
    desc = "toggle cursor centering",
    category = "custom",
    action = function()
        vim.o.scrolloff = 999 - vim.o.scrolloff
    end,
})
PALETTE.add({
    id = "custom.indentation",
    desc = "change indentation params",
    category = "custom",
    action = function()
        vim.ui.select({
            "tabs",
            "spaces",
        }, {
            prompt = "indentation type: ",
        }, function(indent_type)
            if not indent_type then
                return
            end

            -- setup buffer indentation setup and reindent
            local old_tab_len = vim.bo.tabstop
            vim.ui.input({
                prompt = "tab length: ",
                default = tostring(vim.bo.tabstop),
            }, function(new_tab_len)
                if not new_tab_len or not FUNCS.str_is_num(new_tab_len) then
                    new_tab_len = vim.bo.tabstop
                end
                new_tab_len = tonumber(new_tab_len) or old_tab_len

                -- reindent
                vim.ui.select({
                    "yes",
                    "no",
                }, {
                    prompt = "reindent: ",
                }, function(reindent)
                    if not reindent then
                        reindent = "no"
                    end

                    -- convert indentation to tabs
                    -- if reindentation is requested, then convert all indentation
                    -- to tabs which are easier to manipulate than individual spaces
                    if reindent == "yes" then
                        vim.bo.expandtab = false

                        -- WARN: retab command also replaces inline spaces, so we
                        --       use a substitution command instead
                        vim.cmd(
                            "silent! %s/\\(^\\s*\\)\\@<="
                                .. (" "):rep(old_tab_len)
                                .. "/	/g"
                        )

                        if indent_type == "spaces" then
                            vim.cmd(
                                "silent! %s/\\(^\\s*\\)\\@<=	/"
                                    .. (" "):rep(new_tab_len)
                                    .. "/g"
                            )
                        end
                    end

                    -- set buffer options
                    vim.bo.expandtab = (indent_type == "spaces")
                    vim.bo.tabstop = new_tab_len
                    vim.bo.shiftwidth = 0 -- size of each level of indentation (0 -> tabstop)
                    vim.bo.softtabstop = -1 -- size of tab character in insert mode (-1 -> shiftwidth)
                    vim.opt_local.listchars:remove("leadmultispace")
                    ---@diagnostic disable-next-line: param-type-mismatch
                    vim.opt_local.listchars:append({
                        leadmultispace = "│" .. (" "):rep(new_tab_len - 1),
                    })
                end)
            end)
        end)
    end,
})
PALETTE.add({
    id = "custom.absolute_path",
    desc = "display absolute path of file",
    category = "custom",
    action = function()
        vim.print("current path:\n" .. vim.fn.expand("%:p") .. "\n")
    end,
})

-- sessions
PALETTE.add({
    id = "session.start",
    desc = "start session manager",
    category = "session",
    action = SESS.start,
})
PALETTE.add({
    id = "session.stop",
    desc = "stop session manager",
    category = "session",
    action = SESS.stop,
})
PALETTE.add({
    id = "session.select",
    desc = "select session",
    category = "session",
    action = SESS.select,
})
PALETTE.add({
    id = "session.current",
    desc = "load session for cwd",
    category = "session",
    action = SESS.load,
})
PALETTE.add({
    id = "session.last",
    desc = "load last active session",
    category = "session",
    action = function()
        SESS.load({ last = true })
    end,
})
PALETTE.add({
    id = "session.save",
    desc = "save session",
    category = "session",
    action = function()
        if SESS.save() then
            vim.notify("session saved")
        end
    end,
})
