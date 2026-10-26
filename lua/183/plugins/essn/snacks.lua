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
    nmap("<leader>ff", function()
        snacks.picker.files({
            ignored = true,
            hidden = true,
        })
    end, {
        desc = "[plugins.snacks] [f]ind files [a]ll inclusive",
    })
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
    nmap("<leader>fr", snacks.picker.recent, {
        desc = "[plugins.snacks] [f]ind [r]ecently visited files",
    })

    -- grep pickers
    nmap(
        "<leader>gg",
        snacks.picker.grep,
        { desc = "[plugins.snacks] [g]lobal [g]rep" }
    )
    nmap("<leader>GG", function()
        snacks.picker.grep({
            cwd = vim.fn.expand("%:h"),
        })
    end, {
        desc = "[plugins.snacks] [G]lobal [G]rep current directory",
    })
    nmap("<leader>fr", snacks.picker.recent, {
        desc = "[plugins.snacks] [f]ind [r]ecently visited files",
    })

    -- buffers
    nmap("<leader>fb", snacks.picker.buffers, {
        desc = "[plugins.snacks] [f]ind open [b]uffers",
    })

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

    -- lsp
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
    nmap(
        "<leader>RN",
        snacks.rename.rename_file,
        { desc = "[plugins.snacks] [R]e[N]ame file" }
    )

    -- terminal keymaps
    nmap(
        "<leader>tt",
        snacks.terminal.toggle,
        { desc = "[plugins.snacks] [t]oggle [t]erminal window" }
    )
    nmap(
        "<leader>TT",
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

    -- action palette
    local function add(id, category, desc, action)
        PALETTE.add({
            id = "snacks." .. id,
            desc = desc,
            category = "snacks." .. category,
            action = action,
        })
    end

    -- picker: general
    add(
        "picker.smart",
        "picker",
        "find files and buffers",
        snacks.picker.smart
    )
    add(
        "picker.buffers",
        "picker",
        "find open buffers",
        snacks.picker.buffers
    )
    add(
        "picker.lines",
        "picker",
        "search current buffer lines",
        snacks.picker.lines
    )
    add(
        "picker.grep_buffers",
        "picker",
        "grep open buffers",
        snacks.picker.grep_buffers
    )
    add(
        "picker.keymaps",
        "picker",
        "find available keymaps",
        snacks.picker.keymaps
    )
    add(
        "picker.help",
        "picker",
        "search help pages",
        snacks.picker.help
    )
    add(
        "picker.qflist",
        "picker",
        "search quick fix list",
        snacks.picker.qflist
    )
    add(
        "picker.loclist",
        "picker",
        "search location list",
        snacks.picker.loclist
    )
    add(
        "picker.git_files",
        "picker",
        "find git-tracked files",
        snacks.picker.git_files
    )
    add(
        "picker.projects",
        "picker",
        "find projects",
        snacks.picker.projects
    )
    add(
        "picker.resume",
        "picker",
        "resume last picker",
        snacks.picker.resume
    )
    add(
        "picker.recent",
        "picker",
        "find recently visited files",
        snacks.picker.recent
    )

    -- picker: search and navigation
    add(
        "picker.registers",
        "picker",
        "search registers",
        snacks.picker.registers
    )
    add(
        "picker.autocmds",
        "picker",
        "search autocommands",
        snacks.picker.autocmds
    )
    add(
        "picker.commands",
        "picker",
        "search available commands",
        snacks.picker.commands
    )
    add(
        "picker.diagnostics",
        "picker",
        "search all diagnostics",
        snacks.picker.diagnostics
    )
    add(
        "picker.diagnostics_buffer",
        "picker",
        "search buffer diagnostics",
        snacks.picker.diagnostics_buffer
    )
    add(
        "picker.highlights",
        "picker",
        "inspect highlight groups",
        snacks.picker.highlights
    )
    add(
        "picker.undo",
        "picker",
        "browse undo history",
        snacks.picker.undo
    )
    add(
        "picker.man",
        "picker",
        "search man pages",
        snacks.picker.man
    )
    add(
        "picker.jumps",
        "picker",
        "browse jump history",
        snacks.picker.jumps
    )
    add(
        "picker.marks",
        "picker",
        "browse marks",
        snacks.picker.marks
    )
    add(
        "picker.icons",
        "picker",
        "browse icons",
        snacks.picker.icons
    )
    add(
        "picker.colorschemes",
        "picker",
        "browse colorschemes",
        snacks.picker.colorschemes
    )

    -- picker: todo comments
    add(
        "picker.todocomments",
        "todo",
        "browse special todo comment",
        function()
            ---@diagnostic disable-next-line: undefined-field
            snacks.picker.todo_comments()
        end
    )

    add(
        "picker.todoselect",
        "todo",
        "select and browse particular todo comments",
        function()
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
        end
    )

    -- git
    add(
        "git.branches",
        "git",
        "browse git branches",
        snacks.picker.git_branches
    )
    add(
        "git.log",
        "git",
        "browse git history",
        snacks.picker.git_log
    )
    add(
        "git.log_line",
        "git",
        "browse history for current line",
        snacks.picker.git_log_line
    )
    add(
        "git.status",
        "git",
        "browse git status",
        snacks.picker.git_status
    )
    add(
        "git.stash",
        "git",
        "browse git stashes",
        snacks.picker.git_stash
    )
    add(
        "git.diff",
        "git",
        "browse git diffs",
        snacks.picker.git_diff
    )
    add(
        "git.log_file",
        "git",
        "browse history for current file",
        snacks.picker.git_log_file
    )

    add(
        "git.blame_line",
        "git",
        "show git blame for current line",
        function()
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
        end
    )

    add(
        "git.browse",
        "git",
        "open current file in git remote",
        snacks.gitbrowse.open
    )
    add(
        "git.lazygit",
        "git",
        "open lazygit",
        snacks.lazygit.open
    )

    -- github
    add(
        "github.open_issues",
        "github",
        "browse open GitHub issues",
        snacks.picker.gh_issue
    )
    add(
        "github.all_issues",
        "github",
        "browse all GitHub issues",
        function()
            snacks.picker.gh_issue({ state = "all" })
        end
    )
    add(
        "github.open_prs",
        "github",
        "browse open GitHub pull requests",
        snacks.picker.gh_pr
    )
    add(
        "github.all_prs",
        "github",
        "browse all GitHub pull requests",
        function()
            snacks.picker.gh_pr({ state = "all" })
        end
    )

    -- lsp
    add(
        "lsp.symbols",
        "lsp",
        "list LSP symbols",
        snacks.picker.lsp_symbols
    )
    add(
        "lsp.workspace_symbols",
        "lsp",
        "list workspace-wide LSP symbols",
        snacks.picker.lsp_workspace_symbols
    )

    -- terminal
    add(
        "terminal.toggle",
        "terminal",
        "toggle terminal",
        snacks.terminal.toggle
    )
    add(
        "terminal.open",
        "terminal",
        "open new terminal",
        snacks.terminal.open
    )

    -- scratch buffers
    add(
        "scratch.toggle",
        "scratch",
        "toggle scratch buffer",
        function()
            snacks.scratch()
        end
    )
    add(
        "scratch.select",
        "scratch",
        "select scratch buffer",
        snacks.scratch.select
    )

    -- ui and editing
    add(
        "rename.file",
        "rename",
        "rename current file",
        snacks.rename.rename_file
    )
    add("zen.toggle", "zen", "toggle zen mode", function()
        snacks.zen()
    end)
    add("zen.zoom", "zen", "toggle window zoom", snacks.zen.zoom)
    add("dim.enable", "dim", "enable dimming", snacks.dim.enable)
    add(
        "dim.disable",
        "dim",
        "disable dimming",
        snacks.dim.disable
    )
    add(
        "words.enable",
        "words",
        "enable word highlighting",
        snacks.words.enable
    )
    add(
        "words.disable",
        "words",
        "disable word highlighting",
        snacks.words.disable
    )
    add(
        "words.clear",
        "words",
        "clear word highlighting",
        snacks.words.clear
    )
    add(
        "buffer.delete",
        "buffer",
        "delete current buffer",
        function()
            snacks.bufdelete()
        end
    )
end

return plugin
