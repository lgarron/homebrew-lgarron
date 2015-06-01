## Git

    abbr -a gs    "git status"
    abbr -a gl    "git log"
    abbr -a glp   "git log --oneline --decorate=full --graph --remotes" # git log pretty, from http://www.xerxesb.com/2010/command-line-replacement-for-gitk/

    abbr -a gd    "git diff --color-words"
    abbr -a gdc   "git diff --color-words --cached"

    abbr -a gst   "git stage"
    abbr -a gc    "git commit --message"
    abbr -a gca   "git commit --amend"
    abbr -a gcane "git commit --amend --no-edit"

    abbr -a gb    "git branch"
    abbr -a gco   "git checkout"
    abbr -a gcb   "git checkout -b"
    abbr -a gcp   "git cherry-pick"
    abbr -a gdno  "git diff --name-only"

    abbr -a grh   "git reset HEAD"
    abbr -a gr    "git rebase"
    abbr -a glast "git show HEAD"

    abbr -a gp    "git push"
    abbr -a pr    "git fetch origin pull/ID/head:newBranchName"

    set -x GITX_PATH (which gitx)
    function gitx
      echo "Invoking wrapped gitx."
      env DYLD_INSERT_LIBRARIES='' $GITX_PATH $argv
    end
    abbr -a gx    "gitx --256 &"

    function github
        hub browse &
    end
    abbr -a gh github