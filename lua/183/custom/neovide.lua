if not vim.g.neovide then
    return
end

-- borders
vim.o.winborder = "solid"
vim.o.pumborder = "none"

-- opacity
vim.g.neovide_normal_opacity = 0.7
vim.g.neovide_opacity = 0.6

-- animations
vim.g.neovide_cursor_animation_length = 0.06
vim.g.neovide_cursor_short_animation_length = 0.025
vim.g.neovide_cursor_trail_size = 0.7
vim.g.neovide_cursor_animate_in_insert_mode = true

vim.g.neovide_scroll_animation_length = 0.10
vim.g.neovide_scroll_animation_far_lines = 3

vim.g.neovide_position_animation_length = 0.08
vim.g.neovide_cursor_vfx_mode = ""

-- window
vim.g.neovide_padding_top = 8
vim.g.neovide_padding_bottom = 8
vim.g.neovide_padding_left = 6
vim.g.neovide_padding_right = 5

vim.g.neovide_floating_corner_radius = 0.3

-- keymaps
FUNCS.map("n", "<C-=>", function()
    vim.g.neovide_scale_factor = vim.g.neovide_scale_factor * 1.1
end, { desc = "[neovide] zoom in" })

FUNCS.map("n", "<C-->", function()
    vim.g.neovide_scale_factor = vim.g.neovide_scale_factor / 1.1
end, { desc = "[neovide] zoom out" })

FUNCS.map("n", "<C-0>", function()
    vim.g.neovide_scale_factor = 1.0
end, { desc = "[neovide] reset zoom" })
