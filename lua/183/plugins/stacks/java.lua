---@type 183.PluginSpec
---@diagnostic disable-next-line: missing-fields
local plugin = {}

plugin.repo = "https://github.com/nvim-java/nvim-java"

plugin.config = function()
    local registry = require("mason-registry")

    ---@param name string
    ---@return string?
    local function package_path(name)
        local ok, package = pcall(registry.get_package, name)

        if not ok or not package:is_installed() then
            return nil
        end

        return package:get_install_path()
    end

    ---@return string?
    local function get_java_home()
        local java_home = vim.env.JAVA_HOME

        if java_home and java_home ~= "" then
            if
                vim.fn.executable(java_home .. "/bin/java") == 1
            then
                return java_home
            end
        end

        if vim.fn.executable("mise") == 1 then
            local result = vim.system(
                { "mise", "where", "java" },
                { text = true }
            ):wait()

            if result.code == 0 then
                java_home = vim.trim(result.stdout or "")

                if
                    java_home ~= ""
                    and vim.fn.executable(
                            java_home .. "/bin/java"
                        )
                        == 1
                then
                    return java_home
                end
            end
        end

        vim.notify(
            "no usable JDK found in JAVA_HOME or mise; disabling nvim-java",
            vim.log.levels.ERROR
        )

        return nil
    end

    local java_home = get_java_home()
    if not java_home then
        return
    end

    local jdtls_path = package_path("jdtls")
    if not jdtls_path then
        vim.notify(
            "JDTLS is required by nvim-java; Java integration disabled",
            vim.log.levels.ERROR
        )
        return
    end

    local java_debug_path = package_path("java-debug-adapter")
    local java_test_path = package_path("java-test")
    local spring_boot_path =
        package_path("vscode-spring-boot-tools")

    local java = require("java")
    java.setup({
        checks = {
            nvim_version = true,
            nvim_jdtls_conflict = true,
        },

        jdtls = {
            path = jdtls_path,
            auto_install = false,
        },

        java_debug_adapter = {
            enable = java_debug_path ~= nil,
            path = FUNCS.join_path(java_debug_path, "extension"),
            auto_install = false,
        },

        java_test = {
            enable = java_test_path ~= nil,
            path = FUNCS.join_path(java_test_path, "extension"),
            auto_install = false,
        },

        lombok = {
            enable = true,
            auto_install = true,
        },

        spring_boot_tools = {
            enable = spring_boot_path ~= nil,
            path = FUNCS.join_path(
                spring_boot_path,
                "extension"
            ),
            auto_install = false,
        },

        jdk = {
            path = java_home,
            auto_install = false,
        },
    })

    -- action palette
    local function add(id, desc, action)
        PALETTE.add({
            id = "java." .. id,
            desc = desc,
            category = "java",
            action = action,
        })
    end

    -- build
    add("build", "build the Java workspace", function()
        java.build.build_workspace()
    end)

    add("clean", "clean the Java workspace", function()
        java.build.clean_workspace()
    end)

    -- runner
    add("run_main", "run a Java main class", function()
        java.runner.built_in.run_app({})
    end)

    add(
        "stop_main",
        "stop the running Java application",
        function()
            java.runner.built_in.stop_app()
        end
    )

    add("toggle_logs", "toggle Java runner logs", function()
        java.runner.built_in.toggle_logs()
    end)

    -- debugging
    add("dap_config", "configure Java debugging", function()
        java.dap.config_dap()
    end)

    -- tests
    add(
        "test_class",
        "run tests in the current class",
        function()
            java.test.run_current_class()
        end
    )

    add(
        "debug_class",
        "debug tests in the current class",
        function()
            java.test.debug_current_class()
        end
    )

    add("test_method", "run the current test method", function()
        java.test.run_current_method()
    end)

    add(
        "debug_method",
        "debug the current test method",
        function()
            java.test.debug_current_method()
        end
    )

    add("test_all", "run all Java tests", function()
        java.test.run_all_tests()
    end)

    add("debug_all", "debug all Java tests", function()
        java.test.debug_all_tests()
    end)

    add(
        "test_report",
        "view the last Java test report",
        function()
            java.test.view_last_report()
        end
    )

    -- profiles
    add("profile", "open the Java profiles UI", function()
        java.profile.ui()
    end)

    -- refactoring
    add("extract_variable", "extract a variable", function()
        java.refactor.extract_variable()
    end)

    add(
        "extract_variable_all_occurrences",
        "extract a variable at all occurrences",
        function()
            java.refactor.extract_variable_all_occurrence()
        end
    )

    add("extract_constant", "extract a constant", function()
        java.refactor.extract_constant()
    end)

    add("extract_method", "extract a method", function()
        java.refactor.extract_method()
    end)

    add("extract_field", "extract a field", function()
        java.refactor.extract_field()
    end)

    -- settings
    add("change_runtime", "change the Java runtime", function()
        java.settings.change_runtime()
    end)
end

return plugin
