--[[ debug adapter protocol ]]

---@module "lazy"

---@type LazySpec
local plugin = {}

plugin[1] = "mfussenegger/nvim-dap"
plugin.name = "dap"
plugin.lazy = false
plugin.config = function()
	vim.cmd("hi DapStoppedCustom guifg=#a6e3a1")
	vim.cmd("hi DapBreakpointCustom guifg=#f38ba8")
	vim.fn.sign_define("DapStopped", {
		text = "⌦ ",
		texthl = "DapStoppedCustom",
		linehl = "",
		numhl = "",
	})
	vim.fn.sign_define("DapBreakpoint", {
		text = "ඞ ",
		texthl = "DapBreakpointCustom",
		linehl = "",
		numhl = "",
	})

	_G.FUNCS.mmap("<leader>aa", {
		["set-breakpoints"] = function()
			require("dap").set_breakpoint()
		end,
		["toggle-breakpoints"] = function()
			require("dap").toggle_breakpoint()
		end,
		["set-conditional-breakpoints"] = function()
			vim.ui.input({
				prompt = "condition: ",
			}, function(condition)
				condition = condition == "" and nil or condition

				vim.ui.input({
					prompt = "condition: ",
				}, function(hit_condition)
					hit_condition = hit_condition == "" and nil or hit_condition

					vim.ui.input({
						prompt = "condition: ",
					}, function(log_message)
						log_message = log_message == "" and nil or log_message

						require("dap").set_breakpoint(
							condition,
							hit_condition,
							log_message
						)
					end)
				end)
			end)
		end,
		["toggle-conditional-breakpoints"] = function()
			vim.ui.input({
				prompt = "condition: ",
			}, function(condition)
				condition = condition == "" and nil or condition

				vim.ui.input({
					prompt = "condition: ",
				}, function(hit_condition)
					hit_condition = hit_condition == "" and nil or hit_condition

					vim.ui.input({
						prompt = "condition: ",
					}, function(log_message)
						log_message = log_message == "" and nil or log_message

						require("dap").toggle_breakpoint(
							condition,
							hit_condition,
							log_message
						)
					end)
				end)
			end)
		end,
		["re-run-last"] = function()
			require("dap").run_last()
		end,
		["continue"] = function()
			require("dap").continue()
		end,
		["restart"] = function()
			require("dap").restart()
		end,
		["terminate"] = function()
			require("dap").terminate()
		end,
		["list-breakpoints"] = function()
			require("dap").list_breakpoints()
		end,
		["step-over"] = function()
			require("dap").step_over()
		end,
		["step-into"] = function()
			require("dap").step_into()
		end,
		["step-out"] = function()
			require("dap").step_out()
		end,
		["step-back"] = function()
			require("dap").step_back()
		end,
		["pause"] = function()
			require("dap").pause()
		end,
		["reverse-continue"] = function()
			require("dap").reverse_continue()
		end,
		["up"] = function()
			require("dap").up()
		end,
		["down"] = function()
			require("dap").down()
		end,
		["goto"] = function()
			vim.ui.input({
				prompt = "line number: ",
			}, function(line_number)
				if not line_number or not _G.FUNCS.is_num(line_number) then
					return
				end

				require("dap").goto_(tonumber(line_number))
			end)
		end,
		["focus-frame"] = function()
			require("dap").focus_frame()
		end,
		["restart-frame"] = function()
			require("dap").restart_frame()
		end,
		["run-to-cursor"] = function()
			require("dap").run_to_cursor()
		end,
		["repl-open"] = function()
			require("dap").repl.open()
		end,
		["repl-toggle"] = function()
			require("dap").repl.toggle()
		end,
		["repl-close"] = function()
			require("dap").repl.close()
		end,
		["repl-execute"] = function()
			vim.ui.input({
				prompt = "execute: ",
			}, function(execute)
				if not execute or execute == "" then
					return
				end

				require("dap").repl.execute(execute)
			end)
		end,
		["close"] = function()
			require("dap").close()
		end,
		["set-log-level"] = function()
			vim.ui.select({
				"TRACE",
				"DEBUG",
				"INFO",
				"WARN",
				"ERROR",
			}, {
				prompt = "log level: ",
			}, function(log_level)
				if not log_level then
					return
				end

				require("dap").set_log_level(log_level)
			end)
		end,
		["session"] = function()
			vim.print(require("dap").session())
		end,
		["sessions"] = function()
			vim.print(require("dap").sessions())
		end,
		["status"] = function()
			vim.notify(require("dap").status(), vim.log.levels.INFO)
		end,
		["disconnect"] = function()
			require("dap").disconnect()
		end,
	}, { desc = "[plugin.dap] d[A]p [A]ctions" })
end
plugin.keys = {
	{
		mode = "n",
		"<leader>ap",
		function()
			require("dap").continue()
		end,
		desc = "[plugin.dap] run a d[A][P] debugger or continue execution",
	},
	{
		mode = "n",
		"<leader>AP",
		function()
			require("dap").run_last()
		end,
		desc = "[plugin.dap] re-run last d[A][P] debugger",
	},
	{
		mode = "n",
		"<leader>am",
		function()
			require("dap").toggle_breakpoint()
		end,
		desc = "[plugin.dap] toggle [A][M]ogus",
	},
	{
		mode = "n",
		"<leader>bp",
		function()
			require("dap").toggle_breakpoint()
		end,
		desc = "[plugin.dap] toggle [B]reak[P]oint",
	},
	{
		mode = "n",
		"<leader>BP",
		function()
			vim.ui.input({
				prompt = "condition: ",
			}, function(condition)
				condition = condition == "" and nil or condition

				vim.ui.input({
					prompt = "condition: ",
				}, function(hit_condition)
					hit_condition = hit_condition == "" and nil or hit_condition

					vim.ui.input({
						prompt = "condition: ",
					}, function(log_message)
						log_message = log_message == "" and nil or log_message

						require("dap").set_breakpoint(
							condition,
							hit_condition,
							log_message
						)
					end)
				end)
			end)
		end,
		desc = "[plugin.dap] set or overwrite conditional [B]reak[P]oint",
	},
	{
		mode = "n",
		"<leader>bc",
		function()
			require("dap").clear_breakpoints()
		end,
		desc = "[plugin.dap] [B]eakpoints [C]lear",
	},
	{
		mode = "n",
		"]s",
		function()
			require("dap").step_over()
		end,
		desc = "[plugin.dap] [S]tep [O]ver",
	},
	{
		mode = "n",
		"[s",
		function()
			require("dap").step_back()
		end,
		desc = "[plugin.dap] [S]tep ba[C]k",
	},
	{
		mode = "n",
		"]S",
		function()
			require("dap").step_into()
		end,
		desc = "[plugin.dap] [S]tep [I]nto",
	},
	{
		mode = "n",
		"[S",
		function()
			require("dap").step_out()
		end,
		desc = "[plugin.dap] [S]tep o[U]t",
	},
	{
		mode = "n",
		"<leader>rt",
		function()
			require("dap").repl.toggle()
		end,
		desc = "[plugin.dap] [R]epl [T]oggle",
	},
}

return plugin
