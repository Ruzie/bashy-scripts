#!/bin/bash

# Check if a user is root or not
if [[ $(whoami) != "root" ]]; then
	echo "error: I need root priviledges to execute the whole script"
	exit 1
fi

extract() {
	tar xf config.tar 
}

apt_job() {
	apt clean && apt autoclean > /dev/null
	apt update && apt upgrade -y
	apt install neofetch git mpv libgconf-2-4 libc++1 libsdl1.2debian libsdl2-dev libsdl2-image-dev micro curl wget xclip gimp zip unzip gzip hexchat htop ffmpeg nasm net-tools passwd -y
}

install_vscode() {
	wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
	install -o root -g root -m 644 packages.microsoft.gpg /etc/apt/trusted.gpg.d/
	sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/trusted.gpg.d/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
	rm -f packages.microsoft.gpg

	# Update apt cache and install vscode
	apt update
	apt install code -y
}

install_discord() {
	wget https://dl.discordapp.net/apps/linux/0.0.17/discord-0.0.17.tar.gz && tar xf discord-0.0.17.tar.gz
	mv Discord /opt
	sed -i -e 's/\/usr\/share\/discord\/Discord/\/opt\/Discord\/Discord/' /opt/Discord/discord.desktop
	sed -i -e 's/\/usr\/bin/\/opt\/Discord/' /opt/Discord/discord.desktop
	cp /opt/Discord/discord-desktop /usr/share/applications
	rm discord-0*
}

config() {
	rm -rf /home/$USER/.config/xfce4/terminal
	mv config/terminal /home/$USER/.config/xfce4/
}

setup_zsh() {
	apt install zsh
	chsh -s $(which zsh)
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
	git clone https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k
	git clone https://github.com/zsh-users/zsh-autosuggestions.git $ZSH_CUSTOM/plugins/zsh-autosuggestions
	git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
	cp config/zsh/.zshrc ~/. && cp config/p10k/.p10k.zsh ~/.
	echo "we're done, from now you need to configure everything manually, good luck :)"
}

extract
apt_job
install_vscode
install_discord
config
setup_zsh
