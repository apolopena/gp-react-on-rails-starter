# shellcheck shell=bash
# shellcheck disable=2142

# opens or refreshes the preview browser. Try op --help
alias op='f(){ bash "$GITPOD_REPO_ROOT"/.gp/bash/open-preview.sh "$@";  unset -f f; }; f'

# starts or stops the development server. try dserver --help
alias dserver='f(){ bash "$GITPOD_REPO_ROOT"/.gp/bash/dserver.sh "$@";  unset -f f; }; f'