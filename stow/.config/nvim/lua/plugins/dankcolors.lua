return {
	{
		"RRethy/base16-nvim",
		priority = 1000,
		config = function()
			require('base16-colorscheme').setup({
				base00 = '#13140f',
				base01 = '#13140f',
				base02 = '#84877d',
				base03 = '#84877d',
				base04 = '#d6dacd',
				base05 = '#fdfff8',
				base06 = '#fdfff8',
				base07 = '#fdfff8',
				base08 = '#ffae9f',
				base09 = '#ffae9f',
				base0A = '#cee49a',
				base0B = '#a9f9a2',
				base0C = '#f1ffd3',
				base0D = '#cee49a',
				base0E = '#eaffbb',
				base0F = '#eaffbb',
			})

			vim.api.nvim_set_hl(0, 'Visual', {
				bg = '#84877d',
				fg = '#fdfff8',
				bold = true
			})
			vim.api.nvim_set_hl(0, 'Statusline', {
				bg = '#cee49a',
				fg = '#13140f',
			})
			vim.api.nvim_set_hl(0, 'LineNr', { fg = '#84877d' })
			vim.api.nvim_set_hl(0, 'CursorLineNr', { fg = '#f1ffd3', bold = true })

			vim.api.nvim_set_hl(0, 'Statement', {
				fg = '#eaffbb',
				bold = true
			})
			vim.api.nvim_set_hl(0, 'Keyword', { link = 'Statement' })
			vim.api.nvim_set_hl(0, 'Repeat', { link = 'Statement' })
			vim.api.nvim_set_hl(0, 'Conditional', { link = 'Statement' })

			vim.api.nvim_set_hl(0, 'Function', {
				fg = '#cee49a',
				bold = true
			})
			vim.api.nvim_set_hl(0, 'Macro', {
				fg = '#cee49a',
				italic = true
			})
			vim.api.nvim_set_hl(0, '@function.macro', { link = 'Macro' })

			vim.api.nvim_set_hl(0, 'Type', {
				fg = '#f1ffd3',
				bold = true,
				italic = true
			})
			vim.api.nvim_set_hl(0, 'Structure', { link = 'Type' })

			vim.api.nvim_set_hl(0, 'String', {
				fg = '#a9f9a2',
				italic = true
			})

			vim.api.nvim_set_hl(0, 'Operator', { fg = '#d6dacd' })
			vim.api.nvim_set_hl(0, 'Delimiter', { fg = '#d6dacd' })
			vim.api.nvim_set_hl(0, '@punctuation.bracket', { link = 'Delimiter' })
			vim.api.nvim_set_hl(0, '@punctuation.delimiter', { link = 'Delimiter' })

			vim.api.nvim_set_hl(0, 'Comment', {
				fg = '#84877d',
				italic = true
			})

			local current_file_path = vim.fn.stdpath("config") .. "/lua/plugins/dankcolors.lua"
			if not _G._matugen_theme_watcher then
				local uv = vim.uv or vim.loop
				_G._matugen_theme_watcher = uv.new_fs_event()
				_G._matugen_theme_watcher:start(current_file_path, {}, vim.schedule_wrap(function()
					local new_spec = dofile(current_file_path)
					if new_spec and new_spec[1] and new_spec[1].config then
						new_spec[1].config()
						print("Theme reload")
					end
				end))
			end
		end
	}
}
