return {
    "ibhagwan/fzf-lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        local fzf = require('fzf-lua')

        fzf.setup({})

        -- Find files 
        vim.keymap.set('n', '<leader>ff', fzf.files, { desc = "Fzf find files" })

        -- Live grep (search text inside files)
        vim.keymap.set('n', '<leader>fg', fzf.live_grep, { desc = "Fzf live grep" })

        -- Search open buffers
        vim.keymap.set('n', '<leader>fb', fzf.buffers, { desc = "Fzf buffers" })

        -- Search help tags
        vim.keymap.set('n', '<leader>fh', fzf.help_tags, { desc = "Fzf help tags" })
    end
}
