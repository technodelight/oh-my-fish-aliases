# change to a project directory w/ autocomplete
function project --description 'Change to project directory'
        set tmp_dir (ls -1 ~/Sites/ | grep $argv)
        if test -d ~/Sites/$tmp_dir
                cd ~/Sites/$tmp_dir
        else
                echo -n 'No such project ('
                echo -n $argv
                echo ')'
        end
end

complete -f -c project -e
for projectname in (ls -1 ~/Sites/ | sed 's/\.development\.local//;s/dev\.//;s/\.com//')
        complete -f -c project -A -a $projectname -d 'Change to project directory'
end
