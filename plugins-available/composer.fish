function what-composer-version-i-use --description "Parses composer.lock to find a package you use"
	set --local --unexport __package_name $argv
	if [ "$__package_name" = "" ]
		echo "Please speficy a package name"
		return 1
	end
	cat composer.lock | grep "name\": \"$__package_name" -A1 | sed -E 's/"(name|version)": //g;s/[",]//g;s/[ ]+//g;'
end