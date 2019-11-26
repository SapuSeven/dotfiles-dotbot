function fish_prompt --description 'Write out the prompt'
    set -l color_cwd
    set -l color_user
    set -l color_host
    set -l suffix
    switch "$USER"
        case root toor
            set color_cwd $fish_color_cwd_root
            set color_user $fish_color_user_root
            set color_host $fish_color_host_root
            set suffix '#'
        case '*'
            set color_cwd $fish_color_cwd
            set color_user $fish_color_user
            set color_host $fish_color_host
            set suffix '>'
    end

    echo -n -s (set_color -o) (set_color $color_user) "$USER" @ (set_color $color_host) (prompt_hostname) ' ' (set_color $color_cwd) (prompt_pwd) (set_color $color_host) "$suffix "
end
