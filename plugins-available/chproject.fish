set __projectname_basedir /Users/galzsolt/Sites /Users/galzsolt/MySites
set __projectname_sed_regex 's/\.development\.local//;s/dev\.//;s/\.com//'

# change to a project directory w/ autocomplete
function project --description 'Change to project directory'
    set --unexport --local tmp_dir (find $__projectname_basedir -type d -maxdepth 1 -mindepth 1 | grep $argv)
    if test -d "$tmp_dir"
        cd "$tmp_dir"
    else
        echo -n 'No such project ('
        echo -n $argv
        echo ')'
    end
end

complete -f -c project -e
for projectname in (find $__projectname_basedir -type d -maxdepth 1 -mindepth 1 | sed $__projectname_sed_regex | xargs basename)
    complete -f -c project -A -a $projectname -d "Change to $projectname directory"
end
