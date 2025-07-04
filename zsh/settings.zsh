export LANG=en_US.UTF-8
export WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'

export PATH=/usr/local/bin:$PATH
export PATH=~/.composer/vendor/bin:$PATH
export PATH=~/bin:$PATH
export PATH=~/.dotfiles/zsh/bin:$PATH
export PATH=/opt/homebrew/bin:$PATH

export EDITOR=nvim
export VISUAL=nvim

export KEYTIMEOUT=1

export BAT_THEME="Solarized (dark)"

export GPG_TTY=$(tty)

HISTFILE=~/.cache/zsh/history
HISTSIZE=10000000
SAVEHIST=10000000
HISTORY_IGNORE="(ls|cd|pwd|exit|cd)*"
setopt SHARE_HISTORY

setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_FIND_NO_DUPS
setopt HIST_SAVE_NO_DUPS

setopt NO_BEEP

export EXA_COLORS="\
fi=38;5;110:\
di=38;5;39;1:\
da=38;5;238:\
uu=38;5;245:\
un=38;5;240:\
gu=38;5;245:\
gn=38;5;240\
"

HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND=fg=white,bold,underline
HISTORY_SUBSTRING_SEARCH_FUZZY=1
HISTORY_SUBSTRING_SEARCH_ENSURE_UNIQUE=1

# passage config
export PASSAGE_RECIPIENTS_FILE="$HOME/.passage/recipients"
export PASSAGE_IDENTITIES_FILE="$HOME/.passage/identities"
export PASSWORD_STORE_GENERATED_LENGTH=50

# restic config
export RESTIC_REPOSITORY="/Volumes/Backup/restic"
export RESTIC_PASSWORD_COMMAND="passage show restic_backup"

# docker config
export COMPOSE_MENU=0
