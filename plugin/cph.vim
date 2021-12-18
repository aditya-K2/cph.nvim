command CPHStart :lua require("cph.server").Start()

augroup CPH
	autocmd!
	autocmd VimResized * :lua require("cph.ui").OnResize()
augroup END
