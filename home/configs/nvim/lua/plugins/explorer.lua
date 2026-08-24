return {
    'stevearc/oil.nvim',
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        vim.keymap.set("n", "<leader>e", "<Cmd>Oil<CR>", { desc = "Open File Manager" })

        require("oil").setup({
            keymaps = {
            ["<Esc>"] = "actions.close", 
            ["h"] = "actions.parent",
            ["l"] = "actions.select",
            },
        })
    end
}
