_tmux_create() {
    sessionname=$(_slugify $(basename $(pwd)))
    tmux -2 new-session -c $(pwd) -d -s $sessionname -x $(tput cols) -y $(tput lines)
    tmux split-window -h -c $(pwd) -l 70%
    tmux select-pane -L
    tmux split-window -v -c $(pwd)
    tmux select-pane -U
    tmux select-pane -R
    tmux -2 attach-session -t $sessionname
}

_tmux_attach() { 
    if [ $1 ]; then
        tmux attach -t $1
    else
        selected=$(tmux ls|fzf)
        tmux attach -t $(echo $selected|cut -d ':' -f1)
    fi
}

_git_diff_working_tree() {
    root=$(git rev-parse --show-toplevel)
    if [ $1 ]; then
        git diff HEAD -- $root/$1
    else
        preview="git diff --color=always -- $root/{-1}"
        selected=$(git diff --name-only | fzf -m --ansi --preview $preview)
        if [ $selected ]; then
            git diff HEAD -- $root/$selected
        fi
    fi
}

_git_diff_commit() {
    preview="git diff-tree --color=always -p {1}"
    selected=$(git log --pretty=format:"%C(yellow)%h%Cblue%>(12)%ad %Cgreen%<(7)%aN%Cred%d %Creset%s" --date=short --no-merges|fzf -m --ansi --preview $preview)
    if [ $selected ]; then
        git show $(echo $selected|cut -c 1-7)
    fi
}

_git_checkout() {
    if [ $1 ]; then
        git checkout $1
    else
        selected=$(git branch|cut -c 3-|fzf)
        if [ $selected ]; then
            git checkout $selected
        fi
    fi
}

_git_add() {
    root=$(git rev-parse --show-toplevel)
    if [ $1 ]; then
        git add $1
    else
        preview="git diff --color=always -- ./{-1}"
        selected=$(git ls-files --modified --others --exclude-standard $root|fzf -m --ansi --preview $preview)
        if [ $selected ]; then
            my_array=($(echo $selected | tr "," "\n"))
            for string in $my_array
                do
                    git add $string
                done
        fi
    fi
}

_git_commit() {
    if [ $1 ]; then
        git commit -m $1
    else
        git commit
    fi    
}

_git_commit_append() {
    if [ $1 ]; then
        git commit --fixup=$1
        git rebase --interactive --autosquash $1^
    else
        preview="git diff-tree --color=always -p {1}"
        selected=$(git log --pretty=format:"%C(yellow)%h%Cblue%>(12)%ad %Cgreen%<(7)%aN%Cred%d %Creset%s" --date=short --no-merges|fzf -m --ansi --preview $preview)
        commit=$(echo $selected|cut -c 1-7)
        git commit --fixup=$commit
        git rebase --interactive --autosquash $commit^
    fi
}

_git_restore() {
    root=$(git rev-parse --show-toplevel)
    if [ $1 ]; then
        staged=$(git status -s|grep $1|cut -c 1)
        if [ $staged = 'M' ]; then
            git restore --staged $1
        else
            git restore --worktree $1
        fi
    else
        preview="git diff --color=always -- $root/{-1}"
        selected=$(git status -uno --porcelain|cut -c 4-|fzf -m --ansi --preview $preview)
        if [ $selected ]; then
            my_array=($(echo $selected | tr "," "\n"))
            for string in $my_array
                do
                    staged=$(git diff --name-only --cached|grep $string)
                    # staged=$(git status -s|grep $string|cut -c 1)
                    if [ ${#staged} -ge 1 ]; then
                        # staged
                        git restore --staged $root/$string
                    else
                        # worktree
                        git restore --worktree $root/$string
                    fi
                done
        fi
    fi       
}

_git_restore_all() {
    git restore --stage --worktree .
}

_git_revert() {
    preview="git diff-tree --color=always -p {1}"
    selected=$(git log --pretty=format:"%C(yellow)%h%Cblue%>(12)%ad %Cgreen%<(7)%aN%Cred%d %Creset%s" --date=short --no-merges|fzf --ansi --preview $preview)
    if [ $selected ]; then
        git revert $(echo $selected|cut -c 1-7)
    fi
}

_zip_selected() {
    if [ $# -eq 0 ]; then
        find * -type f|fzf -m|zip -r Archiv.zip -@
    else
        zip -r Archiv.zip $@
    fi
}

_random_string() {
    if [ $1 ]; then
        length=$1
    else
        length=20
    fi

    openssl rand -base64 48 | sed "s/[^A-Za-z0-9]//g" | cut -c -$length
}

_slugify () {
    echo "$1" | iconv -c -t ascii//TRANSLIT | sed -E 's/[~^]+//g' | sed -E 's/[^a-zA-Z0-9]+/-/g' | sed -E 's/^-+|-+$//g' | tr A-Z a-z
}

_ctags_create_php () {
    ctags --tag-relative=yes -R --fields=+aimlS --languages=php --PHP-kinds=+cdfint-av --exclude="\.git" --exclude="node_modules"
}

_tree_view () {
    if [ $1 ]; then
        treepath=$1
    else
        treepath="./"
    fi

    if [ $2 ]; then
        treedepth=$2
    else
        treedepth=2
    fi

    exa -a -T -L $treedepth $treepath
}

_docker_shell () {
    docker-compose exec projects "/bin/zsh" -l
}

_mix_search() {
    if [ $1 ]; then
        mix $1
    else
        line=$(mix help|fzf)
        if [ $line ]; then
            $(echo $line|cut -d '#' -f1)
        fi
    fi
}

