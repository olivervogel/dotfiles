bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
bindkey '^[^?' backward-kill-word
bindkey '^[' vi-cmd-mode
bindkey '^Z' custom_fg

tmuxpane-down() { tmux select-pane -D }
tmuxpane-up() { tmux select-pane -U }
tmuxpane-left() { tmux select-pane -L }
tmuxpane-right() { tmux select-pane -R }

zle -N tmuxpane-down
zle -N tmuxpane-up
zle -N tmuxpane-left
zle -N tmuxpane-right
zle -N custom_fg

# edit line in $EDITOR with ctrl-e
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line
bindkey '^P' fzf-file-widget
