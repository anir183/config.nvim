--[[ java and springboot toolset integration and setup ]]

---@module "lazy"

---@type LazySpec
local plugin = {}

plugin[1] = "nvim-java/nvim-java"
plugin.name = "java"
plugin.opts = {}
plugin.config = function(_, opts)
	require("java").setup(opts)
	vim.lsp.enable("jdtls")

	FUNCS.mmap("<leader>ta", {
		["workspace-build"] = vim.cmd.JavaBuildBuildWorkspace,
		["workspace-clean"] = vim.cmd.JavaBuildCleanWorkspace,
		["runner-run-main"] = vim.cmd.JavaRunnerRunMain,
		["runner-stop-main"] = vim.cmd.JavaRunnerStopMain,
		["runner-toggle-logs"] = vim.cmd.JavaRunnerToggleLogs,
		["dap-config"] = vim.cmd.JavaDapConfig,
		["test-run-curr-class"] = vim.cmd.JavaTestRunCurrentClass,
		["test-debug-curr-class"] = vim.cmd.JavaTestDebugCurrentClass,
		["test-run-curr-method"] = vim.cmd.JavaTestRunCurrentMethod,
		["test-debug-cur-method"] = vim.cmd.JavaTestDebugCurrentMethod,
		["test-run-all-tests"] = vim.cmd.JavaTestRunAllTests,
		["test-debug-all-tests"] = vim.cmd.JavaTestDebugAllTests,
		["test-view-last-report"] = vim.cmd.JavaTestViewLastReport,
		["profile-ui"] = vim.cmd.JavaProfile,
		["refactor-extract-var"] = vim.cmd.JavaRefactorExtractVariable,
		["refactor-extract-var-all-occurance"] = vim.cmd.JavaRefactorExtractVariableAllOccurrence,
		["refactor-extract-constant"] = vim.cmd.JavaRefactorExtractConstant,
		["refactor-extract-method"] = vim.cmd.JavaRefactorExtractMethod,
		["refactor-extract-field"] = vim.cmd.JavaRefactorExtractField,
		["settings-change-runtime"] = vim.cmd.JavaSettingsChangeRuntime,
	}, { desc = "[plugin.java] [J]ava tools [A]ctions" })
end

return plugin
