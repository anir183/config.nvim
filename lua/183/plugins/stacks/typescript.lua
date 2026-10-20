---@type 183.PluginSpec
---@diagnostic disable-next-line: missing-fields

local plugin = {}

plugin.repo = "https://github.com/pmizio/typescript-tools.nvim"
plugin.config = function()
    require("typescript-tools").setup({
        settings = {
            separate_diagnostic_server = true,
            publish_diagnostic_on = "insert_leave",
            tsserver_max_memory = "auto",
        },
    })

    -- action palette
    local function add(id, desc, action)
        PALETTE.add({
            id = "typescript." .. id,
            desc = desc,
            category = "typescript",
            action = action,
        })
    end

    -- imports
    add(
        "organize_imports",
        "sort imports and remove unused imports",
        vim.cmd.TSToolsOrganizeImports
    )
    add(
        "sort_imports",
        "sort imports without removing unused imports",
        vim.cmd.TSToolsSortImports
    )
    add(
        "remove_unused_imports",
        "remove imports that are not used",
        vim.cmd.TSToolsRemoveUnusedImports
    )
    add(
        "add_missing_imports",
        "add imports for unresolved symbols",
        vim.cmd.TSToolsAddMissingImports
    )

    -- code fixes
    add(
        "remove_unused",
        "remove unused statements and declarations",
        vim.cmd.TSToolsRemoveUnused
    )
    add("fix_all", "apply all available TypeScript fixes", vim.cmd.TSToolsFixAll)

    -- navigation
    add(
        "go_to_source_definition",
        "navigate to the source definition",
        vim.cmd.TSToolsGoToSourceDefinition
    )
    add(
        "file_references",
        "find files referencing the current file",
        vim.cmd.TSToolsFileReferences
    )

    -- file operations
    add(
        "rename_file",
        "rename the current file and update its references",
        vim.cmd.TSToolsRenameFile
    )
end

return plugin
