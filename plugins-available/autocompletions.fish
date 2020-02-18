# complete -x -c jira -a '(jira shell --auto)'
# complete -x -c jira -a '(/Users/galzsolt/MySites/jira/bin/jira shell)'

# for command in (/Users/galzsolt/MySites/jira/bin/jira shell)
#     complete -x -c "jira" -c "$command" -a "(/Users/galzsolt/MySites/jira/bin/jira shell $command)"
# end
# 
complete -x -c jira -a "(/Users/galzsolt/MySites/jira/bin/jira shell (commandline -poc) (commandline -pot))"

complete -x -c git -c branch -a "(/Users/galzsolt/MySites/oh-my-fish-aliases/plugins-available/autocomplete.php (commandline -pot))"

complete -xc ezra -d "ezra: remote streaming"
complete -xc ezra -a stream -d "ezra: stream handling"
complete -xc ezra -n "__fish_seen_subcommand_from stream" -a "(ezra list-favs)" -d "ezra: start streaming performer"
complete -xc ezra -n "__fish_seen_subcommand_from stream" -a progress -d "ezra: check progress"
complete -xc ezra -n "__fish_seen_subcommand_from stream" -a files -d "ezra: check streams and free space"
complete -xc ezra -n "__fish_seen_subcommand_from stream .+" -a peek -d "ezra: peek performer"
complete -xc ezra -a check-favs -d "ezra: check favourites"
complete -xc ezra -a list-favs -d "ezra: list all favourites"
complete -xc ezra -a fav -d "ezra: add to favourite"
complete -xc ezra -a sync -d "ezra: sync to archive"
complete -xc ezra -a sync -n "__fish_seen_subcommand_from sync" -l no-limit -d "ezra: sync bandwith limit off"