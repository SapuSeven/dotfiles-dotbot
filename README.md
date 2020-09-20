The dotfiles should work on any Arch-based system.

## Used packages

    sudo pacman -Syu xorg rxvt-unicode pcmanfm i3lock-color rofi nitrogen dunst xdotool bc numlockx brightnessctl sxhkd clipster ttf-dejavu i3exit playerctl lsof xclip
    yay -S xcursor-breeze lightdm-webkit-theme-sequoia-git

## Suggested packages

- `okular` - PDF Viewer
- `ark` - Archive Manager

# Installation

This will place all customized dotfiles inside `~/.dotfiles` and symlink accordingly.

    git clone https://github.com/SapuSeven/dotfiles.git ~/.dotfiles
    cd ~/.dotfiles
    ./install

