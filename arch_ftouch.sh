# Arch's Final Touch
# Install noto fonts and remove firefox during FireFox have an issue, high memory hogging.

if [! yay --version || ! pacman --version ]; then
	echo "yay or pacman wasn't found, please install it manually."
fi

sudo -- sh -c 'pacman -Syu && pacman -S noto-fonts noto-fonts-cjk noto-fonts-emoji noto-fonts-extra'
