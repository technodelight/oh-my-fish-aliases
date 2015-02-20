set __projectname_basedir ~/Sites/
set __projectname_sed_regex 's/\.development\.local//;s/dev\.//;s/\.com//'

# change to a project directory w/ autocomplete
function project --description 'Change to project directory'
    set --unexport --local tmp_dir (ls -1 $__projectname_basedir | grep $argv)
    if test -d ~/Sites/$tmp_dir
        cd ~/Sites/$tmp_dir
    else
        echo -n 'No such project ('
        echo -n $argv
        echo ')'
    end
end

complete -f -c project -e
for projectname in (ls -1 $__projectname_basedir | sed $__projectname_sed_regex)
    complete -f -c project -A -a $projectname -d 'Change to project directory'
end
