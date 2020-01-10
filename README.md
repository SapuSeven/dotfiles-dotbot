The dotfiles should work on any Arch-based system.

<!--# Automatic installation using my pacman repository

1. Modify `/etc/pacman.conf` and add the following lines:

    [sapuseven]
    SigLevel = Never
    Server = http://repo.sapuseven.com/$arc-->


# Manually install the dotfiles on a new machine

    pacman -Syu --needed --noconfirm git

    git clone --bare https://github.com/SapuSeven/dotfiles.git $HOME/.dotfiles
    alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
    config checkout
    config config --local status.showUntrackedFiles no
    
