## Git

    # # Core abbreviations
    # abbr -a gs    "git status"
    # abbr -a gl    "git log"
    #
    # abbr -a gd    "git diff --color-words"
    # abbr -a gdc   "git diff --color-words --cached"
    # abbr -a gdno  "git diff --name-only"
    #
    # abbr -a gst   "git stage"
    # abbr -a grh   "git reset HEAD"
    # abbr -a gc    "git commit --message"
    # abbr -a gca   "git commit --amend"
    #
    # abbr -a gr    "git rebase"

    abbr -a g    "git"

    abbr -a gs    "git status"
    abbr -a gl    "git log"
    abbr -a glp   "git log --oneline --decorate=full --graph --remotes" # git log pretty, from http://www.xerxesb.com/2010/command-line-replacement-for-gitk/

    abbr -a gd    "git diff --color-words"
    abbr -a gdc   "git diff --color-words --cached"

    abbr -a gst   "git stage"
    abbr -a g.    "git stage ."
    abbr -a gsp   "git stage --patch"
    abbr -a gc    --set-cursor "git commit --message \"%\""
    abbr -a gca   "git commit --amend"
    abbr -a gcane "git commit --amend --no-edit"

    function _lg_complete_gcv
        echo "git commit --message \""(pbpaste)
        echo ""
        echo "Release notes:"
        echo ""
        echo "- %\""
    end
    abbr -a gcv --set-cursor --function _lg_complete_gcv

    abbr -a gb    "git branch"
    abbr -a gbd   "git branch -D"
    abbr -a gbm   "git branch -m"
    abbr -a gco   "git checkout"
    abbr -a gcb   "git checkout -b"
    abbr -a gcp   "git cherry-pick"
    abbr -a gdno  "git diff --name-only"
    abbr -a gm    "git merge"
    abbr -a gmb "git merge-base main (git rev-parse --abbrev-ref HEAD)"

    function _lg_complete_git_main_function
        set -l cmd (commandline -op)
        if [ "$cmd[1]" = git -a (count $cmd) -gt 2 ]; echo "main"; return 0; end
        return 1
    end
    abbr -a _lg_complete_git_main --regex m --position anywhere --function _lg_complete_git_main_function

    function _lg_complete_git_merge_function
        set -l cmd (commandline -op)
        if [ "$cmd[1]" = git -a (count $cmd) -eq 2 -a "$cmd[2]" = m ]; echo "merge"; return 0; end
        return 1
    end
    abbr -a _lg_complete_git_merge --regex m --position anywhere --function _lg_complete_git_merge_function

    set -g git_reentrant rebase merge cherry-pick
    function _lg_complete_git_reentrant_a_function
        set -l cmd (commandline -op)
        if [ "$cmd[1]" = git ]
            if contains -- "$cmd[2]" $git_reentrant; echo "--abort"; return 0; end
        end
        return 1
    end
    abbr -a _lg_complete_git_reentrant_a --regex a --position anywhere --function _lg_complete_git_reentrant_a_function

    function _lg_complete_git_reentrant_c_function
        set -l cmd (commandline -op)
        if [ "$cmd[1]" = git ]
            if contains -- "$cmd[2]" $git_reentrant; echo "--continue"; return 0; end
        end
        return 1
    end
    abbr -a _lg_complete_git_reentrant_c --regex c --position anywhere --function _lg_complete_git_reentrant_c_function

    function _lg_complete_git_rebase_i_function
        set -l cmd (commandline -op)
        if [ "$cmd[1]" = git ]
            if contains -- "$cmd[2]" rebase; echo "--interactive"; return 0; end
        end
        return 1
    end
    abbr -a _lg_complete_git_rebase_i --regex i --position anywhere --function _lg_complete_git_rebase_i_function

    function _lg_complete_git_commit_a_function
        set -l cmd (commandline -op)
        if [ "$cmd[1]" = git ]
            if contains -- "$cmd[2]" commit; echo "--amend"; return 0; end
        end
        return 1
    end
    abbr -a _lg_complete_git_commit_a --regex c --position anywhere --function _lg_complete_git_commit_a_function

    function _lg_complete_git_commit_ne_function
        set -l cmd (commandline -op)
        if [ "$cmd[1]" = git ]
            if contains -- "$cmd[2]" commit; echo "--no-edit"; return 0; end
        end
        return 1
    end
    abbr -a _lg_complete_git_commit_ne --regex ne --position anywhere --function _lg_complete_git_commit_ne_function

    function commit_last_command
        echo git commit --message "\"`$history[1]`\""
    end
    abbr -a gc!! --position anywhere --function commit_last_command

    # abbr -a gcfd  "git clean --force -d" # subsumed by `gclean`

    abbr -a grh   "git reset HEAD"
    abbr -a ghard "git reset --hard"
    abbr -a gsoft "git reset --soft"
    abbr -a gr    "git rebase"
    abbr -a gri   "git rebase --interactive"
    abbr -a gr3   "git rebase --interactive HEAD~3"
    abbr -a gr9   "git rebase --interactive HEAD~9"
    abbr -a grm   "git rebase main"
    abbr -a grom  "git rebase origin/main"
    abbr -a groma "git rebase origin/master"
    abbr -a glast "echo \"Use `gsh`\""
    abbr -a gsh   "git show HEAD"

    abbr -a nff "git merge --no-ff"
    abbr -a ffo "git merge --ff-only"

    abbr -a gt   "git tag"
    abbr -a gtd  "git tag -d"

    abbr -a gv "gh repo view --web --branch (git rev-parse --abbrev-ref HEAD)"

    abbr -a gfp   "git fetch --prune"
    abbr -a gp    "git push"
    abbr -a gpo   "git push origin"
    abbr -a gpot  "git push origin --tags"
    abbr -a gpfl  "git push --force-with-lease"
    abbr -a gu    "git pull"
    abbr -a grv   "git remote --verbose"
    function pr
        echo -n "pull/$argv[1]/head"
    end

    abbr -a gf    "git freeze"
    abbr -a gth   "git thaw"

    # "git push branch" to a remote that doesn't know about the branch yet.
    abbr -a gph "git push -u origin HEAD"
    abbr -a gbak "git push -f --all bak"

    abbr -a upstream "git rev-parse --abbrev-ref --symbolic-full-name \"@{upstream}\""

    function gpr
       set -l url
       set -l branch (git rev-parse --abbrev-ref HEAD)
       if test $status -eq 0
           set url (hub pr list -f "%U" -h $branch)
       end

       if test -z $url
           set url (hub browse -u)
       end

       python -mwebbrowser $url >/dev/null
    end

    # Distance between branches.
    function dist
        set CURRENT (git rev-parse --abbrev-ref HEAD)
        set OTHER $argv[1]

        git rev-list --left-only --count $CURRENT...$OTHER | tr -d '\n'
        echo -n " commit(s) on "
        set_color -o
        echo "$CURRENT"
        set_color normal

        git rev-list --right-only --count $CURRENT...$OTHER | tr -d '\n'
        echo -n " commit(s) on "
        set_color -o
        echo "$OTHER"
        set_color normal
    end

    complete --no-files \
        --command dist \
        --arguments '(__fish_git_branches)'

    abbr -a gbranch "git rev-parse --abbrev-ref HEAD"
    abbr -a ghash "git rev-parse HEAD"
    abbr -a gmessage "git log -1 --pretty=%B"

    function gclean
        echo "Use: `ga` (`git abandon`)"
    end
    abbr -a ga "git abandon"

    if which gitx > /dev/null
        abbr -a gx "gitx"
    else
        abbr -a gx "open -a GitX ."
    end

    function rmbranch
        set BRANCH $argv[1]
        echo "Branch `$BRANCH` was at: "(git rev-parse $BRANCH)
        git push origin :$BRANCH
        git branch -D $BRANCH
    end
    complete -c rmbranch -f
    # From https://codybonney.com/getting-a-list-of-local-git-branches-without-using-git-branch/
    complete -c rmbranch -a "(git for-each-ref --format '%(refname:short)' refs/heads/)"

### `tagpush`

    function rmtag
        set TAG $argv[1]
        git tag -d $TAG; or echo "Did not need to remove tag locally"
        echo "--------"
        git push origin :$TAG; or echo "Did not need to remove tag from origin"
    end

    function tagpush-check
        set VERSION (echo -n "v"; cat package.json | jq -r ".version")
        if test $VERSION = "v"
            echo "No `package.json` to get version." 1>&2
            return 1
        end
        if test $VERSION = "vnull"
            echo "Could not get version from `package.json`." 1>&2
            return 1
        end
        set PREVIOUS_COMMIT_VERSION (echo -n "v"; git show HEAD~:package.json | jq -r ".version")
        if test $VERSION = $PREVIOUS_COMMIT_VERSION
            echo "`package.json` did not change since last commit. Halting `retagpush`." 1>&2
            return 1
        end
    end

    function tagpush-version
        set TAG $argv[1]
        git tag $TAG
        echo "--------"
        git push origin $TAG
    end

    function tagpush
        tagpush-check || return 1
        tagpush-version (echo -n "v"; cat package.json | jq -r ".version")
    end

    function retagpush-version
        set TAG $argv[1]
        echo -n "Tag was previously at at commit: "
        git rev-parse $TAG; or echo "No old tag"
        echo "--------"
        rmtag $TAG
        echo "--------"
        tagpush-version $TAG
    end

    function retagpush
        tagpush-check || return 1
        retagpush-version (echo -n "v"; cat package.json | jq -r ".version")
    end
