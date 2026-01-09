#!/bin/bash
set -e

sudo pacman -Syu

# install gdm and enable
sudo pacman -S gdm
sudo systemctl enable gdm.service

# install gnome and GSE
sudo pacman -Syu -noconfirm \
    gnome \
    gnome-extra \
    gnome-tweaks \
    gnome-shell \
    gnome-shell-extensions \
    gnome-shell-extension-appindicator

# drivers
# prereqs
sudo pacman -Syu -noconfirm \
    patchelf \
    go \

# somehow have yay installed
# yay -Sy nvidia-580xx-utils
# yay -Sy nvidia-580xx-settings
# yay -Sy nvidia-580xx-dkms
# yay -Sy opencl-nvidia-580xx

# install other reasonable things we need
sudo pacman -Syu -noconfirm \
    firefox \
    wget \
    discord \
    spotify-launcher \
    less

# fix spotify config
sudo tee /etc/spotify-launcher.conf > /dev/null << 'EOF'
[spotify]
extra_arguments = ["--ozone-platform=x11"]
EOF

# install my development requirements (https://github.com/phnk/dotfiles)
sudo pacman -Syu -noconfirm \
    git \
    tmux \
    zsh \
    neovim \
    nodejs \
    npm \
    xclip \
    ripgrep \

curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}/nvim/site/autoload/plug.vim" \
  --create-dirs \
  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh | bash

mkdir -p "$HOME/miniconda3"
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh \
     -O "$HOME/miniconda3/miniconda.sh"
bash "$HOME/miniconda3/miniconda.sh" -b -u -p "$HOME/miniconda3"
rm "$HOME/miniconda3/miniconda.sh"
source "$HOME/miniconda3/bin/activate"
conda init zsh


