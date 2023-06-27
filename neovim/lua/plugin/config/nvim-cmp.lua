--**********************************************************
--* Author           : forgocode
--* Email            : forgocode@163.com
--* Github           : https://github.com/forgocode
--* Create Time      : 2023-06-08 13:11
--* FileName         : nvim-cmp.lua
--* Description      :
--**********************************************************

local lspkind = require("lspkind")
local cmp = require("cmp")

cmp.setup({
	snippet = {
		expand = function(args)
			vim.fn["vsnip#anonymous"](args.body)
		end,
	},
	-- 补全源的排序
	sources = cmp.config.sources({
		{ name = "vsnip" },
		{ name = "nvim_lsp" },
		{ name = "path" },
		{ name = "buffer" },
		{ name = "cmdline" },
		{ name = "spell" },
	}),
	-- 格式化补全菜单
	formatting = {
		format = lspkind.cmp_format({
			with_text = true,
			maxwidth = 50,
			before = function(entry, vim_item)
				vim_item.menu = "[" .. string.upper(entry.source.name) .. "]"
				return vim_item
			end,
		}),
	},
	-- 对补全建议排序
	sorting = {
		comparators = {
			cmp.config.compare.offset,
			cmp.config.compare.exact,
			cmp.config.compare.score,
			cmp.config.compare.recently_used,
			require("cmp-under-comparator").under,
			cmp.config.compare.kind,
			cmp.config.compare.sort_text,
			cmp.config.compare.length,
			cmp.config.compare.order,
		},
	},
	-- 补全相关的按键
	mapping = {
		["<Tab>"] = cmp.mapping.select_next_item(),
		["<Up>"] = cmp.mapping.select_prev_item(),
		["<Down>"] = cmp.mapping.select_next_item(),
		["<CR>"] = cmp.mapping.confirm({ select = true }),
	},
})

-- vim的"/"命令模式提示
cmp.setup.cmdline({ "/", "?" }, {
	sources = {
		{ name = "buffer" },
	},
})
-- vim的":"命令模式提示
cmp.setup.cmdline(":", {
	sources = cmp.config.sources({
		{ name = "path" },
	}, {
		{ name = "cmdline" },
	}),
})
