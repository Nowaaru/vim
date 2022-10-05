# installer setup
if command -qs git
    read -P "$(set_color red) Removing old Neovim installation... Proceed? [y/n] " remove
    if [ $remove = "y" ]
        rm -rfv ~/.local/share/nvim/
        rm -rfv ~/.config/nvim/

        echo "$(set_color green) Done!"
    end

    read -P "$(set_color 62A000) If you are a WSL user, win32yank must be installed. Is this okay? [y/n] " is_wsl
    if [ $is_wsl = "y" ]
    	echo "$(set_color red) Installing win32yank..."

	curl -sLo/tmp/win32yank.zip https://github.com/equalsraf/win32yank/releases/download/v0.0.4/win32yank-x64.zip
	unzip -p /tmp/win32yank.zip win32yank.exe > /tmp/win32yank.exe
	chmod +x /tmp/win32yank.exe
	sudo mv /tmp/win32yank.exe /usr/local/bin/

	echo "$(set_color green) Done!"
	set_color normal
    end

    mkdir -p ~/.local/share/nvim
    mkdir -p ~/.config/nvim

    echo "$(set_color green) Installing NoireVim profile... $(set_color white)"
    git clone --depth 1 -v https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim
    git clone https://github.com/Nowaaru/vim.git -v ~/.config/nvim

    read -P "Please close Neovim after plugin installation. Awaiting user confirmation..." _
    nvim +PackerInstall

    if command -qs npm
        if command -qs yarn
            echo "$(set_color green) Yarn is installed. Setting up CoC... $(set_color white)"
            cd ~/.local/share/nvim/site/pack/packer/start/coc.nvim
            yarn install

	    echo "$(set_color green) Done!"
	    set_color 62A000

    	    read -P "NoireVim is installed! Do you want to open it? [y/n] " open_vim
	    if [ $open_vim = "y" ]
	    	nvim +PackerInstall
	    end
        else
            echo "$(set_color yellow) You don't have Yarn installed. Please install Yarn." 1>&2
        end
    else
        echo "$(set_color red) You do not have NPM installed. Please look into this URL: https://github.com/jorgebucaran/nvm.fish" 1>&2
    end
else
    echo "$(set_color red) You do not have Git installed. Please install Git." 1>&2
end
