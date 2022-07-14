require("gitsigns").setup({
    signs = {
        add = { text = "▎" },
        change = { text = "▎" },
        delete = { text = "▎" },
        topdelete = { text = "契" },
        changedelete = { text = "▎" },
    },
    keymaps = {
        noremap = true,
        buffer = true,
        ["n <leader>hs"] = '<cmd>lua require"gitsigns".stage_hunk()<CR>',
        ["n <leader>hu"] = '<cmd>lua require"gitsigns".undo_stage_hunk()<CR>',
        ["n <leader>hr"] = '<cmd>lua require"gitsigns".reset_hunk()<CR>',
        ["n <leader>hR"] = '<cmd>lua require"gitsigns".reset_buffer()<CR>',
        ["n <leader>hp"] = '<cmd>lua require"gitsigns".preview_hunk()<CR>',

        -- Text objects
        ["o ih"] = ':<C-U>lua require"gitsigns".select_hunk()<CR>',
        ["x ih"] = ':<C-U>lua require"gitsigns".select_hunk()<CR>',
    },
    watch_gitdir = {
        interval = 1000,
    },
    sign_priority = 6,
    update_debounce = 1000,
    status_formatter = nil,
    diff_opts = {
        internal = true,
    },
})
