---@type 183.PluginSpec
---@diagnostic disable-next-line: missing-fields
local plugin = {}

plugin.repo = "https://github.com/folke/snacks.nvim"
plugin.config = function()
    vim.g.snacks_animate = false

    local snacks = require("snacks")
    local map = FUNCS.map
    local nmap = function(...)
        map("n", ...)
    end
    local del = vim.keymap.del

    snacks.setup({
        bigfile = { enabled = true },
        dashboard = { enabled = false },
        indent = { enabled = false },
        input = { enabled = true },
        quickfile = { enabled = true },
        scope = { enabled = false },
        scroll = { enabled = false },
        statuscolumn = { enabled = false },
        word = {
            enabled = false,
        },

        explorer = {
            enabled = true,
            replace_netrw = true,
        },

        lazygit = {
            auto_insert = true,
            start_insert = true,
            win = {
                backdrop = false,
                border = "solid",
                height = 0.8,
                width = 0.8,
            },
        },

        picker = {
            layout = vim.g.neovide and "vscode_xl" or "default",

            layouts = {
                vscode_xl = {
                    layout = {
                        backdrop = false,
                        row = 1,
                        width = 0.8,
                        min_width = 100,
                        height = 0.8,
                        border = "none",
                        box = "horizontal",
                        {
                            box = "vertical",
                            {
                                win = "input",
                                height = 1,
                                border = true,
                                title = "{title} {live} {flags}",
                                title_pos = "center",
                            },
                            { win = "list", border = "hpad" },
                        },
                        {
                            win = "preview",
                            title = "{preview}",
                            border = true,
                            width = 0.5,
                        },
                    },
                },

                vscode_l = {
                    hidden = { "preview" },
                    layout = {
                        backdrop = false,
                        row = 1,
                        width = 0.5,
                        min_width = 80,
                        height = 0.5,
                        border = "none",
                        box = "vertical",
                        {
                            win = "input",
                            height = 1,
                            border = true,
                            title = "{title} {live} {flags}",
                            title_pos = "center",
                        },
                        { win = "list", border = "hpad" },
                        {
                            win = "preview",
                            title = "{preview}",
                            border = true,
                        },
                    },
                },
            },

            sources = {
                explorer = {
                    layout = {
                        auto_hide = { "input" },
                    },
                },

                keymaps = {
                    layout = vim.g.neovide and "vscode_l"
                        or "default",
                },

                select = {
                    layout = {
                        preset = vim.g.neovide and "vscode"
                            or "select",
                    },
                },

                colorschemes = {
                    layout = "vscode",
                },
            },

            win = {
                input = {
                    keys = {
                        ["<C-p>"] = {
                            "toggle_preview",
                            mode = { "i", "n" },
                        },

                        ["<C-S-p>"] = "focus_preview",
                    },
                },

                list = {
                    keys = {
                        ["<C-p>"] = "toggle_preview",
                        ["<C-S-p>"] = "focus_preview",
                    },
                },
            },
        },

        terminal = {
            start_insert = true,
            auto_insert = true,
            auto_close = true,
        },
    })

    -- explorer
    nmap("<leader>e", function()
        snacks.explorer()
    end, { desc = "[plugins.snacks] open [e]xplorer in cwd" })

    -- nvim pickers
    nmap(
        "<leader>?",
        snacks.picker.search_history,
        { desc = "[plugins.snacks] search history" }
    )
    map(
        { "n", "x" },
        "<leader>*",
        snacks.picker.grep_word,
        { desc = "[plugins.snacks] grep word under cursor" }
    )
    nmap(
        "<leader>:",
        snacks.picker.command_history,
        { desc = "[plugins.snacks] command history" }
    )

    -- file pickers
    nmap(
        "<C-p>",
        snacks.picker.files,
        { desc = "[plugins.snacks] [f]ind [f]iles" }
    )
    nmap(
        "<leader>ff",
        function()
            snacks.picker.files({
                ignored = true,
                hidden = true,
            })
        end,
        { desc = "[plugins.snacks] [f]ind files [a]ll inclusive" }
    )
    nmap("<leader>FF", function()
        snacks.picker.files({
            cwd = vim.fn.expand("%:p:h"),
        })
    end, {
        desc = "[plugins.snacks] [F]ind [F]iles in current directory",
    })
    nmap("<leader>fc", function()
        snacks.picker.files({
            cwd = vim.fn.stdpath("config"),
            ignored = true,
            hidden = true,
        })
    end, {
        desc = "[plugins.snacks] [f]ind files in [c]onfig directory",
    })
    nmap(
        "<leader>fr",
        snacks.picker.recent,
        {
            desc = "[plugins.snacks] [f]ind [r]ecently visited files",
        }
    )

    -- grep pickers
    nmap(
        "<leader>gg",
        snacks.picker.grep,
        { desc = "[plugins.snacks] [g]lobal [g]rep" }
    )
    nmap(
        "<leader>GG",
        function()
            snacks.picker.grep({
                cwd = vim.fn.expand("%:h"),
            })
        end,
        {
            desc = "[plugins.snacks] [G]lobal [G]rep current directory",
        }
    )
    nmap(
        "<leader>fr",
        snacks.picker.recent,
        {
            desc = "[plugins.snacks] [f]ind [r]ecently visited files",
        }
    )

    -- buffers
    nmap(
        "<leader>fb",
        snacks.picker.buffers,
        {
            desc = "[plugins.snacks] [f]ind open [b]uffers",
        }
    )

    -- words
    nmap("]w", function()
        snacks.words.jump(vim.v.count1, true)
    end, {
        desc = "[plugins.snacks] jump to next [w]ord reference",
    })
    nmap("[w", function()
        snacks.words.jump(-vim.v.count1, true)
    end, {
        desc = "[plugins.snacks] jump to previous [w]ord references",
    })

    del("n", "gd")
    del("n", "gD")
    del("n", "gr")
    del("n", "gi")
    del("n", "gy")
    del("n", "gai")
    del("n", "gao")
    nmap(
        "gd",
        snacks.picker.lsp_definitions,
        { desc = "[plugins.snacks] [g]oto [d]efinition" }
    )
    nmap(
        "gD",
        snacks.picker.lsp_definitions,
        { desc = "[plugins.snacks] [g]oto [D]eclaration" }
    )
    nmap(
        "gr",
        snacks.picker.lsp_references,
        { desc = "[plugins.snacks] [g]oto [r]eferences" }
    )
    nmap(
        "gi",
        snacks.picker.lsp_implementations,
        { desc = "[plugins.snacks] [g]oto [i]mplementation" }
    )
    nmap(
        "gy",
        snacks.picker.lsp_type_definitions,
        { desc = "[plugins.snacks] t[y]pe definition" }
    )
    nmap(
        "gai",
        snacks.picker.lsp_incoming_calls,
        { desc = "[plugins.snacks] [i]ncoming calls" }
    )
    nmap(
        "gao",
        snacks.picker.lsp_outgoing_calls,
        { desc = "[plugins.snacks] [o]utgoing calls" }
    )

    -- terminal keymaps
    nmap(
        "<leader>tt",
        snacks.terminal.toggle,
        { desc = "[plugins.snacks] [t]oggle [t]erminal window" }
    )
    nmap(
        "<leader>to",
        snacks.terminal.open,
        { desc = "[plugins.snacks] new [t]erminal [o]pen" }
    )

    -- scratch buffer
    nmap("<leader>sc", function()
        snacks.scratch()
    end, { desc = "[plugins.snacks] open [sc]ratch buffer" })

    -- git
    nmap("<leader>lg", function()
        snacks.lazygit()
    end, { desc = "[plugins.snacks] open [l]azy[g]it" })
    nmap(
        "<leader>gb",
        function()
            -- NOTE: blame line opens in terminal mode and any key press dismisses it
            --       explicitly stopinsert() to return to normal mode
            snacks.git.blame_line({
                interactive = false,
                auto_close = false,
                win = {
                    style = "blame_line",
                    on_win = function(_)
                        vim.cmd.stopinsert()
                    end,
                },
            })
        end,
        { desc = "[plugins.snacks] [g]it [b]lame current line" }
    )

    -- picker: general
    PALETTE.add({
        id = "snacks.picker.smart",
        desc = "find files and buffers",
        category = "snacks.picker",
        action = snacks.picker.smart,
    })
    PALETTE.add({
        id = "snacks.picker.buffers",
        desc = "find open buffers",
        category = "snacks.picker",
        action = snacks.picker.buffers,
    })
    PALETTE.add({
        id = "snacks.picker.lines",
        desc = "search current buffer lines",
        category = "snacks.picker",
        action = snacks.picker.lines,
    })
    PALETTE.add({
        id = "snacks.picker.grep_buffers",
        desc = "grep open buffers",
        category = "snacks.picker",
        action = snacks.picker.grep_buffers,
    })
    PALETTE.add({
        id = "snacks.picker.keymaps",
        desc = "find available keymaps",
        category = "snacks.picker",
        action = snacks.picker.keymaps,
    })
    PALETTE.add({
        id = "snacks.picker.help",
        desc = "search help pages",
        category = "snacks.picker",
        action = snacks.picker.help,
    })
    PALETTE.add({
        id = "snacks.picker.qflist",
        desc = "search quick fix list",
        category = "snacks.picker",
        action = snacks.picker.qflist,
    })
    PALETTE.add({
        id = "snacks.picker.loclist",
        desc = "search location list",
        category = "snacks.picker",
        action = snacks.picker.loclist,
    })
    PALETTE.add({
        id = "snacks.picker.git_files",
        desc = "find git-tracked files",
        category = "snacks.picker",
        action = snacks.picker.git_files,
    })
    PALETTE.add({
        id = "snacks.picker.projects",
        desc = "find projects",
        category = "snacks.picker",
        action = snacks.picker.projects,
    })
    PALETTE.add({
        id = "snacks.picker.resume",
        desc = "resume last picker",
        category = "snacks.picker",
        action = snacks.picker.resume,
    })
    PALETTE.add({
        id = "snacks.picker.recent",
        desc = "find recently visited files",
        category = "snacks.picker",
        action = snacks.picker.recent,
    })

    -- picker: search and navigation
    PALETTE.add({
        id = "snacks.picker.registers",
        desc = "search registers",
        category = "snacks.picker",
        action = snacks.picker.registers,
    })
    PALETTE.add({
        id = "snacks.picker.autocmds",
        desc = "search autocommands",
        category = "snacks.picker",
        action = snacks.picker.autocmds,
    })
    PALETTE.add({
        id = "snacks.picker.commands",
        desc = "search available commands",
        category = "snacks.picker",
        action = snacks.picker.commands,
    })
    PALETTE.add({
        id = "snacks.picker.diagnostics",
        desc = "search all diagnostics",
        category = "snacks.picker",
        action = snacks.picker.diagnostics,
    })
    PALETTE.add({
        id = "snacks.picker.diagnostics_buffer",
        desc = "search buffer diagnostics",
        category = "snacks.picker",
        action = snacks.picker.diagnostics_buffer,
    })
    PALETTE.add({
        id = "snacks.picker.highlights",
        desc = "inspect highlight groups",
        category = "snacks.picker",
        action = snacks.picker.highlights,
    })
    PALETTE.add({
        id = "snacks.picker.undo",
        desc = "browse undo history",
        category = "snacks.picker",
        action = snacks.picker.undo,
    })
    PALETTE.add({
        id = "snacks.picker.man",
        desc = "search man pages",
        category = "snacks.picker",
        action = snacks.picker.man,
    })
    PALETTE.add({
        id = "snacks.picker.jumps",
        desc = "browse jump history",
        category = "snacks.picker",
        action = snacks.picker.jumps,
    })
    PALETTE.add({
        id = "snacks.picker.marks",
        desc = "browse marks",
        category = "snacks.picker",
        action = snacks.picker.marks,
    })
    PALETTE.add({
        id = "snacks.picker.icons",
        desc = "browse icons",
        category = "snacks.picker",
        action = snacks.picker.icons,
    })
    PALETTE.add({
        id = "snacks.picker.colorschemes",
        desc = "browse colorschemes",
        category = "snacks.picker",
        action = snacks.picker.colorschemes,
    })

    -- picker: todo comments
    PALETTE.add({
        id = "snacks.picker.todocomments",
        desc = "browse special todo comment",
        category = "snacks.todo",
        action = function()
            ---@diagnostic disable-next-line: undefined-field
            snacks.picker.todo_comments()
        end,
    })
    PALETTE.add({
        id = "snacks.picker.todoselect",
        desc = "select and browser particular todo comments",
        category = "snacks.todo",
        action = function()
            local keywords = vim.tbl_keys(
                require("todo-comments.config").options.keywords
            )
            table.sort(keywords)

            vim.ui.select(keywords, {
                prompt = "todo keyword: ",
            }, function(choice)
                if choice then
                    ---@diagnostic disable-next-line: undefined-field
                    snacks.picker.todo_comments({
                        keywords = { choice },
                    })
                end
            end)
        end,
    })

    -- picker: git
    PALETTE.add({
        id = "snacks.git.branches",
        desc = "browse git branches",
        category = "snacks.git",
        action = snacks.picker.git_branches,
    })
    PALETTE.add({
        id = "snacks.git.log",
        desc = "browse git history",
        category = "snacks.git",
        action = snacks.picker.git_log,
    })
    PALETTE.add({
        id = "snacks.git.log_line",
        desc = "browse history for current line",
        category = "snacks.git",
        action = snacks.picker.git_log_line,
    })
    PALETTE.add({
        id = "snacks.git.status",
        desc = "browse git status",
        category = "snacks.git",
        action = snacks.picker.git_status,
    })
    PALETTE.add({
        id = "snacks.git.stash",
        desc = "browse git stashes",
        category = "snacks.git",
        action = snacks.picker.git_stash,
    })
    PALETTE.add({
        id = "snacks.git.diff",
        desc = "browse git diffs",
        category = "snacks.git",
        action = snacks.picker.git_diff,
    })
    PALETTE.add({
        id = "snacks.git.log_file",
        desc = "browse history for current file",
        category = "snacks.git",
        action = snacks.picker.git_log_file,
    })
    PALETTE.add({
        id = "snacks.git.blame_line",
        desc = "show git blame for current line",
        category = "snacks.git",
        action = function()
            Snacks.git.blame_line({
                interactive = false,
                auto_close = false,
                win = {
                    style = "blame_line",
                    on_win = function()
                        vim.cmd.stopinsert()
                    end,
                },
            })
        end,
    })
    PALETTE.add({
        id = "snacks.git.browse",
        desc = "open current file in git remote",
        category = "snacks.git",
        action = snacks.gitbrowse.open,
    })
    PALETTE.add({
        id = "snacks.git.lazygit",
        desc = "open lazygit",
        category = "snacks.git",
        action = snacks.lazygit.open,
    })

    -- picker: github
    PALETTE.add({
        id = "snacks.github.open_issues",
        desc = "browser open github issues",
        category = "snacks.github",
        action = snacks.picker.gh_issue,
    })
    PALETTE.add({
        id = "snacks.github.all_issues",
        desc = "browser all github issues",
        category = "snacks.github",
        action = function()
            snacks.picker.gh_issue({ state = "all" })
        end,
    })
    PALETTE.add({
        id = "snacks.github.open_prs",
        desc = "browser open github pull requests",
        category = "snacks.github",
        action = snacks.picker.gh_pr,
    })
    PALETTE.add({
        id = "snacks.github.all_prs",
        desc = "browser all github pull requests",
        category = "snacks.github",
        action = function()
            snacks.picker.gh_pr({ state = "all" })
        end,
    })

    -- lsp
    PALETTE.add({
        id = "snacks.lsp.symbols",
        desc = "list lsp symbols",
        category = "snacks.lsp",
        action = snacks.picker.lsp_symbols,
    })
    PALETTE.add({
        id = "snacks.lsp.workspace_symbols",
        desc = "list workspace-wide lsp symbols",
        category = "snacks.lsp",
        action = snacks.picker.lsp_workspace_symbols,
    })

    -- terminal
    PALETTE.add({
        id = "snacks.terminal.toggle",
        desc = "toggle terminal",
        category = "snacks.terminal",
        action = snacks.terminal.toggle,
    })
    PALETTE.add({
        id = "snacks.terminal.open",
        desc = "open new terminal",
        category = "snacks.terminal",
        action = snacks.terminal.open,
    })

    -- scratch buffers
    PALETTE.add({
        id = "snacks.scratch.toggle",
        desc = "toggle scratch buffer",
        category = "snacks.scratch",
        action = function()
            snacks.scratch()
        end,
    })
    PALETTE.add({
        id = "snacks.scratch.select",
        desc = "select scratch buffer",
        category = "snacks.scratch",
        action = snacks.scratch.select,
    })

    -- UI and editing
    PALETTE.add({
        id = "snacks.rename.file",
        desc = "rename current file",
        category = "snacks.rename",
        action = snacks.rename.rename_file,
    })
    PALETTE.add({
        id = "snacks.zen.toggle",
        desc = "toggle zen mode",
        category = "snacks.zen",
        action = function()
            snacks.zen()
        end,
    })
    PALETTE.add({
        id = "snacks.zen.zoom",
        desc = "toggle window zoom",
        category = "snacks.zen",
        action = snacks.zen.zoom,
    })
    PALETTE.add({
        id = "snacks.dim.enable",
        desc = "enable dimming",
        category = "snacks.dim",
        action = snacks.dim.enable,
    })
    PALETTE.add({
        id = "snacks.dim.disable",
        desc = "disable dimming",
        category = "snacks.dim",
        action = snacks.dim.disable,
    })
    PALETTE.add({
        id = "snacks.words.enable",
        desc = "enable word highlighting",
        category = "snacks.words",
        action = snacks.words.enable,
    })
    PALETTE.add({
        id = "snacks.words.disable",
        desc = "disable word highlighting",
        category = "snacks.words",
        action = snacks.words.disable,
    })
    PALETTE.add({
        id = "snacks.words.clear",
        desc = "clear word highlighting",
        category = "snacks.words",
        action = snacks.words.clear,
    })
    PALETTE.add({
        id = "snacks.buffer.delete",
        desc = "delete current buffer",
        category = "snacks.buffer",
        action = function()
            snacks.bufdelete()
        end,
    })
end

return plugin
