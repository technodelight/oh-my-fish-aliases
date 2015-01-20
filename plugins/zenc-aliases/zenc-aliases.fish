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
# change to a project directory w/ autocomplete
function project --description 'Change to project directory'
	if test -d ~/Sites/$argv.development.local
		cd ~/Sites/$argv.development.local/
	else
		echo -n 'No such project ('
		echo -n $argv
		echo ')'
	end
end
#function __fish_project_needs_command
#	set cmd (commandline -opc)
#	if [ (count $cmd) -eq 1 -a $cmd[1] = 'project' ]
#		return 0
#	end
#	return 1
#end

#function __fish_project_using_command
#	set cmd (commandline -opc)
#	if [ (count $cmd) -gt 1 ]
#		if [ $argv[1] = $cmd[2] ]
#			return 0
#		end
#	end
#	return 1
#end
complete -f -c project -e
for projectname in (ls -1 ~/Sites/ | grep development.local | cut -d . -f 1)
	complete -f -c project -A -a $projectname -d 'Change project to $projectname'
end

