bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
bindkey '^[^?' backward-kill-word

tmuxpane-down() { tmux select-pane -D }
tmuxpane-up() { tmux select-pane -U }
tmuxpane-left() { tmux select-pane -L }
tmuxpane-right() { tmux select-pane -R }

zle -N tmuxpane-down
zle -N tmuxpane-up
zle -N tmuxpane-left
zle -N tmuxpane-right

bindkey '^[[1;5B' tmuxpane-down
bindkey '^[[1;5A' tmuxpane-up
bindkey '^[[1;5D' tmuxpane-left
bindkey '^[[1;5C' tmuxpane-right

bindkey '^[[1;3B' tmuxpane-down
bindkey '^[[1;3A' tmuxpane-up
bindkey '^[[1;3D' tmuxpane-left
bindkey '^[[1;3C' tmuxpane-right
