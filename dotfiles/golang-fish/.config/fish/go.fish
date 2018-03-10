 # Go

  if contains (hostname -s) $EUCLID
    set -x "GOPATH" "$HOME/Dropbox/Code/gopath"
  else
    set -x "GOPATH" "$HOME/Code/gopath"
  end

  set -x PATH $PATH \
    "$GOPATH/bin"

  if test -d "/usr/local/go/bin"
    set -x PATH $PATH \
      "/usr/local/go/bin"
  end

  if [ (uname) = "Darwin" ]
    function go
      env DYLD_INSERT_LIBRARIES='' command go $argv
    end
  end
