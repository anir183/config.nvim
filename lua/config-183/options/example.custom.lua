--[[
--
-- the custom.lua file i use as of 14-apr-2026
--
--]]

---@module "config-183.custom.statusline"
---@module "config-183.options.defaults"
---@module "config-183.utils.functions"
---@module "blink"
---@module "blink-cmp"

---@type DefaultOpts
local options = {}
options.ai = {}
options.lsps = {}
options.conform = {}
options.conform.ft_formatters = {}
options.lint = {}
options.lint.ft_linters = {}
options.dap = {}
options.dap.mason_dap = {}
options.extra_plugins = {}
options.plugin_overrides = {}
options.util_vars = {}
options.toolchain = {}
options.stline_otps = {}
options.stline_otps.components = {}

--[[ === ai tools === ]]
options.ai.copilot = "vtext"
options.ai.opencode = true

--[[ === toolchains === ]]
options.toolchain.flutter = FUNCS.in_distrobox("dev-flutter")
options.toolchain.gopher = FUNCS.in_distrobox("dev-golang")
options.toolchain.java = FUNCS.in_distrobox("dev-java")
options.toolchain.kotlin = FUNCS.in_distrobox("dev-java")
options.toolchain.rustacean = FUNCS.in_distrobox("dev-rust")
options.toolchain.typescript = FUNCS.in_distrobox("dev-nodejs")

--[[ === lsps === ]]
options.lsps.bashls = {
	filetypes = { "sh", "zsh" },
	settings = {
		filetypes = { "sh", "zsh" },
	},
}
options.lsps.marksman = {}
options.lsps.clangd = FUNCS.in_distrobox("dev-c") and {} or nil
options.lsps.kotlin_lsp = FUNCS.in_distrobox("dev-java") and {} or nil
if FUNCS.in_distrobox("dev-nodejs") then
	options.lsps.html = {}
	options.lsps.cssls = {}
	options.lsps.jsonls = {}
	options.lsps.emmet_language_server = {}
end

--[[ === formatters === ]]
options.conform.ft_formatters.lua = { "stylua" }
options.conform.ft_formatters.c = FUNCS.in_distrobox("dev-c")
		and { "clang-format" }
	or nil
options.conform.ft_formatters.rust = FUNCS.in_distrobox("dev-rust")
		and { "rustfmt", lsp_format = "fallback" }
	or nil
options.conform.ft_formatters.dart = { "dart_format" }
if FUNCS.in_distrobox("dev-nodejs") then
	options.conform.ft_formatters.html = { "prettier" }
	options.conform.ft_formatters.css = { "prettier" }
	options.conform.ft_formatters.typescript = { "prettier" }
	options.conform.ft_formatters.typescriptreact = { "prettier" }
	options.conform.ft_formatters.javascript = { "prettier" }
	options.conform.ft_formatters.javascriptreact = { "prettier" }
	options.conform.ft_formatters.json = { "prettier" }
	options.conform.ft_formatters.jsonc = { "prettier" }
else
	options.conform.ft_formatters.json = { "fixjson" }
	options.conform.ft_formatters.jsonc = { "fixjson" }
end

--[[ === linters === ]]
options.lint.ft_linters.json = { "jsonlint" }
options.lint.ft_linters.jsonc = { "jsonlint" }
if FUNCS.in_distrobox("dev-nodejs") then
	options.lint.ft_linters.typescript = { "eslint_d" }
	options.lint.ft_linters.javascript = { "eslint_d" }
	options.lint.ft_linters.typescriptreact = { "eslint_d" }
	options.lint.ft_linters.javascriptreact = { "eslint_d" }
end

--[[ === debuggers === ]]
options.dap.mason_dap.codelldb = (
	FUNCS.in_distrobox("dev-c") or FUNCS.in_distrobox("dev-rust")
)
		and {}
	or nil

--[[ === additional plugins === ]]
options.extra_plugins[1] = {
	"kawre/leetcode.nvim",
	name = "leetcode",
	build = ":TSUpdate html",
	dependencies = { "plenary", "nui", "treesitter" },
	cmd = "Leet",
	---@module "leetcode"
	---@type lc.UserConfig
	opts = {
		lang = "c",
		storage = {
			home = "/home/anir183/development/repos/leetcode/tries",
		},
	},
	config = function(_, opts)
		require("leetcode").setup(opts)

		FUNCS.mmap("n", "<leader>ta", {
			["exit"] = function()
				vim.cmd("Leet exit")
			end,
			["console"] = function()
				vim.cmd("Leet console")
			end,
			["info"] = function()
				vim.cmd("Leet info")
			end,
			["tabs"] = function()
				vim.cmd("Leet tabs")
			end,
			["yank"] = function()
				vim.cmd("Leet yank")
			end,
			["lang"] = function()
				vim.cmd("Leet lang")
			end,
			["run"] = function()
				vim.cmd("Leet run")
			end,
			["test"] = function()
				vim.cmd("Leet test")
			end,
			["submit"] = function()
				vim.cmd("Leet submit")
			end,
			["random"] = function()
				vim.cmd("Leet random")
			end,
			["random-opts"] = function()
				vim.ui.input({
					prompt = "status=<status> difficulty=<difficulty> tags=<tags>: ",
				}, function(args)
					if not args or args == "" then
						return
					end

					vim.cmd("Leet random " .. args)
				end)
			end,
			["daily"] = function()
				vim.cmd("Leet daily")
			end,
			["list"] = function()
				vim.cmd("Leet list")
			end,
			["open"] = function()
				vim.cmd("Leet open")
			end,
			["restore"] = function()
				vim.cmd("Leet restore")
			end,
			["last-submit"] = function()
				vim.cmd("Leet last_submit")
			end,
			["reset"] = function()
				vim.cmd("Leet reset")
			end,
			["inject"] = function()
				vim.cmd("Leet inject")
			end,
			["fold"] = function()
				vim.cmd("Leet fold")
			end,
			["description"] = function()
				vim.cmd("Leet desc")
			end,
			["desc-stats"] = function()
				vim.cmd("Leet desc stats")
			end,
			["cookie-update"] = function()
				vim.cmd("Leet cookie update")
			end,
			["cookie-delete"] = function()
				vim.cmd("Leet cookie delete")
			end,
			["update"] = function()
				vim.cmd("Leet cache update")
			end,
		}, "[plugin/leetcode]: leet code actions")
	end,
	keys = {
		{
			mode = "n",
			"<leader>lc",
			vim.cmd.Leet,
			desc = "[plugin/leetcode]: open [L]eet[C]ode ui",
		},
	},
}

--[[ === parser config === ]]
options.parsers = {
	ignore = {
		fts = {
			leetcode = "leetcode",
			license = "license",
		},
		langs = {
			leetcode = "leetcode",
			license = "license",
		},
	},
}

--[[ === additional filetypes === ]]
options.additional_fts = {
	{
		extension = {
			env = "dotenv",
		},
		filename = {
			[".env"] = "dotenv",
		},
		pattern = {
			["%.env%.[%w_.-]+"] = "dotenv",
			["%.env"] = "dotenv",
			["%.env%..+"] = "dotenv",
		},
	},
	{
		extension = {
			license = "",
		},
		filename = {
			["license"] = "license",
			["LICENSE"] = "license",
		},
	},
}

--[[ === run after config === ]]
options.stline_otps.components.distrobox = function()
	if FUNCS.in_distrobox() then
		return FUNCS.hl_fmt_str("Function", "  " .. vim.env.CONTAINER_ID .. " ")
	else
		return ""
	end
end
options.stline_otps.arrangement = {
	-- left
	"$logo",
	"$mode",
	"$distrobox",
	"$diagnostics",
	"  ",
	"%r",
	"%w",
	"%h",
	"%m",

	"%=", -- break

	-- right
	"$gitinfo",
	" ",
	"$filename",
	" ",
	"$indent",
	" ",
	"$position",
}

--[[ utility variables ]]
options.util_vars.lsp_indexing_hack = { "lua_ls" }

return options
