return {
	'ThePrimeagen/harpoon',
	branch = "harpoon2",
	dependencies = {'nvim-lua/plenary.nvim'},
	config = function()
		local harpoon = require("harpoon")

		harpoon:setup()

		vim.keymap.set("n", "<leader>m", function() harpoon:list():add() end) -- Mark file
		vim.keymap.set("n", "<leader>nt", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end) -- Toggle the ui

		-- Go to the ith file
		for i = 1, 9 do
		    vim.keymap.set('n', '<leader>n' .. i, function() harpoon:list():select(i) end, { desc = "Harpoon navigate to file " .. i })
		end

		-- Toggle previous & next buffers stored within Harpoon list
		vim.keymap.set("n", "<leader>np", function() harpoon:list():prev() end)
		vim.keymap.set("n", "<leader>nn", function() harpoon:list():next() end)
	end
}
