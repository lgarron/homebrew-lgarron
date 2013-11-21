# .zshrc Customization - Lucas Garron, 2013

## File Paths

    ZSH_PATH="${HOME}/local/config/oh-my-zsh/"
    SUBLIME_TEXT_PATH="/Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl"
    STDERRRED_PATH="${HOME}/local/dylib/libstderred.dylib"
    INSTALLED_FILE_PATH="${HOME}/local/config/installed.txt"
    MATHEMATICA_SCRIPT_PATH="/Applications/Wolfram/Mathematica.app/Contents/MacOS/MathematicaScript"


## oh-my-zsh and shell

    ZSH="${ZSH_PATH}"
    ZSH_THEME="sunrise"
    DISABLE_AUTO_TITLE="true"
    COMPLETION_WAITING_DOTS="true"
    DISABLE_UPDATE_PROMPT="true"
    plugins=(git osx)

    unsetopt correctall
    setopt correct

    source $ZSH/oh-my-zsh.sh

    # Useful for settings aside commands you just typed (so that they're in the history and can be used later, without executing now.)
    setopt INTERACTIVECOMMENTS


## Shell

    # Set the $PATH
    path=(${path} "${HOME}/local/bin") #zsh

    # Output stderr in red.
    if [ -f "${STDERRRED_PATH}" ]
    then
      export DYLD_INSERT_LIBRARIES="${STDERRRED_PATH}${DYLD_INSERT_LIBRARIES:+:$DYLD_INSERT_LIBRARIES}"
    fi

    # Open man page in Chrome
    export MANPAGER="man2html > /tmp/man-page.html && open /tmp/man-page.html"


## Homebrew and homebrew-cask

    # Include homebrew in python path
    export PYTHONPATH="/usr/local/lib/python2.7/site-packages:$PYTHONPATH"

    # Install applications to the global folder.
    export HOMEBREW_CASK_OPTS="--appdir=/Applications"

    # Contains a node_modules folder symlinked to ~/.node_modules
    NPM_PATH="${HOME}/local/node"

    function bi   { brew install                       $@ && echo "[$(date "+%Y-%m-%d")][brew install]"      $@ >> "${INSTALLED_FILE_PATH}" && rehash }
    function bci  { brew cask install                  $@ && echo "[$(date "+%Y-%m-%d")][brew cask install]" $@ >> "${INSTALLED_FILE_PATH}" && rehash }
    function pipi { pip install                        $@ && echo "[$(date "+%Y-%m-%d")][pip install]"       $@ >> "${INSTALLED_FILE_PATH}" && rehash }
    function cabi { cabal install                      $@ && echo "[$(date "+%Y-%m-%d")][cabal install]"     $@ >> "${INSTALLED_FILE_PATH}" && rehash }
    function npmi { npm install --prefix="${NPM_PATH}" $@ && echo "[$(date "+%Y-%m-%d")][npm install]"       $@ >> "${INSTALLED_FILE_PATH}" && rehash }
    alias bs="brew search"
    alias bcs="brew cask search"
    alias pips="pip search"
    alias cabs="cabal search"
    alias npms="npm search"


## Shortcuts

### Shell

    # Reload .zshrc file
    alias re="echo \"Reloading .zshrc file.\" && source ~/.zshrc"

    # Copy stdout to clipboard (after command has finished)
    alias t="tee >(pbcopy)"

    # Make folder and `cd` into it immediately.
    function mcd() { mkdir "$@"; cd "$@" }

### Editors

    alias subl="${SUBLIME_TEXT_PATH}"
    export EDITOR="${SUBLIME_TEXT_PATH} -w"
    alias e='emacs'
    alias s='subl'

### Hashes

    alias md5='openssl md5'
    alias sha1='openssl sha1'
    alias sha256='openssl dgst -sha256'

### System

    alias battery='ioreg -rc AppleSmartBattery'
    alias o='open .' # Open pwd in Finder.
    alias or='open -R' # Reveal file/folder in Finder.

    # Lower the priority of a process.
    alias nicest="nice -n 20"

## Search

    # List dirs in the current folder.
    alias dirs="find . -d -maxdepth 1 -mindepth 1 -type d"

    ## Quick find - Is there a way to define this using alias?
    function f() { find . -iname "*${1}*" }
    function f2 { mdfind -onlyin . -name "${1}" }

    alias fx='find . -iname' # find exact

    # Quick grep
    function gre() { grep -ir "${1}" . }

    alias changes="watchmedo shell-command --patterns=\"*\" --recursive --command='echo \"\${watch_src_path}\"' ."

## Git

    alias g="git"

    alias gs="git status"
    alias gl="git log"
    alias glp="git log --oneline --decorate=full --graph --remotes" # git log pretty, from http://www.xerxesb.com/2010/command-line-replacement-for-gitk/

    alias gdcw="git diff --color-words"
    alias gd="gdcw"
    alias gdc="gdcw --cached"
    #alias gdi="git difftool -t fmdiff" # Doesn't work right now.

    alias gst="git stage"
    alias gc="git commit -m"
    alias gca="git commit --amend"
    alias gcane="git commit --amend --no-edit"

    alias gb="git branch"
    alias gco="git checkout"
    alias gcod="git checkout --detach"
    alias gcb="git checkout -b"

    alias gh="hub browse"

    alias ghash="git rev-parse HEAD"
    alias glast="git show HEAD"

    alias gsi="git submodule init"
    alias gsu="git submodule update"
    alias gsui="git submodule update --init"

    alias gt="git tag"

    alias gr="git rebase"

    # Copy hash of latest commit to clipboard
    function glc {
      LATEST=$(ghash)
      echo "Latest commit: ${LATEST}"
      echo -n "${LATEST}" | pbcopy
      echo "Copied to clipboard."
    }

    alias gx="gitx --all"

## OSX Applications, $BROWSER

    alias audacity="open -a Audacity"
    alias gimp="open -a GIMP"
    alias chrome="open -a \"Google Chrome\""
    BROWSER="${chrome}"

    ## Open Quicksilver in the current directory.
    alias q="qs ."

## Echonest Remix API.

    export ECHO_NEST_API_KEY="EJ7ZVMPNXWVFXS1KE"

## Network

    # Convenience for getting the current public IP.
    alias ip="curl icanhazip.com 2>& /dev/null | tr -cd \"[:digit:].\""

## Development / Programming

    alias mcl="make clean"

    # Use four cores for make.
    alias mj="make -j 4"

    # Haskell
    alias hs=runghc

    # Mathematica
    function ms {
      REALPATH=$(realpath "${1}")
      shift
      "${MATHEMATICA_SCRIPT_PATH}" -script "${REALPATH}" $@
    }

    # Get file extension
    function ext {
      echo "${1##*.}" | awk '{print tolower($0)}'
    }

## Tools

    # Server from the current directory.
    # From http://apple.stackexchange.com/questions/5435/got-any-tips-or-tricks-for-terminal-in-mac-os-x
    function serve() { open "http://localhost:${1:-8080}/" &&  python -m SimpleHTTPServer ${1:-8080}; }

    alias screensaver_desktop="/System/Library/Frameworks/ScreenSaver.framework/Resources/ScreenSaverEngine.app/Contents/MacOS/ScreenSaverEngine -background"

    # Random password generation
    function makerandom() { head /dev/random | uuencode -m - | sed -n 2p | cut -c1-${1:-20}; }
    function makepass() { echo "`word`-`word`-`word`-`word`" }

    # Watch the current directory tree and run a command after any change.
    # Usage:
    #   watch ls
    #   watch "make test" --patterns "*.py;*.txt"
    alias watch="watchmedo shell-command . --ignore-patterns=\"*/.DS_Store\" --patterns=\"*\" --recursive --command"
