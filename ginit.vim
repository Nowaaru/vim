inoremap <silent>  <S-Insert>  <C-R>+
set mouse=a

GuiTabline 0
if exists(':GuiRenderLigatures')
	GuiRenderLigatures 1
	GuiFont! FiraCode\ Nerd\ Font:h13 " <-- Here
endif
