function fish_prompt -d "Write out the prompt"
    # This shows up as USER@HOST /home/user/ >, with the directory colored
    # $USER and $hostname are set by fish, so you can just use them
    # instead of using `whoami` and `hostname`
    printf '%s@%s %s%s%s > ' $USER $hostname \
        (set_color $fish_color_cwd) (prompt_pwd) (set_color normal)
end

if status is-interactive
    # All commands that produce output go here
    # e.g., fish_greeting, neofetch, etc.
    set -g fish_greeting ""
end

if not status is-interactive
    exit
end

# if status is-interactive
#     # Commands to run in interactive sessions can go here
#     set fish_greeting
#
# end

starship init fish | source
if test -f ~/.local/state/quickshell/user/generated/terminal/sequences.txt
    cat ~/.local/state/quickshell/user/generated/terminal/sequences.txt
end

alias pamcan pacman
alias ls 'eza --icons'
alias tree 'exa -T --level=3 --icons'
alias vim nvim
alias lg lazygit

function y
    set tmp (mktemp -t "yazi-cwd.XXXXXX")
    yazi $argv --cwd-file="$tmp"
    if read -z cwd <"$tmp"; and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
        builtin cd -- "$cwd"
    end
    rm -f -- "$tmp"
end

# Fallback: Add standard paths to PATH just in case, but the function handles the rest.
if test -d $HOME/anaconda3/condabin
    fish_add_path $HOME/anaconda3/condabin
end
if test -d $HOME/.cache/conda/condabin
    fish_add_path $HOME/.cache/conda/condabin
end

zoxide init fish | source

# function fish_prompt
#   set_color cyan; echo (pwd)
#   set_color green; echo '> '
# end
