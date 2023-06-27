--**********************************************************
--* Author           : forgocode
--* Email            : forgocode@163.com
--* Github           : https://github.com/forgocode
--* Create Time      : 2023-06-08 13:11
--* FileName         : bufferline.lua
--* Description      :
--**********************************************************

require("bufferline").setup({
	options = {
		numbers = "ordinal",
		offsets = {
			filetype = "NvimTree",
			text = "File Explorer",
			hightlight = "Directory",
			text_align = "left",
		},
	},
})

-- 关闭当前bufferline
vim.keymapping.smap("n", "<A-q>", "<cmd>Bdelete!<CR>", vim.keymapping.opts)
-- 切换左侧缓冲区
vim.keymapping.smap("n", "<A-h>", "<cmd>BufferLineCyclePrev<CR>", vim.keymapping.opts)
-- 切换右侧缓冲区
vim.keymapping.smap("n", "<A-l>", "<cmd>BufferLineCycleNext<CR>", vim.keymapping.opts)
