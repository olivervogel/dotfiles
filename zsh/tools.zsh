# z - jump around
if [ -f ~/.zsh/pack/z/z.sh ]; then
    . ~/.zsh/pack/z/z.sh
fi

# powerlevel10k
if [ -f ~/.zsh/pack/powerlevel10k/powerlevel10k.zsh-theme ]; then
    source ~/.zsh/pack/powerlevel10k/powerlevel10k.zsh-theme
fi

# powerlevel10k
if [ -f ~/.p10k.zsh ]; then
    source ~/.p10k.zsh
fi

# fuzzy finder
if [ -f ~/.fzf.zsh ]; then
    source ~/.fzf.zsh
fi

# zsh history substr search
if [ -f ~/.zsh/pack/zsh-history-substring-search/zsh-history-substring-search.zsh ]; then
    source ~/.zsh/pack/zsh-history-substring-search/zsh-history-substring-search.zsh
fi

# asdf
if [ -f /opt/homebrew/opt/asdf/libexec/asdf.sh ]; then
    . /opt/homebrew/opt/asdf/libexec/asdf.sh
fi

# enable git autocompletion
autoload -Uz compinit && compinit
