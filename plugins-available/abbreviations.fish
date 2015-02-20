alias lh="ls -hal"
alias grep="grep --color=auto"
alias findf="find . -type f | xargs sed 's/^\.\///g;s/: / :/g'"
alias findd="find . -type d | xargs sed 's/^\.\///g;s/: / :/g'"
alias findphp="find . -type f -name \"*.php\" | sed 's/^\.\///g;s/: / :/g' | xargs grep --color=auto -n"
alias findinphp="find . -type f -name \"*.php\" | sed 's/^\.\///g;s/: / :/g' | xargs grep --color=auto -n"
alias findphtml="find . -type f -name \"*.phtml\" | sed 's/^\.\///g;s/: / :/g' | xargs grep --color=auto -n"
alias findxml="find . -type f -name \"*.xml\" | xargs grep --color=auto -n"
# alias what-did-i-work-on-recently='git log --format="%ae %ad %s" --date=short -100 | grep "$__git_email" | grep -oE "[0-9\-]+ [A-Z]+-[0-9]+.*"'
alias runningvms='VBoxManage list runningvms | cut -d " " -f 1'
alias stopallvms='VBoxManage list runningvms | cut -d " " -f 1 | xargs -J % VBoxManage controlvm % savestate'
function what-did-i-work-on-recently --description "List branches you were working on recently"
  set --local --unexport __git_email (git config --get-all user.email | tail -1)
  echo $__git_email worklog:
  git log --format="%ae %ad %s" --date=short -100 | grep $__git_email | grep -oE "[0-9\-]+ [A-Z]+-[0-9]+.*"
end
