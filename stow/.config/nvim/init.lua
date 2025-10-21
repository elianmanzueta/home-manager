-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

if vim.g.neovide then
  vim.g.neovide_cursor_animation_length = 0
  vim.g.neovide_position_animation_length = 0.5
  vim.g.neovide_scroll_animation_length = 0.1
  vim.g.neovide_refresh_rate = 120
end
