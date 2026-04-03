return {
    "obsidian-nvim/obsidian.nvim",
    version = "*",
    lazy = false,
    ft = "markdown",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "hrsh7th/nvim-cmp",
        "nvim-telescope/telescope.nvim",
        "MeanderingProgrammer/render-markdown.nvim",
    },

    config = function()
        vim.api.nvim_create_autocmd("FileType", {
            pattern = "markdown",
            callback = function()
                vim.opt_local.conceallevel = 1
            end,
        })
        vim.api.nvim_create_autocmd("BufWritePre", {
            pattern = "*.md",
            callback = function()
                require("conform").format({ async = false, lsp_fallback = true })
            end,
        })

        require("render-markdown").setup({
            enabled = true,
            latex = { enabled = true },
            pipe_table = { style = "normal", preset = "round" },
            bullet = { enabled = false, right_pad = 1 },
            checkbox = {
                enabled = false,
                render_mode = false,
                unchecked = { icon = "" },
            },
        })

        vim.api.nvim_set_hl(0, "RenderMarkdownH3Bg", { fg = "#ff8800", bg = "#664014" })

        require("obsidian").setup({
            legacy_commands = false,

            workspaces = {
                {
                    name = "personal",
                    path = "~/Sync/vaults/personal",
                },
            },

            log_level = vim.log.levels.INFO,

            completion = {
                nvim_cmp = true,
                min_chars = 2,
            },

            note_id_func = function(title)
                return title
            end,

            note_path_func = function(spec)
                local path = spec.dir / tostring(spec.id)
                return path:with_suffix(".md")
            end,

            frontmatter = {
                enabled = true,
                func = function(note)
                    local path_str = note.path and tostring(note.path) or ""

                    local parent_dir = ""
                    if path_str ~= "" then
                        local dir = vim.fs.dirname(path_str)
                        if dir and dir ~= "" then
                            parent_dir = vim.fs.basename(dir) or ""
                        end
                    end

                    if note.title then
                        note:add_alias(note.title)
                        note:add_alias(parent_dir)
                    end

                    local out = { id = note.id, aliases = note.aliases, tags = note.tags }

                    if note.metadata ~= nil and not vim.tbl_isempty(note.metadata) then
                        for k, v in pairs(note.metadata) do
                            out[k] = v
                        end
                    end
                    return out
                end,
            },
            daily_notes = {
                date_format = "%m-%d-%Y",
                alias_format = "%B %-d, %Y",
                default_tags = { "daily-notes" },
                template = "Templates/Daily to-do.md",
                folder = (function(date)
                    local d = os.date("*t", date)
                    local month_year = string.format("%02d-%d", d.month, d.year)
                    return "Daily_Notes/" .. month_year
                end)(),
                workdays_only = true,
            },

            templates = {
                folder = "Templates",
                date_format = "%d-%m-%Y",
                time_format = "%H:%M",
            },

            picker = {
                name = "telescope.nvim",
                note_mappings = {
                    new = "<C-x>",
                    insert_link = "<C-l>",
                },
                tag_mappings = {
                    tag_note = "<C-x>",
                    insert_tag = "<C-l>",
                },
            },

            search = {
                max_lines = 1000,
                sort_by = "modified",
                sort_reversed = true,
            },

            open_notes_in = "current",

            checkbox = {
                order = { " ", "x" },
            },

            ui = {
                enable = false,
                update_debounce = 200,
                max_file_length = 5000,
                bullets = { char = "•", hl_group = "ObsidianBullet" },
                external_link_icon = { char = "", hl_group = "ObsidianExtLinkIcon" },
                reference_text = { hl_group = "ObsidianRefText" },
                highlight_text = { hl_group = "ObsidianHighlightText" },
                tags = { hl_group = "ObsidianTag" },
                block_ids = { hl_group = "ObsidianBlockID" },
                hl_groups = {
                    ObsidianTodo = { bold = true, fg = "#f78c6c" },
                    ObsidianDone = { bold = true, fg = "#89ddff" },
                    ObsidianRightArrow = { bold = true, fg = "#f78c6c" },
                    ObsidianTilde = { bold = true, fg = "#ff5370" },
                    ObsidianImportant = { bold = true, fg = "#d73128" },
                    ObsidianBullet = { bold = true, fg = "#89ddff" },
                    ObsidianRefText = { underline = true, fg = "#c792ea" },
                    ObsidianExtLinkIcon = { fg = "#c792ea" },
                    ObsidianTag = { italic = true, fg = "#89ddff" },
                    ObsidianBlockID = { italic = true, fg = "#89ddff" },
                    ObsidianHighlightText = { bg = "#75662e" },
                    markdownH2 = { bold = true, fg = "#c429bf" },
                },
            },

            attachments = {
                folder = "~/Sync/vaults/assets/",

                img_name_func = function()
                    return string.format("%s-", os.time())
                end,

                img_text_func = function(client, path)
                    path = client:vault_relative_path(path) or path
                    return string.format("![%s](%s)", path.name, path)
                end,
            },
        })
    end,
}
