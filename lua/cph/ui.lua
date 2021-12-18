local utils = require("cph.utils")
INPUT_BUF_ID = nil
OUTPUT_BUF_ID = nil
INPUT_WIN_ID = nil
OUTPUT_WIN_ID = nil
WIDTH = 30
HEIGHT = 20
GAP = 10
TestCases = {}

local function SetBufKeyMaps(buffer)
	vim.api.nvim_buf_set_keymap(buffer, 'n', "<CR>", ":<cmd> lua require(\"cph.ui\").OnEnter()<CR><CR>", { noremap = true, silent = true })
	vim.api.nvim_buf_set_keymap(buffer, 'n', "q", ":<cmd>  lua require(\"cph.ui\").CloseWindows()<CR><CR>", { noremap = true, silent = true })
end

local function DrawInputWin()
	local _width = vim.api.nvim_list_uis()[1].width
	local _height = vim.api.nvim_list_uis()[1].height
	INPUT_WIN_ID = vim.api.nvim_open_win(INPUT_BUF_ID, true, { relative="editor",
				 width= WIDTH, height= HEIGHT,
				 col= (_width - WIDTH)/2 - ( GAP + 10 ), row=(_height - HEIGHT)/2,
				 border="rounded"})
	vim.wo.number = false
	vim.wo.relativenumber = false
end

local function DrawOutputWin()
	local _width = vim.api.nvim_list_uis()[1].width
	local _height = vim.api.nvim_list_uis()[1].height
	OUTPUT_WIN_ID = vim.api.nvim_open_win(OUTPUT_BUF_ID, true, { relative="editor",
				 width= WIDTH, height= HEIGHT,
				 col= (_width - WIDTH)/2 + (WIDTH/2), row= (_height - HEIGHT)/2,
				 border="rounded"})
	vim.wo.number = false
	vim.wo.relativenumber = false
end

local function CloseWindows()
	vim.api.nvim_win_close(INPUT_WIN_ID, true)
	vim.api.nvim_win_close(OUTPUT_WIN_ID, true)
	INPUT_WIN_ID = nil
	OUTPUT_WIN_ID = nil
end

local function OnResize()
	if INPUT_WIN_ID ~= nil and OUTPUT_WIN_ID ~= nil then
		vim.api.nvim_win_close(INPUT_WIN_ID, true)
		vim.api.nvim_win_close(OUTPUT_WIN_ID, true)
		DrawInputWin()
		DrawOutputWin()
	end
end

local function AddTestCase()
	if INPUT_BUF_ID == nil then
		INPUT_BUF_ID = vim.api.nvim_create_buf(false, true)
	end
	if OUTPUT_BUF_ID == nil then
		OUTPUT_BUF_ID = vim.api.nvim_create_buf(false, true)
	end
    if INPUT_WIN_ID == nil then
		DrawInputWin()
    end
    if OUTPUT_WIN_ID == nil then
		DrawOutputWin()
    end
	SetBufKeyMaps(INPUT_BUF_ID)
	SetBufKeyMaps(OUTPUT_BUF_ID)
	vim.api.nvim_buf_set_name(INPUT_BUF_ID, "Enter the Input")
	vim.api.nvim_buf_set_name(OUTPUT_BUF_ID, "Enter the Output")
end

local function OnEnter()
	local _i = utils.join(vim.api.nvim_buf_get_lines(INPUT_BUF_ID, 0, -1, false))
	local _o = utils.join(vim.api.nvim_buf_get_lines(OUTPUT_BUF_ID, 0, -1, false))
	if #_i == 0 or #_o == 0 then
		print("Fields can't be empty!")
		return
	end
	table.insert(TestCases, { input = _i, output = _o })
	vim.api.nvim_win_close(INPUT_WIN_ID, true)
	vim.api.nvim_win_close(OUTPUT_WIN_ID, true)
	vim.api.nvim_buf_delete(INPUT_BUF_ID, {force=true})
	vim.api.nvim_buf_delete(OUTPUT_BUF_ID, {force=true})
	INPUT_BUF_ID = nil
	INPUT_WIN_ID = nil
	OUTPUT_BUF_ID = nil
	OUTPUT_WIN_ID = nil
end

return {
	AddTestCase = AddTestCase,
	OnEnter = OnEnter,
	OnResize = OnResize,
	CloseWindows = CloseWindows,
}
