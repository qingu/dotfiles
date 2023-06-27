-- **********************************************************
-- * Author           : forgocode
-- * Email            : forgocode@163.com
-- * Github           : https://github.com/forgocode
-- * Create Time      : 2023-06-09 13:00
-- * FileName         : markdown-preview.lua
-- * Description      :
-- **********************************************************

local function set_open_ip()
	if vim.env.localip == "" then
		print(vim.env.localip)
		vim.g.mkdp_open_ip = "0.0.0.0"
	else
		vim.g.mkdp_open_ip = vim.env.localip
	end
end

--允许修改ip
vim.g.mkdp_open_to_the_world = 1
vim.g.mkdp_filetypes = { "markdown" }
vim.g.mkdp_port = "9001"

set_open_ip()
-- 回显页面url
vim.g.mkdp_echo_preview_url = 1

vim.g.mkdp_auto_start = 1
vim.g.mkdp_refresh_slow = 1
vim.o.updatetime = 80

vim.g.mkdp_preview_options = {
	mkit = {},
	katex = {},
	uml = {},
	maid = {},
	disable_sync_scroll = 0,
	sync_scroll_type = "middle",
	hide_yaml_meta = 1,
	sequence_diagrams = {},
	flowchart_diagrams = {},
	-- content_editable = v:false,
	disable_filename = 0,
}

local opts = { noremap = true, silent = true }
vim.keymap.set("n", "<leader>mp", "<cmd>MarkdownPreview<CR>", opts)
vim.keymap.set("v", "<leader>mp", "<cmd>MarkdownPreview<CR>", opts)
vim.keymap.set("n", "<leader>cmp", "<cmd>MarkdownPreviewStop<CR>", opts)
vim.keymap.set("v", "<leader>cmp", "<cmd>MarkdownPreviewStop<CR>", opts)
