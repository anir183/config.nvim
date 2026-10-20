---@type 183.PluginSpec
---@diagnostic disable-next-line: missing-fields
local plugin = {}

plugin.repo = "https://github.com/ray-x/go.nvim"
plugin.cond = false
plugin.config = function()
    require("go").setup({
        lsp_cfg = false,
        dap_debug = true,
        go = "go",
        goimports = "gopls",
        gofmt = "gopls",
    })

    -- action palette
    local function add(id, desc, action)
        PALETTE.add({
            id = "go." .. id,
            desc = desc,
            category = "go",
            action = action,
        })
    end

    -- build and test
    add("build", "build the current Go package", vim.cmd.GoBuild)
    add("test", "run Go tests for the current package", vim.cmd.GoTest)
    add("test_func", "run the test function under the cursor", vim.cmd.GoTestFunc)
    add("generate", "run go generate for the current package", vim.cmd.GoGenerate)
    add("vet", "run go vet on the current package", vim.cmd.GoVet)

    -- formatting and imports
    add("format", "format Go source code", vim.cmd.GoFmt)
    add("imports", "organize and add Go imports", vim.cmd.GoImports)

    -- coverage
    add("coverage", "run Go tests with coverage", vim.cmd.GoCoverage)
    add("coverage_toggle", "toggle Go coverage display", vim.cmd.GoCoverageToggle)

    -- modules and dependencies
    add("mod_tidy", "tidy go.mod and go.sum dependencies", vim.cmd.GoModTidy)
    add("mod_vendor", "vendor Go module dependencies", vim.cmd.GoModVendor)
    add("get", "add or update a Go module dependency", vim.cmd.GoGet)

    -- navigation and documentation
    add("alternate", "switch between Go source and test files", vim.cmd.GoAlt)
    add("doc", "show documentation for the symbol under the cursor", vim.cmd.GoDoc)
    add("pkg_outline", "show symbols in the current Go package", vim.cmd.GoPkgOutline)

    -- code generation and refactoring
    add("if_err", "generate an error-handling block", vim.cmd.GoIfErr)
    add("fill_struct", "fill a Go struct literal", vim.cmd.GoFillStruct)
    add("impl", "generate methods for a Go interface implementation", vim.cmd.GoImpl)

    -- debugging
    add("debug", "start Go debugging", vim.cmd.GoDebug)
    add(
        "debug_config",
        "open the Go debugger launch configuration",
        vim.cmd.GoDebugConfig
    )

    -- toolchain
    add("install_binaries", "install Go.nvim helper tools", vim.cmd.GoInstallBinaries)
    add("update_binaries", "update Go.nvim helper tools", vim.cmd.GoUpdateBinaries)
end

return plugin
