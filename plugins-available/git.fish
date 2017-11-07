# git module

# aliases
alias pull="git pull"
alias push="git push origin head"
alias merge="git merge"
alias got="git"
alias what-to-release="git log master..develop --merges --oneline"
alias gitsearch="git br | grep"
alias git-cleanup="git branch --merged | grep -v \"\*\" | grep -v master | grep -v dev | xargs -n 1 git branch -d"
alias git-rank="git shortlog -sn --no-merges"

# go (to feature branch)
alias go="git checkout"

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

# Change to a Branch
function gitgo --description 'Change to a feature branch'
	set --unexport --local __local_branch (git branch | grep $argv | head -1 | cut -c3-)
	set --unexport --local __remote_branch (git branch -r | grep $argv | head -1 | cut -c3-)
    set --unexport --local __is_active (git branch | grep $argv | head -1 | cut -c1)
    if [ "$__is_active" = "*" ]
        echo "Going to branch... Wait, you are already here ;)"
	else if [ "$__local_branch" != "" ]
        __gitgo_pull_or_checkout $__local_branch
    else if [ "$__remote_branch" != "" ]
        __gitgo_pull_or_checkout $__remote_branch
	end
end

function __gitgo_pull_or_checkout
    set --unexport --local __remote_branch (git branch -r | cut -c3- | grep $argv[1] | head -1)
    set --unexport --local __local_branch (echo $__remote_branch | cut -d "/" -f2-)
    set --unexport --local __branch $argv[1]

    # check if branch exists locally, if not, create
    if [ "$__remote_branch" != "" ]
        set __branch $__local_branch
        set --unexport --local __is_exists (git show-ref refs/heads/$__branch)
        if [ "$__is_exists" = "" ]
            echo "creating new branch $__local_branch with remote set to $__remote_branch"
            git checkout -b $__local_branch $__remote_branch
            return 0;
        end
    end

    git checkout $__branch
    if [ "$__remote_branch" != "" ]
        set --unexport --local __remote_name (echo $__remote_branch | cut -d "/" -f1)
        git pull $__remote_name $__local_branch
    end

    return 0;
end

function __gitgo_needs_feature
    for __branchname in (git branch | grep feature | sed 's/.*feature\///g')
    	set --unexport --local __has_issue_number (echo "$__branchname" | grep -E "^[A-Z]+[- ][0-9]+" -o)
    	if [ "$__has_issue_number" != "" ]
    		set --unexport --local __ticketid (echo $__has_issue_number | sed 'y/ /-/')
    		set --unexport --local __description (echo "$__branchname" | sed 's/$__ticketid//g;s/^[ ]+//g;s/[ ]+$//g;y/-/ /')
        	echo "$__ticketid $__description"
        end
    end
    return 0;
end

complete -c gitgo -x -a '(__gitgo_needs_feature)' -d 'feature'
