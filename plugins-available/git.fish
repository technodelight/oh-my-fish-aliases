# git module

# aliases
alias pull="git pull"
alias push="git push origin head"
alias merge="git merge"
alias got="git"

# go (to feature branch)
alias go="git checkout"
# function ggo --description 'Change to a branch'
# 	set --unexport --local __branch (git branch | grep $argv)
# 	if test $__branch -neq ""
# 		git checkout $__branch
# 	end
# end

# complete -f -c ggo -e
# for __branchname in (git branch | grep feature | sed 's/.*feature\///g')
# 	set __has_issue_number (echo "$__branchname" | grep -E "^[A-Z]+ [0-9]+" -o)
# 	if $__has_issue_number
# 		set __ticketid (echo $__has_issue_number | sed 'y/ /-/')
# 		set __description (echo "$__branchname" | sed 's/$__has_issue_number//g;s/^ //g;s/ $//g')
#     	complete -f -c ggo -A -a $__ticketid -d $__description
#     else
#     	complete -f -c ggo -A -a $__branchname -d 'checkout here'
# 	end
# end
# alias go="ggo"

# gget (pull remote branch w/ tracking and checkout)
