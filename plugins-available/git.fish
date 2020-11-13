# git module

# aliases
alias pull="git pull"
alias push="git push -u origin head"
alias merge="git merge"
alias got="git"
alias what-to-release="git log master..develop --merges --oneline"
alias gitsearch="git br | grep"
alias git-cleanup="git branch --merged | grep -v \"\*\" | grep -v master | grep -v dev | xargs -n 1 git branch -d"
alias git-rank="git shortlog -sn --no-merges"

# go (to feature branch)
alias gco="git checkout"

function what-did-i-work-on-recently --description "List branches you were working on recently"
    set --local --unexport __git_email (git config --get-all user.email | tail -1)
    echo $__git_email worklog:
    git log --format="%ae %ad %s" --date=short -100 | grep $__git_email | grep -oE "[0-9\-]+ [A-Z]+-[0-9]+.*"
end

function what-i-stashed --description "Show a diff on first stash object"
    set --local --unexport __first_stash (git stash list | cut -d ":" -f1 | head -1)
    if [ "$__first_stash" != "" ]
        git stash show -p $__first_stash
    end
end

function git-short-history --description "Show a short history of what you've been doing on a branch" -a tick
    set --local --unexport __branch_request $argv[1]
    set --local --unexport __branch_default 'head'
    set --local --unexport __tick ""

    if [ "$tick" = "--tick" ]
        set __tick " [x]"
        set __branch_request $__branch_default
    end

    if [ "$__branch_request" = "" ]
        set --local --unexport __branch_check (git rev-parse "$__branch_default")
    else
        set --local --unexport __branch_check (git rev-parse "$__branch_request")
    end

    set --local --unexport __branch_parent (git show-branch -a $__branch_check 2> /dev/null | sed 's/^ *//g' | grep -v "^\*" | head -1 | sed 's/.*\[\(.*\)\].*/\1/' | sed 's/[\^~].*//')
    set --local --unexport __ticket_id_if (git log $__branch_check --format="%B" | grep -o -E "^[A-Z]+[- ][0-9]+" | head -1 | sed 's/^[ ]+//g;s/[ ]+$//g;')

    if [ "$__ticket_id_if" != "" ]
        set --local --unexport __branch_name_human (git branch --contains $__branch_check | sed "s/* //;s/feature\///;s/^\($__ticket_id_if\)-//;s/-/ /g")

        echo "$__ticket_id_if: $__branch_name_human"
        git log --format="%B" --no-merges $__branch_parent..$__branch_check --reverse | grep -E "^$__ticket_id_if" | sed -E "s/^$__ticket_id_if:* (.*)/-$__tick \u\1/"
    else
        git log --format="%B" --no-merges $__branch_parent..$__branch_check --reverse | grep -E -v '^[[:space:]]*$'
    end
end

function fixup --description "fixup commit"
    git add . && git ci -m "fixup"
end

function amend --description "amend last commit without edit"
    git add . && git ci --amend --no-edit
end