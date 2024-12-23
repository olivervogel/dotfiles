#--------------------------------------------------------------------------
# Create new tmux session based on current directory in default layout
#--------------------------------------------------------------------------
custom_tmux_create() {
    sessionname=$(custom_slugify $(basename $(pwd)))
    tmux -2 new-session -c $(pwd) -d -s $sessionname -x $(tput cols) -y $(tput lines)
    tmux split-window -h -c $(pwd) -l 70%
    tmux select-pane -L
    tmux split-window -v -c $(pwd)
    tmux select-pane -U
    tmux select-pane -R
    tmux -2 attach-session -t $sessionname
}

#--------------------------------------------------------------------------
# Create new tmux session based on current directory in 4x layout
#--------------------------------------------------------------------------
custom_tmux_create_triple() {
    sessionname=$(custom_slugify $(basename $(pwd)))
    tmux -2 new-session -c $(pwd) -d -s $sessionname -x $(tput cols) -y $(tput lines)
    tmux split-window -h -c $(pwd) -l 70%
    tmux select-pane -L
    tmux split-window -v -c $(pwd) -l 33%
    tmux select-pane -U
    tmux split-window -v -c $(pwd)
    tmux select-pane -U
    tmux select-pane -R
    tmux -2 attach-session -t $sessionname
}

#--------------------------------------------------------------------------
# Attach to given tmux session or select session with fzf
#--------------------------------------------------------------------------
custom_tmux_attach() { 
    if [ $1 ]; then
        tmux attach -t $1
    else
        selected=$(tmux ls|fzf)
        tmux attach -t $(echo $selected|cut -d ':' -f1)
    fi
}

#--------------------------------------------------------------------------
# Show git diff from given file or select file with fzf
#--------------------------------------------------------------------------
custom_git_diff_working_tree() {
    root=$(git rev-parse --show-toplevel)
    if [ $1 ]; then
        git diff HEAD -- $root/$1|delta
    else
        preview="git diff --color=always -- $root/{-1}|delta"
        selected=$(git diff --name-only | fzf -m --ansi --preview $preview)
        if [ $selected ]; then
            git diff HEAD -- $root/$selected|delta
        fi
    fi
}

#--------------------------------------------------------------------------
# Show git diff from given commit or select commit with fzf
#--------------------------------------------------------------------------
custom_git_diff_commit() {
    preview="git diff-tree --color=always -p {1}|delta"
    selected=$(git log --pretty=format:"%C(yellow)%h%Cblue%>(12)%ad %Cgreen%<(7)%aN%Cred%d %Creset%s" --date=short --no-merges|fzf -m --ansi --preview $preview)
    if [ $selected ]; then
        git show $(echo $selected|cut -c 1-7)
    fi
}

#--------------------------------------------------------------------------
# Show changed files of given commit or select commit with fzf
#--------------------------------------------------------------------------
custom_git_diff_commit_files() {
    preview="git diff-tree --no-commit-id --name-only {1} -r"
    selected=$(git log --pretty=format:"%C(yellow)%h%Cblue%>(12)%ad %Cgreen%<(7)%aN%Cred%d %Creset%s" --date=short --no-merges|fzf -m --ansi --preview $preview)
    if [ $selected ]; then
        git diff-tree --no-commit-id --name-only $(echo $selected|cut -c 1-7) -r
    fi
}

#--------------------------------------------------------------------------
# Show git commit history of given file
#--------------------------------------------------------------------------
custom_git_diff_file() {
    if [ $1 ]; then
        preview="git show --color=always {1}:$1|bat --color=always"
        selected=$(git log --follow --pretty=format:"%C(yellow)%h%Cblue%>(12)%ad %Cgreen%<(7)%aN%Cred%d %Creset%s" --date=short --no-merges -- $1|fzf -m --ansi --preview $preview)
        if [ $selected ]; then
            git diff $(echo $selected|cut -c 1-7)^..$(echo $selected|cut -v 1-7) $1
        fi
    fi
}

#--------------------------------------------------------------------------
# Checkout given git branch or select branch to checkout with fzf
#--------------------------------------------------------------------------
custom_git_checkout() {
    if [ $1 ]; then
        git checkout $1
    else
        preview="git diff --color=always -p {1}|delta"
        selected=$(git branch --sort=-committerdate|cut -c 3-|fzf --preview $preview)
        if [ $selected ]; then
            git checkout $selected
        fi
    fi
}

#--------------------------------------------------------------------------
# Merge given git branch or select branch to merge with fzf
#--------------------------------------------------------------------------
custom_git_merge() {
    if [ $1 ]; then
        git merge $1
    else
        selected=$(git branch|cut -c 3-|fzf)
        if [ $selected ]; then
            git merge $selected
        fi
    fi
}

#--------------------------------------------------------------------------
# Delete given git branch or select branch to delete with fzf
#--------------------------------------------------------------------------
custom_git_branch_delete() {
    if [ $1 ]; then
        git branch -d $1
    else
        selected=$(git branch|cut -c 3-|fzf)
        if [ $selected ]; then
            git branch -d $selected
        fi
    fi
}

#--------------------------------------------------------------------------
# Add given file to git index or select file with fzf
#--------------------------------------------------------------------------
custom_git_add() {
    root=$(git rev-parse --show-toplevel)
    if [ $1 ]; then
        git add $1
    else
        preview="git diff --color=always -- ./{-1}|delta"
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

#--------------------------------------------------------------------------
# Create git commit with given message or enter message with $EDITOR
#--------------------------------------------------------------------------
custom_git_commit() {
    if [ $1 ]; then
        git commit -m $1
    else
        git commit
    fi    
}

#--------------------------------------------------------------------------
# unused & undocumented
#--------------------------------------------------------------------------
custom_git_commit_append() {
    if [ $1 ]; then
        git commit --fixup=$1
        git rebase --interactive --autosquash $1^
    else
        preview="git diff-tree --color=always -p {1}|delta"
        selected=$(git log --pretty=format:"%C(yellow)%h%Cblue%>(12)%ad %Cgreen%<(7)%aN%Cred%d %Creset%s" --date=short --no-merges|fzf -m --ansi --preview $preview)
        commit=$(echo $selected|cut -c 1-7)
        git commit --fixup=$commit
        git rebase --interactive --autosquash $commit^
    fi
}

#--------------------------------------------------------------------------
# Restore given file or select file to restore with fzf
#--------------------------------------------------------------------------
custom_git_restore() {
    root=$(git rev-parse --show-toplevel)
    if [ $1 ]; then
        staged=$(git status -s|grep $1|cut -c 1)
        if [ $staged = 'M' ]; then
            git restore --staged $1
        else
            git restore --worktree $1
        fi
    else
        preview="git diff --color=always -- $root/{-1}|delta"
        selected=$(git status -uno --porcelain|cut -c 4-|fzf -m --ansi --preview $preview)
        if [ $selected ]; then
            my_array=($(echo $selected | tr "," "\n"))
            for string in $my_array
                do
                    staged=$(git diff --name-only --cached|grep $string)
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

#--------------------------------------------------------------------------
# Restore all unstaged modifications
#--------------------------------------------------------------------------
custom_git_restore_all() {
    git restore --stage --worktree .
}

#--------------------------------------------------------------------------
# Interactively rebase commits back to given number of commits
#--------------------------------------------------------------------------
custom_git_rebase() {
    if [ $1 ]; then
        git rebase -i HEAD~$1
    fi
}

#--------------------------------------------------------------------------
# Revert given git commit or select commit with fzf
#--------------------------------------------------------------------------
custom_git_revert() {
    if [ $1 ]; then
        git revert $1
    else
        preview="git diff-tree --color=always -p {1}|delta"
        selected=$(git log --pretty=format:"%C(yellow)%h%Cblue%>(12)%ad %Cgreen%<(7)%aN%Cred%d %Creset%s" --date=short --no-merges|fzf --ansi --preview $preview)
        if [ $selected ]; then
            git revert $(echo $selected|cut -c 1-7)
        fi
    fi    
}

#--------------------------------------------------------------------------
# Push current git branch to origin's branch with same name
#--------------------------------------------------------------------------
custom_git_push_current_branch_to_origin() {
    current_branch=$(git rev-parse --abbrev-ref HEAD)
    git push -u origin $current_branch
}

#--------------------------------------------------------------------------
# Pull current git branch from origin's branch with same name
#--------------------------------------------------------------------------
custom_git_pull_current_branch_to_origin() {
    current_branch=$(git rev-parse --abbrev-ref HEAD)
    git pull origin $current_branch
}

#--------------------------------------------------------------------------
# Zip given file or select files to archive with fzf
#--------------------------------------------------------------------------
custom_zip_selected() {
    if [ $# -eq 0 ]; then
        find * -type f|fzf -m|zip -r Archiv.zip -@
    else
        zip -r Archiv.zip $@
    fi
}

#--------------------------------------------------------------------------
# Generate random string with given length (default length: 20)
#--------------------------------------------------------------------------
custom_random_string() {
    if [ $1 ]; then
        length=$1
    else
        length=20
    fi

    openssl rand -base64 48 | sed "s/[^A-Za-z0-9]//g" | cut -c -$length
}

#--------------------------------------------------------------------------
# Generate "slug" from given string input
#--------------------------------------------------------------------------
custom_slugify () {
    echo "$1" | iconv -c -t ascii//TRANSLIT | sed -E 's/[~^]+//g' | sed -E 's/[^a-zA-Z0-9]+/-/g' | sed -E 's/^-+|-+$//g' | tr A-Z a-z
}

#--------------------------------------------------------------------------
# Copy password to clipboard via "passage" from given entry or select with fzf
#--------------------------------------------------------------------------
custom_passage_select_and_copy_password() {
    if [ $1 ]; then
        passage -c1 $@
    else
        count=$(($(realpath ~/.passage/store | wc -c) + 1))
        selected=$(find ~/.passage/store -type f -name "*.age" |cut -c $count- |rev |cut -c 5- |rev|fzf)
        if [ $selected ]; then
            passage -c1 $selected
        fi
    fi
}

#--------------------------------------------------------------------------
# Copy username to clipboard via "passage" from given entry or select with fzf
#--------------------------------------------------------------------------
custom_passage_select_and_copy_username() {
    if [ $1 ]; then
        name=$(passage show $@|grep username|cut -c 11-)
        if [ $name ]; then
            echo $name|pbcopy
            printf "Copied username for $@ to clipboard.\n"
        else
            printf "No username for $@ found.\n"
        fi
    else
        count=$(($(realpath ~/.passage/store | wc -c) + 1))
        selected=$(find ~/.passage/store -type f -name "*.age" |cut -c $count- |rev |cut -c 5- |rev|fzf)
        if [ $selected ]; then
            name=$(passage show $selected|grep username|cut -c 11-)
            if [ $name ]; then
                echo $name|pbcopy
                printf "Copied username for $selected to clipboard.\n"
            else
                printf "No username for $selected found.\n"
            fi
        fi
    fi
}

#--------------------------------------------------------------------------
# Output password via "pass" from given entry or select with fzf
#--------------------------------------------------------------------------
custom_passage_select_and_show_password() {
    if [ $1 ]; then
        passage show $@
    else
        count=$(($(realpath ~/.passage/store | wc -c) + 1))
        selected=$(find ~/.passage/store -type f -name "*.age" |cut -c $count- |rev |cut -c 5- |rev|fzf)
        if [ $selected ]; then
            passage show $selected
        fi
    fi
}

#--------------------------------------------------------------------------
# Generate 2fa code from given entry and copy to clipboard or select via fzf
#--------------------------------------------------------------------------
custom_2fa() {
    if [ $1 ]; then
        secret=$(passage show $@|grep 2fa_secret|cut -c 13-)
        if [ $secret ]; then
            code=$(oathtool --totp --base32 $secret)
            echo $code|pbcopy
            printf "Copied 2FA code $code for $@ to clipboard.\n"
        else
            printf "No 2FA secret found for $@.\n"
        fi
    else
        count=$(($(realpath ~/.passage/store | wc -c) + 1))
        selected=$(find ~/.passage/store -type f -name "*.age" |cut -c $count- |rev |cut -c 5- |rev|fzf)
        if [ $selected ]; then
            secret=$(passage show $selected|grep 2fa_secret|cut -c 13-)
            if [ $secret ]; then
                code=$(oathtool --totp --base32 $secret)
                echo $code|pbcopy
                printf "Copied 2FA code $code for $selected to clipboard.\n"
            else
                printf "No 2FA secret found for $selected.\n"
            fi
        fi
    fi
}

#--------------------------------------------------------------------------
# Show weather of given loaction (default: "Kiel")
#--------------------------------------------------------------------------
custom_wetter() {
    if [ $1 ]; then
        curl http://wttr.in/$@
    else
        curl 'http://wttr.in/Kiel?m&lang=de'
    fi
}

#--------------------------------------------------------------------------
# Open broser with git respository host (i.e. GitHub, Bitbucket etc.) of current folder
#--------------------------------------------------------------------------
custom_brep() {
    origin=$(git remote -v|grep "origin"|grep "(fetch)")
    regex="git@(.+):(.+)/(.+)\.git"

    if [[ "$origin" =~ $regex ]]; then
        host="${match[1]}"
        project="${match[2]}"
        repo="${match[3]}"

        case $host in
            "bitbucket.org"|"github.com")
                open "https://$host/$project/$repo/"
                ;;
            *)
                echo "Can not build uri from host $host"
                ;;
        esac
    else
        echo "Error: Unable to parse the git origin."
    fi
}

#--------------------------------------------------------------------------
# Create new timewwarrior entry with given tag or select tag with fzf
#--------------------------------------------------------------------------
custom_timewarrior_create() {
    if [ $1 ]; then
        timew start $@
    else
        selected=$(cat ~/.local/share/timewarrior/data/tags.data|jq -r 'keys[] | if test(" ") then "\"\(.)\"" else . end'|fzf -m)
        if [ $selected ]; then
            # echo $selected | xargs timew start
            tags_in_one_line=($(echo $selected | tr "," "\n"))
            print -z "timew start $tags_in_one_line" # display only
        fi
    fi
}

#--------------------------------------------------------------------------
# Create backup
#--------------------------------------------------------------------------
custom_backup() {
    restic backup --skip-if-unchanged --files-from ~/.config/restic/backup_files_from
    restic forget --prune --keep-last 2
}

#--------------------------------------------------------------------------
# Switch suspended application to foreground
#--------------------------------------------------------------------------
custom_fg() {
    fg
}

#--------------------------------------------------------------------------
# Get info on given ip (own ip by default)
#--------------------------------------------------------------------------
custom_ipinfo() {
    if [ $1 ]; then
        curl -s https://ipinfo.io/$@/json|jq
    else
        curl -s https://ipinfo.io/json|jq
    fi
}

#--------------------------------------------------------------------------
# Show statistics of the most used commands
#--------------------------------------------------------------------------
custom_zsh_stats() {
    history 1 | awk '{CMD[$2]++;count++;}END { for (a in CMD)print CMD[a] " " CMD[a]/count*100 "% " a;}' | grep -v "./" | column -c3 -s " " -t | sort -nr | nl |  head -n10
}
