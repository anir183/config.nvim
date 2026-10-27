---@type 183.PluginSpec
---@diagnostic disable-next-line: missing-fields
local plugin = {}

plugin.repo = {
    src = "https://github.com/saecki/crates.nvim",
    version = "stable",
}
plugin.config = function()
    ---@type crates.UserConfig
    local opts = {
        lsp = {
            enabled = true,
            actions = true,
            completion = true,
            hover = true,
        },
        completion = {
            crates = {
                enabled = true,
                max_results = 20,
                min_chars = 1,
            },
            blink = {
                use_custom_kind = true,
                kind_text = {
                    version = "Version",
                    feature = "Feature",
                },
                kind_highlight = {
                    version = "BlinkCmpKindVersion",
                    feature = "BlinkCmpKindFeature",
                },
                kind_icon = {
                    version = " ",
                    feature = " ",
                },
            },
        },
    }

    local crates = require("crates")
    crates.setup(opts)

    ---@param id string
    ---@param desc string
    ---@param action fun()
    local function add(id, desc, action)
        PALETTE.add({
            id = "crates." .. id,
            desc = desc,
            category = "rust.crates",
            action = action,
        })
    end

    --- defer an action to let the palette ui close first.
    ---@param action fun()
    local function defer(action)
        return function()
            vim.defer_fn(action, 50)
        end
    end

    -- ui and metadata.
    add("hide-ui", "Hide crate information", crates.hide)
    add("show-ui", "Show crate information", crates.show)
    add("toggle-ui", "Toggle crate information", crates.toggle)
    add("update-data", "Update crate metadata", crates.update)
    add("reload-data", "Reload crate metadata", crates.reload)

    -- version management.
    add(
        "upgrade-crate",
        "Upgrade crate under cursor",
        defer(crates.upgrade_crate)
    )
    add(
        "upgrade-all",
        "Upgrade all crates",
        crates.upgrade_all_crates
    )
    add(
        "update-crate",
        "Update crate under cursor",
        defer(crates.update_crate)
    )
    add(
        "update-all",
        "Update all crates",
        crates.update_all_crates
    )

    -- cargo.toml editing.
    add(
        "expand-inline-table",
        "Expand crate into inline table",
        crates.expand_plain_crate_to_inline_table
    )
    add(
        "extract-table",
        "Extract crate into a table",
        crates.extract_crate_into_table
    )
    add(
        "use-git-source",
        "Use Git source for crate",
        crates.use_git_source
    )

    -- external resources.
    add(
        "open-homepage",
        "Open crate homepage",
        defer(crates.open_homepage)
    )
    add(
        "open-repository",
        "Open crate repository",
        defer(crates.open_repository)
    )
    add(
        "open-documentation",
        "Open crate documentation",
        defer(crates.open_documentation)
    )
    add(
        "open-crates-io",
        "Open crate on crates.io",
        defer(crates.open_crates_io)
    )
    add(
        "open-lib-rs",
        "Open crate on lib.rs",
        defer(crates.open_lib_rs)
    )

    -- information popups.
    add(
        "show-popup",
        "Show crate popup",
        defer(function()
            crates.show_popup()
            crates.focus_popup()
        end)
    )
    add(
        "show-crate-popup",
        "Show crate details",
        defer(function()
            crates.show_crate_popup()
            crates.focus_popup()
        end)
    )
    add(
        "show-versions-popup",
        "Show available versions",
        defer(function()
            crates.show_versions_popup()
            crates.focus_popup()
        end)
    )
    add(
        "show-features-popup",
        "Show crate features",
        defer(function()
            crates.show_features_popup()
            crates.focus_popup()
        end)
    )
    add(
        "show-dependencies-popup",
        "Show crate dependencies",
        defer(function()
            crates.show_dependencies_popup()
            crates.focus_popup()
        end)
    )
end

return plugin
