modes = {
	n = "RW",
	no = "RO",
	v = "**",
	V = "**",
	["\022"] = "**",
	s = "S",
	S = "SL",
	["\019"] = "SB",
	i = "**",
	ic = "**",
	R = "R",
	Rv = "RV",
	c = "VIEX",
	cv = "VIEX",
	ce = "EX",
	r = "r",
	rm = "r",
	["r?"] = "r",
	["!"] = "!",
	t = "",
}

local c = require("catppuccin.palettes").get_palette("frappe")
vim.api.nvim_set_hl(0, "Statusmode", { bg = c.blue, fg = c.base })
vim.api.nvim_set_hl(0, "Error", { fg = c.red })
vim.api.nvim_set_hl(0, "Warning", { fg = c.yellow })
vim.api.nvim_set_hl(0, "Hint", { fg = c.blue })
vim.api.nvim_set_hl(0, "Info", { fg = c.blue })
vim.api.nvim_set_hl(0, "GitBranch", { fg = c.subtext0 })

local function mode()
	local current_mode = vim.api.nvim_get_mode().mode
	return string.format(" %s ", modes[current_mode]):upper()
end

local function lsp()
	local count = {}
	local levels = {
		errors = "Error",
		warnings = "Warn",
		info = "Info",
		hints = "Hint",
	}

	for k, level in pairs(levels) do
		count[k] = vim.tbl_count(vim.diagnostic.get(0, { severity = level }))
	end

	local errors = ""
	local warnings = ""
	local hints = ""
	local info = ""

	if count["errors"] ~= 0 then
		errors = " %#Error# " .. count["errors"]
	end
	if count["warnings"] ~= 0 then
		warnings = " %#Warning# " .. count["warnings"]
	end
	if count["hints"] ~= 0 then
		hints = " %#Hint# " .. count["hints"]
	end
	if count["info"] ~= 0 then
		info = " %#Info# " .. count["info"]
	end

	return errors .. warnings .. hints .. info .. "%#Normal#"
end

function get_bufnr()
	return "%#Comment##" .. vim.api.nvim_get_current_buf()
end

local function get_file_name()
	return ((vim.fn.expand("%") == "") and " [Empty] ") or (" " .. vim.fn.expand("%:t") .. " ")
end

local function filename()
	local fname = vim.fn.expand("%:t")
	if fname == "" then
		return ""
	end
	return fname .. " "
end

local function filetype()
	local file_type = vim.bo.filetype
	return ("%%#NormalNC# %s %s"):format(
		require("nvim-web-devicons").get_icon(get_file_name(), file_type, { default = true }),
		file_type
	)
end

local function lineinfo()
	if vim.bo.filetype == "alpha" then
		return ""
	end
	return " %P %l:%c "
end

function git_status()
	local branch = vim.b.gitsigns_status_dict or { head = "" }
	local is_empty = branch.head == ""
	if not is_empty then
		return "%#GitBranch#" .. string.format("( • #%s) ", branch.head)
	end
	return ""
end
function get_search_count()
	if vim.v.hlsearch == 0 then
		return "%#Normal# %l:%c "
	end
	local ok, count = pcall(vim.fn.searchcount, { recompute = true })
	if (not ok or (count.current == nil)) or count.total == 0 then
		return ""
	end
	if count.incomplete == 1 then
		return "?/?"
	end
	local too_many = (">%d"):format(count.maxcount)
	local total = (((count.total > count.maxcount) and too_many) or count.total)
	return ("%#Normal#" .. (" %s matches "):format(total))
end

Statusline = {}

Statusline.active = function()
	return table.concat({
		"%#Statusmode#",
		mode(),
		"%#Normal# ",
		filename(),
		"%#Normal#",
		lsp(),
		git_status(),
		get_bufnr(),
		"%=%#StatusLineExtra#",
		get_search_count(),
		filetype(),
	})
end

function Statusline.inactive()
	return " %F"
end

function Statusline.short()
	return "%#StatusLineNC#   NvimTree"
end

local winbar = "%#Comment#"
if vim.bo.modified then
	winbar = winbar .. ("%s"):format(" •")
end
winbar = winbar .. " %f "
Winbar = {
	active = function()
		return winbar
	end,
}

vim.api.nvim_create_augroup("winbar", { clear = true })
local winbar_exclude = {
	"help",
	"NvimTree",
	"alpha",
	"TelescopePrompt",
	"packer",
}

vim.api.nvim_create_autocmd({ "BufEnter", "WinEnter" }, {
	group = "winbar",
	callback = function()
		if vim.api.nvim_win_get_config(0).relative ~= "" then
			return
		end
		if not vim.bo.buftype == "" or vim.tbl_contains(winbar_exclude, vim.bo.filetype) then
			return
		end
		vim.opt_local.winbar = Winbar.active()
	end,
})

vim.api.nvim_exec(
	[[
  augroup Statusline
  au!
  au WinEnter,BufEnter * setlocal statusline=%!v:lua.Statusline.active()
  au WinLeave,BufLeave * setlocal statusline=%!v:lua.Statusline.inactive()
  au WinEnter,BufEnter,FileType NvimTree setlocal statusline=%!v:lua.Statusline.short()
  augroup END
]],
	false
)
