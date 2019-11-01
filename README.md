# How to use the dotfiles on a new machine

    eval $(ssh-agent)
    ssh-add .ssh/com.github.sapuseven
    
    git clone --bare git@github.com:SapuSeven/dotfiles.git $HOME/.dotfiles
    alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
    config checkout
    config config --local status.showUntrackedFiles no
    
