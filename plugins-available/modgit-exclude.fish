# Modgit exclude plugin
function modgit-exclude --description 'Exclude installed modgit module files from git'
	if test -d ../.git
		set --unexport --local __gitexcludefile ../.git/info/exclude
	else
		echo ".git directory not found - could not exclude files"
		return 1
	end
	set --unexport --local  __test_modgit_available (modgit list | grep "ERROR:")
	if test $__test_modgit_available
		echo "Modgit is not avilable in the current directory"
		return 4;
	end

	if test ! (grep "$argv modgit module" $__gitexcludefile)
		echo "Adding $argv module files to git exclude"
		echo "# $argv modgit module" | tee -a ../.git/info/exclude
		modgit files $argv | tail -n +2 | sed 's/\(^.\)/public\/\1/' | tee -a $__gitexcludefile
		return 0;
	else
		echo "$argv module files already excluded"
		return 2;
	end
end

