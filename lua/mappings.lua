local map = vim.keymap.set

map("i", "<C-b>", "<ESC>^i", { desc = "move beginning of line" })
map("i", "<C-e>", "<End>", { desc = "move end of line" })
map("i", "<C-h>", "<Left>", { desc = "move left" })
map("i", "<C-l>", "<Right>", { desc = "move right" })
map("i", "<C-j>", "<Down>", { desc = "move down" })
map("i", "<C-k>", "<Up>", { desc = "move up" })

map("n", "<C-h>", "<C-w>h", { desc = "switch window left" })
map("n", "<C-l>", "<C-w>l", { desc = "switch window right" })
map("n", "<C-j>", "<C-w>j", { desc = "switch window down" })
map("n", "<C-k>", "<C-w>k", { desc = "switch window up" })

map("n", "<Esc>", "<cmd>noh<CR>", { desc = "general clear highlights" })

map("n", "<C-s>", "<cmd>w!<CR>", { desc = "general save file" })
map("n", "<C-a>", "<cmd>%y+<CR>", { desc = "general copy whole file" })

map("v", "<C-c>", '"+y', { desc = "general copy" })
map("n", "<C-v>", '"+p', { desc = "general paste" })
map("i", "<C-v>", "<C-R>+", { desc = "general paste in inset mode" })
map("v", "<C-x>", '"+d', { desc = "general cut" })

map("n", "<leader>qa", "<cmd>qall<cr>", { desc = "quit all" })

map("n", "<leader>cs", "<cmd>set spell<cr>", { desc = "set spell" })
map("n", "<leader>cn", "<cmd>set nospell<cr>", { desc = "set nospell" })

map({ "n", "x" }, "<leader>cc", function()
  require("conform").format { lsp_fallback = true }
end, { desc = "general format file" })

-- global lsp mappings
map("n", "<leader>ds", vim.diagnostic.setloclist, { desc = "LSP diagnostic loclist" })

-- Comment
map("n", "<leader>/", "gcc", { desc = "toggle comment", remap = true })
map("v", "<leader>/", "gc", { desc = "toggle comment", remap = true })

-- nvimtree
map("n", "<C-n>", "<cmd>NvimTreeToggle<CR>", { desc = "nvimtree toggle window" })
map("n", "<leader>e", "<cmd>NvimTreeFocus<CR>", { desc = "nvimtree focus window" })

-- telescope
map("n", "<leader>fg", "<cmd>Telescope live_grep<CR>", { desc = "telescope live grep" })
map("n", "<leader>fb", "<cmd>Telescope buffers<CR>", { desc = "telescope find buffers" })
map("n", "<leader>fh", "<cmd>Telescope help_tags<CR>", { desc = "telescope help page" })
map("n", "<leader>fm", "<cmd>Telescope marks<CR>", { desc = "telescope find marks" })
map("n", "<leader>fo", "<cmd>Telescope oldfiles<CR>", { desc = "telescope find oldfiles" })
map("n", "<leader>fz", "<cmd>Telescope current_buffer_fuzzy_find<CR>", { desc = "telescope find in current buffer" })
map("n", "<leader>fc", "<cmd>Telescope git_commits<CR>", { desc = "telescope git commits" })
map("n", "<leader>fs", "<cmd>Telescope git_status<CR>", { desc = "telescope git status" })
map("n", "<leader>fp", "<cmd>Telescope terms<CR>", { desc = "telescope pick hidden term" })
map("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "telescope find files" })
map(
  "n",
  "<leader>fa",
  "<cmd>Telescope find_files follow=true no_ignore=true hidden=true<CR>",
  { desc = "telescope find all files" }
)

-- terminal
map("t", "<C-x>", "<C-\\><C-N>", { desc = "terminal escape terminal mode" })

-- new terminals
map("n", "<leader>h", function()
  require("nvchad.term").new { pos = "sp" }
end, { desc = "terminal new horizontal term" })

map("n", "<leader>v", function()
  require("nvchad.term").new { pos = "vsp" }
end, { desc = "terminal new vertical term" })

-- Obsidian
map("n", "<leader><cr>", function()
  require("obsidian").util.smart_action()
end, { noremap = true, desc = "Obsidian Smart Action" })
map("n", "<leader>ot", "<cmd>Obsidian today<CR>", { desc = "open today's note" })
map("n", "<leader>oy", "<cmd>Obsidian yesterday<CR>", { desc = "open yesterday's note" })
map("n", "<leader>oT", "<cmd>Obsidian tomorrow<CR>", { desc = "open tomorrow's note" })
map("n", "<leader>on", "<cmd>Obsidian new<CR>", { desc = "create new note" })
map("n", "<leader>os", "<cmd>Obsidian search<CR>", { desc = "search the workspace" })
map("n", "<leader>od", "<cmd>Obsidian dailies<CR>", { desc = "open Dailies" })


-- Spelling & Formatting
map("n", "<leader>cp", "gqap<CR>", { desc = "Format paragraphs" })
map("n", "<leader>ce", "z=", { desc = "Get spelling suggestion" })
map("n", "gd", vim.lsp.buf.definition, { desc = "G definition" })

-- Oil
map("n", "<leader>-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

--
--
-- OIL keymaps = {
--     ["g?"] = { "actions.show_help", mode = "n" },
--     ["<CR>"] = "actions.select",
--     ["<C-s>"] = { "actions.select", opts = { vertical = true } },
--     ["<C-h>"] = { "actions.select", opts = { horizontal = true } },
--     ["<C-t>"] = { "actions.select", opts = { tab = true } },
--     ["<C-p>"] = "actions.preview",
--     ["<C-c>"] = { "actions.close", mode = "n" },
--     ["<C-l>"] = "actions.refresh",
--     ["-"] = { "actions.parent", mode = "n" },
--     ["_"] = { "actions.open_cwd", mode = "n" },
--     ["`"] = { "actions.cd", mode = "n" },
--     ["~"] = { "actions.cd", opts = { scope = "tab" }, mode = "n" },
--     ["gs"] = { "actions.change_sort", mode = "n" },
--     ["gx"] = "actions.open_external",
--     ["g."] = { "actions.toggle_hidden", mode = "n" },
--     ["g\\"] = { "actions.toggle_trash", mode = "n" },
--   },
