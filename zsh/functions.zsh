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

custom_tmux_attach() { 
    if [ $1 ]; then
        tmux attach -t $1
    else
        selected=$(tmux ls|fzf)
        tmux attach -t $(echo $selected|cut -d ':' -f1)
    fi
}

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

custom_git_diff_commit() {
    preview="git diff-tree --color=always -p {1}|delta"
    selected=$(git log --pretty=format:"%C(yellow)%h%Cblue%>(12)%ad %Cgreen%<(7)%aN%Cred%d %Creset%s" --date=short --no-merges|fzf -m --ansi --preview $preview)
    if [ $selected ]; then
        git show $(echo $selected|cut -c 1-7)
    fi
}

custom_git_diff_commit_files() {
    preview="git diff-tree --no-commit-id --name-only {1} -r"
    selected=$(git log --pretty=format:"%C(yellow)%h%Cblue%>(12)%ad %Cgreen%<(7)%aN%Cred%d %Creset%s" --date=short --no-merges|fzf -m --ansi --preview $preview)
    if [ $selected ]; then
        git diff-tree --no-commit-id --name-only $(echo $selected|cut -c 1-7) -r
    fi
}

custom_git_diff_file() {
    if [ $1 ]; then
        preview="git show --color=always {1}:$1|bat --color=always"
        selected=$(git log --follow --pretty=format:"%C(yellow)%h%Cblue%>(12)%ad %Cgreen%<(7)%aN%Cred%d %Creset%s" --date=short --no-merges -- $1|fzf -m --ansi --preview $preview)
        if [ $selected ]; then
            git diff $(echo $selected|cut -c 1-7)^..$(echo $selected|cut -v 1-7) $1
        fi
    fi
}

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

custom_git_commit() {
    if [ $1 ]; then
        git commit -m $1
    else
        git commit
    fi    
}

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

custom_git_restore_all() {
    git restore --stage --worktree .
}

custom_git_rebase() {
    if [ $1 ]; then
        git rebase -i HEAD~$1
    fi
}


custom_git_revert() {
    preview="git diff-tree --color=always -p {1}|delta"
    selected=$(git log --pretty=format:"%C(yellow)%h%Cblue%>(12)%ad %Cgreen%<(7)%aN%Cred%d %Creset%s" --date=short --no-merges|fzf --ansi --preview $preview)
    if [ $selected ]; then
        git revert $(echo $selected|cut -c 1-7)
    fi
}

custom_git_push_current_branch_to_origin() {
    current_branch=$(git rev-parse --abbrev-ref HEAD)
    git push -u origin $current_branch
}

custom_git_pull_current_branch_to_origin() {
    current_branch=$(git rev-parse --abbrev-ref HEAD)
    git pull origin $current_branch
}

custom_zip_selected() {
    if [ $# -eq 0 ]; then
        find * -type f|fzf -m|zip -r Archiv.zip -@
    else
        zip -r Archiv.zip $@
    fi
}

custom_random_string() {
    if [ $1 ]; then
        length=$1
    else
        length=20
    fi

    openssl rand -base64 48 | sed "s/[^A-Za-z0-9]//g" | cut -c -$length
}

custom_slugify () {
    echo "$1" | iconv -c -t ascii//TRANSLIT | sed -E 's/[~^]+//g' | sed -E 's/[^a-zA-Z0-9]+/-/g' | sed -E 's/^-+|-+$//g' | tr A-Z a-z
}

custom_convert_hex_color() {
  hex=$1
  if [[ $hex == "#"* ]]; then
    hex=$(echo $1 | awk '{print substr($0,2)}')
  fi
  r=$(printf '0x%0.2s' "$hex")
  g=$(printf '0x%0.2s' ${hex#??})
  b=$(printf '0x%0.2s' ${hex#????})
  echo -e `printf "%03d" "$(((r<75?0:(r-35)/40)*6*6+(g<75?0:(g-35)/40)*6+(b<75?0:(b-35)/40)+16))"`
}

custom_pass_select_and_copy_password() {
    if [ $1 ]; then
        pass show -c $@
    else
        count=$(($(realpath ~/.password-store | wc -c) + 1))
        selected=$(find ~/.password-store -type f -name "*.gpg" |cut -c $count- |rev |cut -c 5- |rev|fzf)
        if [ $selected ]; then
            pass show -c $selected
        fi
    fi
}

custom_pass_select_and_show_password() {
    if [ $1 ]; then
        pass show $@
    else
        count=$(($(realpath ~/.password-store | wc -c) + 1))
        selected=$(find ~/.password-store -type f -name "*.gpg" |cut -c $count- |rev |cut -c 5- |rev|fzf)
        if [ $selected ]; then
            pass show $selected
        fi
    fi
}

custom_2fa() {
    if [ $1 ]; then
        secret=$(pass show $@|grep 2fa|cut -c 13-)
        if [ $secret ]; then
            code=$(oathtool --totp --base32 $secret)
            echo $code|pbcopy
            printf "Copied 2FA code $code for $@ to clipboard.\n"
        else
            printf "No 2FA secret found for $@.\n"
        fi
    else
        count=$(($(realpath ~/.password-store | wc -c) + 1))
        selected=$(find ~/.password-store -type f -name "*.gpg" |cut -c $count- |rev |cut -c 5- |rev|fzf)
        if [ $selected ]; then
            secret=$(pass show $selected|grep 2fa|cut -c 13-)
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

custom_wetter() {
    if [ $1 ]; then
        curl http://wttr.in/$@
    else
        curl 'http://wttr.in/Kiel?m&lang=de'
    fi
}

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

custom_backup() {
    restic backup --skip-if-unchanged --files-from ~/.config/restic/backup_files_from && restic forget --prune --keep-last 2

}

custom_fg() {
    fg
}

custom_ipinfo() {
    if [ $1 ]; then
        curl -s https://ipinfo.io/$@/json|jq
    else
        curl -s https://ipinfo.io/json|jq
    fi
}
