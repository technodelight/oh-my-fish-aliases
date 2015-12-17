alias lh="ls -hal"
alias grep="grep --color=auto"
alias findf="find . -type f | xargs sed 's/^\.\///g;s/: / :/g'"
alias findd="find . -type d | xargs sed 's/^\.\///g;s/: / :/g'"
alias findphp="find . -type f -name \"*.php\" | sed 's/^\.\///g;s/: / :/g' | xargs grep --color=auto -n"
alias findinphp="find . -type f -name \"*.php\" | sed 's/^\.\///g;s/: / :/g' | xargs grep --color=auto -n"
alias findphtml="find . -type f -name \"*.phtml\" | sed 's/^\.\///g;s/: / :/g' | xargs grep --color=auto -n"
alias findxml="find . -type f -name \"*.xml\" | xargs grep --color=auto -n"
alias runningvms='VBoxManage list runningvms | cut -d " " -f 1'
alias stopallvms='VBoxManage list runningvms | cut -d " " -f 1 | xargs -J % VBoxManage controlvm % savestate'
alias behat-debug-screens="ls -1 failure_*.png | xargs open"
alias behat-debug-reset="ls -1 failure_*.png debug_times-*.csv | xargs rm"
alias what-is-my-ip="curl -s checkip.dyndns.org | sed -e 's/.*Current IP Address: //' -e 's/<.*\$//'"
alias subdirs-disk-space="du -h . | grep '\./[a-z.-]*\$'"