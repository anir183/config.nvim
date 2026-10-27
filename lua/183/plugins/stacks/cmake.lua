---@type 183.PluginSpec
---@diagnostic disable-next-line: missing-fields
local plugin = {}

plugin.repo = "https://github.com/Civitasv/cmake-tools.nvim"
plugin.config = function()
    require("cmake-tools").setup({
        cmake_use_preset = true,
        cmake_regenerate_on_save = true,

        cmake_generate_options = {
            "-DCMAKE_EXPORT_COMPILE_COMMANDS=1",
        },

        cmake_compile_commands_options = {
            action = "soft_link",
            target = function()
                return vim.fn.getcwd()
            end,
        },

        cmake_executor = {
            name = "terminal",
        },

        cmake_runner = {
            name = "terminal",
        },

        cmake_dap_configuration = {
            name = "CMake debug",
            type = "codelldb",
            request = "launch",
            stopOnEntry = false,
            runInTerminal = true,
            console = "integratedTerminal",
        },
    })

    -- action palette
    local function add(id, desc, action)
        PALETTE.add({
            id = "cmake." .. id,
            desc = desc,
            category = "cmake",
            action = action,
        })
    end

    -- configure and build
    add(
        "generate",
        "configure the project and generate the build system",
        vim.cmd.CMakeGenerate
    )
    add(
        "generate_clean",
        "clean and regenerate the build system",
        function()
            vim.cmd("CMakeGenerate!")
        end
    )
    add(
        "build",
        "build the selected CMake target",
        vim.cmd.CMakeBuild
    )
    add(
        "build_clean",
        "clean and rebuild the selected CMake target",
        function()
            vim.cmd("CMakeBuild!")
        end
    )
    add(
        "build_file",
        "build targets related to the current file",
        vim.cmd.CMakeBuildCurrentFile
    )
    add(
        "clean",
        "clean CMake targets and intermediate files",
        vim.cmd.CMakeClean
    )
    add("install", "install CMake targets", vim.cmd.CMakeInstall)

    -- run and debug
    add(
        "run",
        "run the selected executable target",
        vim.cmd.CMakeRun
    )
    add(
        "run_file",
        "run targets related to the current file",
        vim.cmd.CMakeRunCurrentFile
    )
    add(
        "debug",
        "debug the selected executable target",
        vim.cmd.CMakeDebug
    )
    add(
        "debug_file",
        "debug targets related to the current file",
        vim.cmd.CMakeDebugCurrentFile
    )
    add(
        "launch_args",
        "set command-line arguments for the selected target",
        vim.cmd.CMakeLaunchArgs
    )

    -- tests
    add("test", "run CTest tests", vim.cmd.CMakeRunTest)

    -- target selection
    add(
        "select_build_target",
        "select the CMake build target",
        vim.cmd.CMakeSelectBuildTarget
    )
    add(
        "select_launch_target",
        "select the executable launch target",
        vim.cmd.CMakeSelectLaunchTarget
    )
    add(
        "quick_build",
        "build a target without changing the selected target",
        vim.cmd.CMakeQuickBuild
    )
    add(
        "quick_run",
        "run a target without changing the selected target",
        vim.cmd.CMakeQuickRun
    )
    add(
        "quick_debug",
        "debug a target without changing the selected target",
        vim.cmd.CMakeQuickDebug
    )
    add(
        "target_files",
        "show files associated with a CMake target",
        vim.cmd.CMakeShowTargetFiles
    )

    -- build configuration
    add(
        "select_build_type",
        "select the CMake build type",
        vim.cmd.CMakeSelectBuildType
    )
    add(
        "select_kit",
        "select a CMake kit",
        vim.cmd.CMakeSelectKit
    )
    add(
        "select_configure_preset",
        "select a CMake configure preset",
        vim.cmd.CMakeSelectConfigurePreset
    )
    add(
        "select_build_preset",
        "select a CMake build preset",
        vim.cmd.CMakeSelectBuildPreset
    )
    add(
        "select_test_preset",
        "select a CMake test preset",
        vim.cmd.CMakeSelectTestPreset
    )
    add(
        "select_source_dir",
        "select the directory containing CMakeLists.txt",
        vim.cmd.CMakeSelectCwd
    )
    add(
        "select_build_dir",
        "select the CMake build directory",
        vim.cmd.CMakeSelectBuildDir
    )

    -- inspection and process control
    add(
        "open_cache",
        "open CMakeCache.txt",
        vim.cmd.CMakeOpenCache
    )
    add(
        "open_executor",
        "open the CMake executor window",
        vim.cmd.CMakeOpenExecutor
    )
    add(
        "open_runner",
        "open the CMake runner window",
        vim.cmd.CMakeOpenRunner
    )
    add(
        "close_executor",
        "close the CMake executor window",
        vim.cmd.CMakeCloseExecutor
    )
    add(
        "close_runner",
        "close the CMake runner window",
        vim.cmd.CMakeCloseRunner
    )
    add(
        "stop",
        "stop the running CMake process",
        vim.cmd.CMakeStop
    )

    -- settings and project scaffolding
    add(
        "settings",
        "configure CMake Tools settings",
        vim.cmd.CMakeSettings
    )
    add(
        "target_settings",
        "configure settings for a CMake target",
        vim.cmd.CMakeTargetSettings
    )
    add(
        "quick_start",
        "create a starter C or C++ CMake project",
        vim.cmd.CMakeQuickStart
    )
end

return plugin
