# `config.fish`

    echo -n "." # Loading indicator

# Setup

    # Unless the config file is manually reloaded (e.g. using `rc`), shim out
    # `abbr` and leave the existing abbrevation definitions.
    #
    # Instead of temporarily cloberring `abbr`, we could also write a
    # `custom_abbr` function and dynamically set its action to either pass thwe
    # call onto `abbr` or do nothing. But I'd rather leave `abbr` strewn about
    # in my config files, so that any part of it can be understood and
    # copied/pasted in isolation.
    if [ "$CONFIG_FISH_LOADED" != "true" ]
        function abbr
        end
    end

# Path

    set PATH \
      $PATH \
      "/usr/local/go/bin" \
      "$HOME/local/bin/scripts" \
      "$HOME/local/bin/misc" \
      "$HOME/local/bin/dance-hacking" \
      "$HOME/Code/Work/google-cloud-sdk/bin"

set GALOIS = Galois Galois.local
set NOETHER = Noether lgarron-macbookpro

# MOTD

    function fish_greeting

      if contains (hostname -s) $GALOIS
        # Based on ANSI Shadow with the shadow removed:
        # http://patorjk.com/software/taag/#p=display&v=1&f=ANSI%20Shadow&t=Galois%0AGALOIS
        echo " ██████     █████    ██         ██████    ██   ███████ "
        echo "██         ██   ██   ██        ██    ██   ██   ██      "
        echo "██   ███   ███████   ██        ██    ██   ██   ███████ "
        echo "██    ██   ██   ██   ██        ██    ██   ██        ██ "
        echo " ██████    ██   ██   ███████    ██████    ██   ███████ "
        echo ""
      else if contains (hostname -s) $NOETHER
        # Based on ANSI Shadow with the shadow removed:
        # http://patorjk.com/software/taag/#p=display&v=1&f=ANSI%20Shadow&t=NOETHER
        echo "███    ██  ██████  ███████ ████████ ██   ██ ███████ ██████ "
        echo "████   ██ ██    ██ ██         ██    ██   ██ ██      ██   ██"
        echo "██ ██  ██ ██    ██ █████      ██    ███████ █████   ██████ "
        echo "██  ██ ██ ██    ██ ██         ██    ██   ██ ██      ██   ██"
        echo "██   ████  ██████  ███████    ██    ██   ██ ███████ ██   ██"
        echo ""
      else
        echo "Welcome to "(hostname -s)
      end

    end

# Shortcuts

## Shell

    # Reloads the fish config file. `rc` is chosen because the config file for
    # other shells is often known as the `rc` file, and `rc` is easy to type.
    #
    # For this config file, `rc` will also force redefining abbreviations. See
    # the "Setup" section above.
    abbr -a rc ". $HOME/.config/fish/config.fish"

    abbr -a unset "set -e"

    function mkcd
        mkdir "$argv[1]"
        cd "$argv[1]"
    end

### Editors

    set -x "EDITOR" "subl -w"
    abbr -a s "subl"

## Search

    function f
      find . -iname "*$argv[1]*"
    end

    function gre
      grep -ir $argv[1] .
    end

## General


    # abbr -a t "tee >(pbcopy)"
    function t
        cat > /tmp/pbcopy.txt
        cat /tmp/pbcopy.txt
        cat /tmp/pbcopy.txt | pbcopy
        rm /tmp/pbcopy.txt
    end

    function o
        if [ (count $argv) = 0 ]
            open .
        else
            open $argv
        end
    end

    abbr -a xs "xargs subl"

    export DYLD_INSERT_LIBRARIES="$HOME/local/dylib/libstderred.dylib"
    # I can't get STDERRED_BLACKLIST to work, so let's make it easy to unset DYLD_INSERT_LIBRARIES
    abbr -a "dy" "set -e DYLD_INSERT_LIBRARIES"

    abbr -a serve "python -m SimpleHTTPServer"

    # Technically a private API token, but not critically secret.
    set -x "ECHO_NEST_API_KEY" "EJ7ZVMPNXWVFXS1KE"

    abbr -a "md5" "openssl dgst -md5"
    abbr -a "sha1" "openssl dgst -sha1"
    abbr -a "sha256" "openssl dgst -sha256"
    abbr -a "sha512" "openssl dgst -sha512"

    set -x "DANCE_HACKING_MUSIC_FOLDER" "$HOME/Temporary/Music/"

    set -x AEDEPLOY_PATH (which aedeploy)
    function aedeploy
      echo "Invoking wrapped aedeploy."
      env DYLD_INSERT_LIBRARIES='' $AEDEPLOY_PATH $argv
    end

    if contains (hostname -s) $NOETHER
        set -x PATH \
            $PATH \
            "/Users/lgarron/Code/go_appengine" \
            "$HOME/Code/google-cloud-sdk/bin"
    end

## Web

    function https
        http --default-scheme https $argv
    end

    abbr -a "hs" "https -ph"


# Includes


    echo -n "." # Loading indicator
    . $HOME/.config/fish/git.fish

    if test -f $HOME/.config/fish/go.fish
        echo -n "." # Loading indicator
        . $HOME/.config/fish/go.fish
    end

    if test -f $HOME/.config/fish/chrome.fish
        echo -n "." # Loading indicator
        . $HOME/.config/fish/chrome.fish
    end

    if not functions -q iterm_fish_prompt
        if [ $SSH_TTY ]
            source "$HOME/.iterm2_shell_integration.fish"
            function subl
                rmate $argv
            end
            set -x "EDITOR" "rmate"
            set -x "DISPLAY" ":20"
        end
    end

    echo -ne "\r" # Clear loading indicators.

# Cleanup

    if [ "$CONFIG_FISH_LOADED" != "true" ]
        functions -e abbr
    end
    set CONFIG_FISH_LOADED true
