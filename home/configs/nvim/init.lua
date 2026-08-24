vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.opt.timeoutlen = 500

-- sets clipboard to system clipboard
vim.opt.clipboard = "unnamedplus"

-- adds relative line numbers and absolute for the current line
vim.wo.relativenumber = true
vim.opt.number = true
vim.opt.signcolumn = "number" -- keeps it all in one column instead of two

-- removes the startup screen
vim.opt.shortmess:append("I")

-- sets tab width to 8
local tabsize = 8
vim.o.tabstop = tabsize
vim.o.shiftwidth = 0
vim.o.softtabstop = 0

for i = 1, 9 do
	vim.keymap.set("n", "<leader>rt" .. i, function()
		local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
		local new_lines = {}
		local space_pattern = string.rep(" ", i)

		for _, line in ipairs(lines) do
			local leading_spaces = line:match("^( +)")
			if leading_spaces then
				local num_spaces = #leading_spaces
				local num_tabs = math.floor(num_spaces / i)
				local remainder = num_spaces % i

				local new_prefix = string.rep("\t", num_tabs) .. string.rep(" ", remainder)
				local rest_of_line = line:sub(num_spaces + 1)

				table.insert(new_lines, new_prefix .. rest_of_line)
			else
				table.insert(new_lines, line)
			end
		end

		vim.api.nvim_buf_set_lines(0, 0, -1, false, new_lines)
	end, { desc = string.format("Convert leading groups of %d spaces to tabs", i) })
end

vim.keymap.set("n", "<leader>rt", function()
	print("Please specify the tab size of current file")
end, { desc = "Prompt for tab size" })

-- vim.opt.expandtab = true
vim.o.list = true

-- setup lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

-- config lazy.nvim plugins
require("lazy").setup({
	{ import = "plugins" },
})

-- set colorscheme
vim.cmd("colorscheme tokyonight-night")
