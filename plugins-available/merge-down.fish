
function merge-down --description "merge every release branch down from the first one through develop"
    set --unexport CURRENT_BRANCH (git br | grep \* | sed -E 's~\*~~;s~^[ ]+~~;s~[ ]+$~~')
    set --unexport PREV_BRANCH ""
    for BRANCH in (git branch | grep release | sed -E 's~\*~~;s~^[ ]+~~;s~[ ]+$~~' | sort -k2n)
        if test -z "$PREV_BRANCH"
            set --unexport PREV_BRANCH "$BRANCH"
        else
            echo merge $PREV_BRANCH into $BRANCH
            git checkout $BRANCH
            git merge $PREV_BRANCH --no-edit
            git push origin head
            set --unexport PREV_BRANCH "$BRANCH"
        end
    end
    if test ! -z "$PREV_BRANCH"
        git checkout develop
        git merge $PREV_BRANCH --no-edit
        git push origin head
    end
    if [ "$CURRENT_BRANCH" != "develop" ]
        git checkout $CURRENT_BRANCH
    end
end