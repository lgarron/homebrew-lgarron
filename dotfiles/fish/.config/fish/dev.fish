## `dev`

    abbr -a --position command m "make"

    # Legacy (TODO: restore?)
    abbr -a mb "# Try: m b"
    abbr -a mc "# Try: m c"
    abbr -a md "# Try: m d"
    abbr -a mdp "# Try: m dp"
    abbr -a mp "# Try: m p"
    abbr -a mt "# Try: m t"
    abbr -a ml "# Try: m l"
    abbr -a mf "# Try: m f"
    abbr -a mcd "# Try: m c d"
    abbr -a mcb "# Try: m c b"

    function _lga_git_make_build_fn; _lga_define_anyarg build make; end; abbr -a _lga_git_make_build --regex b --position anywhere --function _lga_git_make_build_fn
    function _lga_git_make_dev_fn; _lga_define_anyarg dev make; end; abbr -a _lga_git_make_dev --regex d --position anywhere --function _lga_git_make_dev_fn
    function _lga_git_make_clean_fn; _lga_define_anyarg clean make; end; abbr -a _lga_git_make_clean --regex c --position anywhere --function _lga_git_make_clean_fn
    function _lga_git_make_deploy_fn; _lga_define_anyarg deploy make; end; abbr -a _lga_git_make_deploy --regex dp --position anywhere --function _lga_git_make_deploy_fn
    function _lga_git_make_publish_fn; _lga_define_anyarg publish make; end; abbr -a _lga_git_make_publish --regex p --position anywhere --function _lga_git_make_publish_fn
    function _lga_git_make_test_fn; _lga_define_anyarg test make; end; abbr -a _lga_git_make_test --regex t --position anywhere --function _lga_git_make_test_fn
    function _lga_git_make_lint_fn; _lga_define_anyarg lint make; end; abbr -a _lga_git_make_lint --regex l --position anywhere --function _lga_git_make_lint_fn
    function _lga_git_make_format_fn; _lga_define_anyarg format make; end; abbr -a _lga_git_make_format --regex f --position anywhere --function _lga_git_make_format_fn

## `node`

    abbr -a niy "npm init -y ; and jq --indent 2 '.type=\"module\" | del(.main)' package.json > /tmp/package.json ; and cat /tmp/package.json > package.json"
    abbr -a ni "npm install;"
    abbr -a nis "npm install --save"
    abbr -a nid "npm install --save-dev"
    abbr -a nu "npm uninstall"
    abbr -a nr "npm run"

    # npm run d⎵ → npm run dev
    function _lga_npm_run_d_fn; _lga_define_subcommand_arg dev npm run; end; abbr -a _lga_npm_run_d --regex d --position anywhere --function _lga_npm_run_d_fn
    # npm run b⎵ → npm run build
    function _lga_npm_run_b_fn; _lga_define_subcommand_arg build npm run; end; abbr -a _lga_npm_run_b --regex b --position anywhere --function _lga_npm_run_b_fn

    abbr -a rmnm "rm -rf ./node_modules ; and npm install"
    abbr -a wtr "npx web-test-runner"
    abbr -a "yarn" "npx yarn"

    abbr -a "es2020" "npx esbuild --format=esm --target=es2020 --bundle --splitting --outdir=dist/esm-bundle"

    function bump-version
      # /usr/bin/env echo -n v
      npm version --no-git-tag-version $argv[1]
    end

    # https://github.com/cubing/cubing.js/blob/3597fba81b65a1c87e42c4297a2d9ef5fdc3a8e3/script/build/targets.js#L44
    set -xg "EXPERIMENTAL_CUBING_JS_RELOAD_CHROME_MACOS" "1"

## Web

    # *h*ttps *h*eaders
    abbr -a "hh" "https -ph"

## Misc

    abbr -a "cx" "chmod +x"
