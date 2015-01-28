alias lh="ls -hal"
alias grep="grep --color=auto"
alias findf="find . -type f"
alias findd="find . -type d"
alias findphp="find . -type f -name \"*.php\""
alias findinphp='find . -type f -name "*.php" | xargs grep --color=auto -n'
alias findphtml="find . -type f -name \"*.phtml\" | xargs grep --color=auto -n"
alias findxml="find . -type f -name \"*.xml\" | xargs grep --color=auto -n"
alias what-did-i-work-on-recently='git log --format="%ae %ad %s" --date=short -100 | grep "zsolt.gal@sessiondigital.com" | grep -oE "[0-9\-]+ [A-Z]+-[0-9]+.*"'
alias runningvms='VBoxManage list runningvms | cut -d " " -f 1'
alias stopallvms='VBoxManage list runningvms | cut -d " " -f 1 | xargs -J % VBoxManage controlvm % savestate'
alias pull="git pull"
alias push="git push origin head"
alias merge="git merge"
alias got="git"
alias go="git checkout"
