The dotfiles should work on any Arch-based system.

## Used packages

    sudo pacman -Syu xorg rxvt-unicode pcmanfm i3lock-color rofi nitrogen
    yay -S xcursor-breeze

### Custom packages

    sudo pacman -Syu i3lock-custom

First you need to modify `/etc/pacman.conf` and add the following lines at the bottom:

    [sapuseven]
    SigLevel = Never
    Server = https://repo.sapuseven.com/$arch

# Automatic installation

This will place all customized dotfiles inside `~/.dotfiles` and symlink accordingly.

    git clone https://github.com/SapuSeven/dotfiles.git ~/.dotfiles
    cd ~/.dotfiles
    ./install


# Manual installation (deprecated)

This will clone the dotfiles directly to your home directory.

Use `config` instead of `git` anywhere to manage the repository.

    pacman -Syu --needed --noconfirm git

    git clone --bare https://github.com/SapuSeven/dotfiles.git $HOME/.dotfiles
    alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
    config checkout
    config config --local status.showUntrackedFiles no
    
