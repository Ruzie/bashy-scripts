#!/bin/bash

# My personal script which install extra stuff to debian, made for easy installation purposes
if [[ ! $(whoami) == "root"* ]]; then
	echo "error: I need sudo privilege to execute the script"
	exit 1
fi

	# Clean and install all mentioned programs
	apt clean && apt autoclean
	apt update && apt upgrade -y
	apt install neofetch git mpv libgconf-2-4 libc++1 libsdl1.2debian libsdl2-dev libsdl2-image-dev micro wget xclip gimp zip unzip gzip hexchat htop ffmpeg nasm net-tools passwd apt-transport-https gpg -y 

	# Clone nvm git repository
	git clone https://github.com/nvm-sh/nvm.git /tmp/nvm 
	bash /tmp/nvm/install.sh
	sleep 5

	# Export NVM path in .bashrc not yet for other shells, as I prefer bash shell over others
	export NVM_DIR="$HOME/.nvm"
	[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
	[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

	# Check if node installed properly
	if [[ ! node ]]; then
		echo "error: I wasn't able to set up nvm PATH, please do it manually, for more info: https://github.com/nvm-sh/nvm#manual-install"
	fi
	rm -rf /tmp/nvm

	# Clone ani-cli on the Desktop, user have full access now what they want to do
	git clone https://github.com/pystardust/ani-cli.git /opt/ani-cli && export PATH="$PATH:/opt/ani-cli"

	# Setup VSCode repo, taken from here: https://code.visualstudio.com/docs/setup/linux
	wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
	install -o root -g root -m 644 packages.microsoft.gpg /etc/apt/trusted.gpg.d/
	sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/trusted.gpg.d/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
	rm -f packages.microsoft.gpg

	# Now fresh apt cache and install VScode
	apt update && apt upgrade -y
	apt install code -y # You can do apt install -f and then apt install code, only if VSCode wasn't able to install properly during requirement packages

	# Download Discord (doing by this as Discord do major update rarely for GNU/Linux)
	wget https://dl.discordapp.net/apps/linux/0.0.17/discord-0.0.17.tar.gz && tar xf discord-0.0.17.tar.gz
	mv Discord /opt
	sed -i -e 's/\/usr\/share\/discord\/Discord/\/opt\/Discord\/Discord/' /opt/Discord/discord.desktop
	sed -i -e 's/\/usr\/bin/\/opt\/Discord/' /opt/Discord/discord.desktop
	cp /opt/Discord/discord-desktop /usr/share/applications
	rm discord-0*

	# Let's download our favorite themes and icons
	wget https://github.com/EliverLara/Sweet/releases/latest/download/Sweet-Dark.zip /home/nowsetup_theme
	wget https://github.com/EliverLara/candy-icons/archive/refs/heads/master.zip /home/nowsetup_icon
		
	echo "All programs are installed properly, now you can move and change your XFCE theme, terminal style and more!"

