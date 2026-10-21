---@type 183.PluginSpec
---@diagnostic disable-next-line: missing-fields
local plugin = {}

plugin.repo = {
    src = "https://github.com/kawre/leetcode.nvim",
}

plugin.config = function()
    require("leetcode").setup({
        lang = "c",
        picker = {
            provider = "snacks-picker",
        },
        storage = {
            home = QOPTS.get().leetpath,
            cache = vim.fn.stdpath("cache") .. "/leetcode",
        },
    })

    -- action palette
    local function add(id, desc, action)
        PALETTE.add({
            id = "leetcode." .. id,
            desc = desc,
            category = "leetcode",
            action = action,
        })
    end

    add("open", "open leetcode dashboard", function()
        vim.cmd.Leet()
    end)

    add("exit", "exit leetcode", function()
        vim.cmd("Leet exit")
    end)

    add("console", "open leetcode console", function()
        vim.cmd("Leet console")
    end)

    add("info", "show current question info", function()
        vim.cmd("Leet info")
    end)

    add("tabs", "switch question tabs", function()
        vim.cmd("Leet tabs")
    end)

    add("yank", "yank solution code", function()
        vim.cmd("Leet yank")
    end)

    add("lang", "change solution language", function()
        vim.cmd("Leet lang")
    end)

    add("run", "run solution", function()
        vim.cmd("Leet run")
    end)

    add("test", "test solution", function()
        vim.cmd("Leet test")
    end)

    add("submit", "submit solution", function()
        vim.cmd("Leet submit")
    end)

    add("random", "open random question", function()
        vim.cmd("Leet random")
    end)

    add(
        "random-options",
        "open random question with filters",
        function()
            vim.ui.input({
                prompt = "status=<status> difficulty=<difficulty> tags=<tags>: ",
            }, function(args)
                if not args or args == "" then
                    return
                end

                vim.cmd("Leet random " .. args)
            end)
        end
    )

    add("daily", "open daily question", function()
        vim.cmd("Leet daily")
    end)

    add("list", "browse leetcode problems", function()
        vim.cmd("Leet list")
    end)

    add("browser", "open question in browser", function()
        vim.cmd("Leet open")
    end)

    add("restore", "restore question layout", function()
        vim.cmd("Leet restore")
    end)

    add("last-submit", "restore last submitted code", function()
        vim.cmd("Leet last_submit")
    end)

    add("reset", "reset solution", function()
        vim.cmd("Leet reset")
    end)

    add("inject", "re-inject solution boilerplate", function()
        vim.cmd("Leet inject")
    end)

    add("fold", "fold solution imports", function()
        vim.cmd("Leet fold")
    end)

    add("description", "toggle question description", function()
        vim.cmd("Leet desc")
    end)

    add(
        "description-stats",
        "toggle description stats",
        function()
            vim.cmd("Leet desc stats")
        end
    )

    add("cookie-update", "update leetcode cookie", function()
        vim.cmd("Leet cookie update")
    end)

    add("cookie-delete", "delete leetcode cookie", function()
        vim.cmd("Leet cookie delete")
    end)

    add("cache-update", "update problem cache", function()
        vim.cmd("Leet cache update")
    end)
end

return plugin
