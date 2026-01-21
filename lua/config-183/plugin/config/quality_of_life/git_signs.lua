--[[
--
-- nvim/lua/config-183/plugin/config/quality_of_life/git_signs.lua
--
-- git information and actions
--
--]]

---@type LazySpec
local plugin = {}

plugin[1] = "lewis6991/gitsigns.nvim"
plugin.name = "git-signs"
plugin.lazy = false
plugin.opts = {
	signcolumn = false,
}
plugin.config = function(_, opts)
	require("gitsigns").setup(opts)

	--[[ add git information to statusline ]]
	LOG.info("adding git information to statusline")
	STLINE.components.gitinfo = function()
		local git_info = vim.b.gitsigns_status_dict
		if not git_info or git_info.head == "" then
			return ""
		end

		local head = git_info.head
		local added = git_info.added and (" +" .. git_info.added) or ""
		local changed = git_info.changed and (" ~" .. git_info.changed)
			or ""
		local removed = git_info.removed and (" -" .. git_info.removed)
			or ""
		if git_info.added == 0 then
			added = ""
		end
		if git_info.changed == 0 then
			changed = ""
		end
		if git_info.removed == 0 then
			removed = ""
		end

		local fmt_str = "%%#%s#%s%%*"
		return table.concat({
			" ",
			fmt_str:format("Exception", head),
			fmt_str:format("DiagnosticSignOk", added),
			fmt_str:format("DiagnosticSignWarn", changed),
			fmt_str:format("DiagnosticSignError", removed),
			" ",
		})
	end
	STLINE.arrangement = {
		-- left
		"$mode",
		"$diagnostics",
		" ",
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
	STLINE.set_arrangment()

	FUNCS.mmap(
		"n",
		"<leader>ga",
		{
			["toggle-signs"] = require("gitsigns").toggle_signs,
			["toggle-number-hl"] = require("gitsigns").toggle_numhl,
			["toggle-line-hl"] = require("gitsigns").toggle_linehl,
			["toggle-word-diff"] = require("gitsigns").toggle_word_diff,
			["toggle-blame-vtext"] = require("gitsigns").toggle_current_line_blame,
			["toggle-stage-hunk"] = require("gitsigns").stage_hunk,
			["stage-buffer"] = require("gitsigns").stage_buffer,
			["reset-buffer"] = require("gitsigns").reset_buffer,
			["reset-buffer-index"] = require("gitsigns").reset_buffer_index,
			["blame-file"] = require("gitsigns").blame,
			["blame-line"] = require("gitsigns").blame_line,
			["diff-file"] = require("gitsigns").diffthis,
			["change-base"] = function()
				vim.ui.input({
					prompt = "new base: ",
				}, function(input)
					if not input then
						require("gitsigns").change_base()
						return
					end

					require("gitsigns").change_base(input)
				end)
			end,
			["preview-hunk"] = require("gitsigns").preview_hunk,
			["preview-hunk-inline"] = require("gitsigns").preview_hunk_inline,
			["set-quickfix-list"] = require("gitsigns").setqflist,
			["show-commit"] = require("gitsigns").show_commit,
			["show-revision"] = require("gitsigns").show,
			["refresh"] = require("gitsigns").refresh,
		},
		"[plugin/git-signs]: choose from [G]it-sign [A]ctions"
	)
end

return plugin
