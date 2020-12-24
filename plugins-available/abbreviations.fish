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
alias what-is-my-ip="dig -4 @ns1.google.com TXT o-o.myaddr.l.google.com +short | sed 's/\"//g'"
alias subdirs-disk-space="du -h . | grep '\./[a-z.-]*\$'"
alias hobo="hem"
alias mem-per-process="echo -e \"%mem\tpid\tuser\tcommand\"; and ps -eo \%mem,pid,user,command -m | sort -nk1 | tail -10r"
alias cpu-per-process="echo -e \"%cpu\tpid\tuser\tcommand\"; and ps -eo \%cpu,pid,user,command -m | sort -nk1 | tail -10r"
alias stop-bluetooth='sudo kextunload -b com.apple.iokit.BroadcomBluetoothHostControllerUSBTransport'
alias start-bluetooth='sudo kextload -b com.apple.iokit.BroadcomBluetoothHostControllerUSBTransport'
if test (uname) = "Linux"
    alias cat="batcat"
else
    alias cat="bat"
end
alias which-docker="docker ps | egrep -o '(heidelberg|vaa|nutri|talkmobile)' | uniq"

function jira-release-complexity --description 'show release complexity based on story points from jira'
    set --unexport --local releaseVersion $argv
    jira search "labels in ('$releaseVersion')" --points | grep story | cut -d: -f2 | awk '{n += $1}; END{print n}'
end

function jira-release-estimates --description 'show total estimates in hours for a release from jira'
    set --unexport --local releaseVersion $argv
    jira search "labels in ('$releaseVersion')" --estimates | grep estimate | cut -d: -f2- | awk '{n += $1}; END{print n}' | awk 'END{print $1/60/60 " hours"}'
end

function jira-time-spent --description 'show total time spent in days based on a JQL search'
    set --unexport --local query $argv
    jira search "$query" --spent | grep spent | cut -d: -f2 | awk '{n += $1}; END{print n}' | awk 'END{print $1/60/60/8 " days"}'
end

function jira-time-estimates --description 'show total estimates in days based on a JQL search'
    set --unexport --local query $argv
    jira search "$query" --estimates | grep estimate | cut -d: -f2- | awk '{n += $1}; END{print n}' | awk 'END{print $1/60/60/8 " days"}'
end

function large-files --description 'show largest files with xattrs'
    find . -type f -exec du -c '{}' + | sort -n -k1 | tail -100 | cut -f2 | grep -v '^total$' | tr "\n" "\0" | xargs -0 tag -l
end

function nl2comma --description 'convert new line separated list into list separated by commas'
    tr "\n" , | sed 's~,~, ~g;s~, $~~'
end

function git-sum-logs --description 'show summarised logs on commit range'
    set --unexport --local range (test ! -z "$argv"; and echo $argv; or echo "HEAD~1..HEAD")
    git log $range | grep '^\s*-' | sed -E 's~\s+- ~- ~g' | grep -v '^$' | sort | uniq; and git log $range --format="%s" | sed 's~^.*~- \0~g' | grep -v '^$' | sort | uniq
end

function undash --description 'get rid of row leading dashes'
    sed -E 's~\s*- ~~g'
end

function trim --description 'trim leading/trailing spaces'
    sed -E 's~^ +~~g;s~ +$~~g'
end

function strip-whitespace --description 'remove unnecessary whitespaces'
    sed -E 's~[ ]{1,}~ ~g'
end

function ssl-cert-debug --description 'show details on SSL certs'
    set --unexport --local domain $argv[1]
    set --unexport --local sni $argv[2]
    if test "$sni" = ""
        set sni "$domain"
    end
    echo | openssl s_client -showcerts -servername "$sni" -connect "$domain:443" 2>/dev/null | openssl x509 -inform pem -noout -text
end
