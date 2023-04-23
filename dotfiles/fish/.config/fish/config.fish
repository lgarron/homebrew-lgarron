# `config.fish`

    set DOTFILES_FOLDER ( \
        realpath ~/.config/fish/config.fish \
          | sed 's#dotfiles/fish/\.config/fish/config\.fish$##' \
    )

    abbr -a dff "cd $DOTFILES_FOLDER"
    abbr -a dlf "cd ~/Downloads"

    # Reloads the fish config file. `rc` is chosen because the config file for
    # other shells is often known as the `rc` file, and `rc` is easy to type.
    #
    # For this config file, `rc` will also force redefining abbreviations. See
    # the "Setup" section above.
    abbr -a rc ". $HOME/.config/fish/config.fish"
    # TODO: why is this needed? It seems that `$DOTFILES_FOLDER` is reset by something else between its original definition and here, when running in a codespace?
    if [ "$CODESPACES" = "true" ]
      set DOTFILES_FOLDER "/workspaces/.codespaces/.persistedshare/dotfiles/"
    end
    abbr -a rcu "cd $DOTFILES_FOLDER && git pull && cd - && . $HOME/.config/fish/config.fish"
    if [ "$CODESPACES" = "true" ]
      abbr -a rcuf "cd $DOTFILES_FOLDER && git fetch origin main && git abandon && git reset --hard origin/main && cd - && . $HOME/.config/fish/config.fish"
    end

# Setup

    function add_to_path
      set NEW_PATH_COMPONENT $argv[1]
      fish_add_path --path $NEW_PATH_COMPONENT
    end

    set -x "GOPATH" "$HOME/Code/gopath"

    add_to_path "$HOME/.data/cargo/bin" # For Rust
    add_to_path /opt/homebrew/bin # macOS (Apple Silicon)
    add_to_path /home/linuxbrew/.linuxbrew/bin # for codespaces
    add_to_path /home/linuxbrew/.linuxbrew/sbin # for codespaces
    add_to_path "$GOPATH/bin"
    add_to_path "/usr/local/go/bin"
    add_to_path /opt/homebrew/opt/postgresql@15/bin # For postgres

# Relaunch

    # VSCode shell integration
    # https://github.com/microsoft/vscode/issues/139400
    string match -q $TERM_PROGRAM vscode; and which code-insiders > /dev/null; and . (code-insiders --locate-shell-integration-path fish)

# Setup

    # Only print if we're a TTY.
    # This prevents `protocol error: bad line length character` in git.
    function _echo
        if isatty
            if not [ $SSH_TTY ]
                echo $argv
            end
        end
    end

    if [ "$MANUAL_RELOAD" = "true" ]
      _echo ""
      _echo -n "🐟🔄 Reloading "
      set_color --bold
      _echo -n "fish"
      set_color normal
      _echo " files."
      _echo ""
    end

# Loading

    function loading_indicator
      if [ "$MANUAL_RELOAD" = "true" ]
        _echo $argv[1]
      end
    end

    loading_indicator (status --current-filename)

    function load_if_exists
      if test -f $argv[2]
        loading_indicator "↪ $argv[2]"
        source $argv[2]
      end
    end

# XDG path configuration

  load_if_exists "xdg-basedir-workarounds" $HOME/.config/fish/xdg-basedir-workarounds.fish

# Machines

    set GERMAIN Germain germain Germain.local
    set PYTHAGORAS Pythagoras pythagoras Pythagoras.local

# MOTD

    function fish_greeting_echo
      for arg in $argv
        echo -n $arg | head -c(tput cols)
        echo ""
      end
      echo ""
    end

    # If `hostname -s` is incorrect on macOS:
    #
    # 1. `dscacheutil -flushcache`
    # 2. Reboot
    #
    # Alternatively, use:
    #
    #     set MAC_HOSTNAME (which scutil > /dev/null && scutil --get ComputerName)
    #
    # https://apple.stackexchange.com/a/53042

    # Based on: https://patorjk.com/software/taag/#p=display&v=1&f=Small&t=GALOIS
    set GREETING_HOSTNAME (hostname -s)
    function fish_greeting
      if contains $GREETING_HOSTNAME $GERMAIN
        fish_greeting_echo \
            "  ___ ___ ___ __  __   _   ___ _  _ " \
            " / __| __| _ \\  \\/  | /_\\ |_ _| \\| |" \
            "| (_ | _||   / |\\/| |/ _ \\ | || .` |" \
            " \\___|___|_|_\\_|  |_/_/ \\_\\___|_|\\_|"
      else if contains $GREETING_HOSTNAME $PYTHAGORAS
        fish_greeting_echo \
          " _____   _______ _  _   _   ___  ___  ___    _   ___ " \
          "| _ \\ \\ / /_   _| || | /_\\ / __|/ _ \\| _ \\  /_\\ / __|" \
          "|  _/\\ V /  | | | __ |/ _ \\ (_ | (_) |   / / _ \\\\__ \\" \
          "|_|   |_|   |_| |_||_/_/ \\_\\___|\\___/|_|_\\/_/ \\_\\___/"
      else
        echo -n "🐟 Welcome to "
        set_color --bold; echo (hostname -s)
      end
    end

# Printing

    function echo-alternate-background
        set set_color_arg "normal"
        for arg in $argv[1..-1]
            set_color $set_color_arg
            echo -n $arg

            if [ "$set_color_arg" = "normal" ]
                set set_color_arg "-r"
            else
                set set_color_arg "normal"
            end
        end
        set_color "normal"
        echo ""
    end

    function echo-red
        set_color "red"
        echo $argv[1]
        set_color "normal"
    end

# Shortcuts

## Shell

    function mkcd
        mkdir $argv[1]
        cd $argv[1]
    end

    function resize
      if test (count $argv) -lt 3
        echo "Usage: resize 1200 630 in.png out.png"
        return 1
      end
      if test (count $argv) -lt 4
        set output (path change-extension "" $argv[3]).$argv[1]x$argv[2].png
        echo "Writing to: $output"
      else
        set output $argv[4]
      end
      convert $argv[3] -background transparent -trim -gravity Center -extent $argv[1]:$argv[2]\# -scale $argv[1]x$argv[2] $output
    end
    function square
      resize $argv[1] $argv[1] $argv[2] $argv[3]
    end
    function web-app-images
      if test (count $argv) -lt 1
        echo "Usage: web-app-images icon-source.png"
        return 1
      end
      set input $argv[1]
      set output_prefix (path change-extension "" $input)
      set temp_dir (mktemp -d)
      square 16 $input $temp_dir/$output_prefix.16px.png
      square 32 $input $temp_dir/$output_prefix.32px.png
      convert $temp_dir/$output_prefix.16px.png $temp_dir/$output_prefix.32px.png $output_prefix.favicon.ico
      echo "$output_prefix.favicon.ico"
      square 256 $input $output_prefix.app-icon.png
      echo "$output_prefix.app-icon.png"
      resize 1200 630 $input $output_prefix.social-media-preview.png
      echo "$output_prefix.social-media-preview.png"
    end

    abbr -a "date-iso-8601" "date \"+%Y-%m-%d\""

### Abbrevation definition helpers

    function _abbr_define_anyarg
        set expansion $argv[1]
        set main_command $argv[2]
        set -l cmd (commandline -op)
        if [ "$cmd[1]" = $main_command ]
            echo $expansion
            return 0
        end
        return 1
    end

    function _abbr_define_subcommand
        set expansion $argv[1]
        set main_command $argv[2]
        set sub_command_abbreviation $argv[3]
        set -l cmd (commandline -op)
        if [ "$cmd[1]" = $main_command -a (count $cmd) -eq 2 -a "$cmd[2]" = $sub_command_abbreviation ]
            echo $expansion
            return 0
        end
        return 1
    end

    function _abbr_define_subcommand_arg
        set expansion $argv[1]
        set main_command $argv[2]
        set sub_commands $argv[3..-1]
        set -l cmd (commandline -op)
        if [ "$cmd[1]" = $main_command ]
            if contains -- "$cmd[2]" $sub_commands
                echo $expansion
                return 0
            end
        end
        return 1
    end

    function _abbr_define_exceptsubcommand_arg
        set expansion $argv[1]
        set main_command $argv[2]
        set sub_commands $argv[3..-1]
        set -l cmd (commandline -op)
        if [ "$cmd[1]" = $main_command -a (count $cmd) -gt 2 ]
            if not contains -- "$cmd[2]" $sub_commands
                echo $expansion
                return 0
            end
        end
        return 1
    end

### Editors

    # TODO: https://github.com/microsoft/vscode/issues/139634
    set -xg "VISUAL" (which code)" -w"
    set -xg "EDITOR" "code -w"
    # set -xg EDITOR "open -b com.microsoft.VSCode"

    abbr -a c "code"
    abbr -a xc "xargs code"

## Search

    function f
      find . -iname "*$argv[1]*"
    end

    abbr -a rgnh "rg -S --no-heading"

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

    abbr -a r "open -R"

    abbr -a bi "brew install"

    abbr -a serve "open http://localhost:8000; caddy file-server --listen :8000 --browse"

    abbr -a "md5" "openssl dgst -md5"
    abbr -a "sha1" "openssl dgst -sha1"
    abbr -a "sha256" "openssl dgst -sha256"
    abbr -a "sha512" "openssl dgst -sha512"

## Keyboard

    # https://developer.apple.com/library/content/technotes/tn2450/_index.html
    # Caps Lock (0x39) -> Delete Key (0x2A)
    # Insert (0x49) -> Fn key (0x03 in table 0xFF)
    function remap-keys
        hidutil property --set '{"UserKeyMapping":[
          {"HIDKeyboardModifierMappingSrc":0x700000039,"HIDKeyboardModifierMappingDst":0x070000002A},
          {"HIDKeyboardModifierMappingSrc":0x700000049,"HIDKeyboardModifierMappingDst":0xFF00000003},
        ]}'
    end

    function remap-keys-reset
        hidutil property --set '{"UserKeyMapping":[]}'
    end

    function remap-keys-show
        hidutil property --get "UserKeyMapping"
    end

# Shortcuts

    function pnice
      set NICENESS $argv[2]
      if test (count $argv) -lt 2
        echo "Usage: pnice <process substring> <niceness>"
      else
        echo "📶 Setting niceness $NICENESS for process names containing: $argv[1]";
        for pid in (pgrep $argv[1])
          echo -n "🖥  renice $NICENESS $pid"
          renice $NICENESS $pid 2> /dev/null
          if test $status -ne 0
                echo -n " (sudo)"
                sudo renice $NICENESS $pid
              end
          echo ""
        end
      end
    end

    function pnicest
      pnice $argv[1] 19
    end

    function niceplz
      # Prioritize Quicksilver.
      # I use it all the time, and it's a canary for system overload.
      pnice "Quicksilver" "-20"
      # Syncing processes.
      pnicest "Dropbox"
      pnicest "Backup and Sync"
      pnicest "Google Drive"
      pnicest "CCC User Agent"
      pnicest "CloneKitService" # Custom CCC process name prefix
      pnicest "Maestral"
      pnicest "Compressor"
      pnicest "VTEncoderXPCService" # main encoding process used by Compressor?
      pnicest "Spotlight"
      pnicest "mds_stores"
      pnicest "mdsync"
      pnicest "mdworker_shared"
      pnicest "com.carbonblack.es-loader.es-extension"
      pnicest "ArqAgent"
      pnicest "zoom.us"
      pnicest "com.apple.DriverKit.AppleUserECM" # Ethernet?
      echo "sudo for Time Machine (Ctrl-C to skip Time Machine)"
      sudo echo -n "" ; or return
      pnicest "backupd"
    end

# Screenshots

    function set-screenshot-dir
        set DIR $argv[1]
        echo-alternate-background "Setting screenshot dir to: " $DIR
        defaults write com.apple.screencapture location $DIR
        killall SystemUIServer
    end

# Includes

    load_if_exists "git" $HOME/.config/fish/git.fish
    load_if_exists "dev" $HOME/.config/fish/dev.fish

    loading_indicator ""

# Cleanup

    # From now on, reloads of this file are considered "manual".
    set MANUAL_RELOAD true
