local status_ok, formatter = pcall(require, "formatter")

formatter.setup({
    logging = false,
    filetype = {
        css = {
            -- prettier
            function()
                return {
                    exe = "prettier",
                    args = {
                        "--stdin-filepath",
                        vim.api.nvim_buf_get_name(0),
                        "--tab-width 4",
                    },
                    stdin = true,
                }
            end,
        },
        go = {
            -- gofmt
            function()
                return { exe = "gofmt", args = { "-w", "." }, stdin = false }
            end,
        },
        nix = {
            -- prettier
            function()
                return {
                    exe = "nixfmt",
                    args = {
                        "-w 80",
                        vim.api.nvim_buf_get_name(0),
                    },
                    stdin = true,
                }
            end,
        },
        html = {
            -- prettier
            function()
                return {
                    exe = "prettier",
                    args = {
                        "--stdin-filepath",
                        vim.api.nvim_buf_get_name(0),
                        "--tab-width 4",
                    },
                    stdin = true,
                }
            end,
        },
        javascript = {
            -- prettier
            function()
                return {
                    exe = "prettier",
                    args = {
                        "--stdin-filepath",
                        vim.api.nvim_buf_get_name(0),
                        "--tab-width 4",
                    },
                    stdin = true,
                }
            end,
        },
        javascriptreact = {
            -- prettier
            function()
                return {
                    exe = "prettier",
                    args = {
                        "--stdin-filepath",
                        vim.api.nvim_buf_get_name(0),
                        "--tab-width 4",
                    },
                    stdin = true,
                }
            end,
        },
        json = {
            -- prettier
            function()
                return {
                    exe = "prettier",
                    args = {
                        "--stdin-filepath",
                        vim.api.nvim_buf_get_name(0),
                        "--tab-width 4",
                    },
                    stdin = true,
                }
            end,
        },
        jsonc = {
            -- prettier
            function()
                return {
                    exe = "prettier",
                    args = {
                        "--stdin-filepath",
                        vim.api.nvim_buf_get_name(0),
                        "--tab-width 4",
                    },
                    stdin = true,
                }
            end,
        },
        lua = {
            -- stylua
            function()
                return {
                    exe = "stylua",
                    args = {
                        "--call-parentheses Always",
                        "--column-width 80",
                        "--indent-type Spaces",
                        "--indent-width 4",
                        "--line-endings Unix",
                        "--quote-style ForceDouble",
                    },
                    stdin = false,
                }
            end,
        },
        python = {
            -- black
            function()
                return {
                    exe = "black",
                    args = { vim.api.nvim_buf_get_name(0) },
                    stdin = false,
                }
            end,
        },
        rust = {
            -- rustfmt
            function()
                return {
                    exe = "rustfmt",
                    args = { "--emit=stdout" },
                    stdin = true,
                }
            end,
        },
        scss = {
            -- prettier
            function()
                return {
                    exe = "prettier",
                    args = {
                        "--stdin-filepath",
                        vim.api.nvim_buf_get_name(0),
                        "--tab-width 4",
                    },
                    stdin = true,
                }
            end,
        },
        typescript = {
            -- prettier
            function()
                return {
                    exe = "prettier",
                    args = {
                        "--stdin-filepath",
                        vim.api.nvim_buf_get_name(0),
                        "--tab-width 4",
                    },
                    stdin = true,
                }
            end,
        },
        typescriptreact = {
            -- prettier
            function()
                return {
                    exe = "prettier",
                    args = {
                        "--stdin-filepath",
                        vim.api.nvim_buf_get_name(0),
                        "--tab-width 4",
                    },
                    stdin = true,
                }
            end,
        },
    },
})
