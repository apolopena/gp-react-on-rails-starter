#!/bin/bash
#
# SPDX-License-Identifier: MIT
# Copyright © 2021 Apolo Pena
#
# scaffold-react.sh
# Description:
# Conditionally install scaffolding for react on rails: 
# Includes: webpacker, webpacker react support and react on rails scaffolding

[[ $(pwd) != "$GITPOD_REPO_ROOT" ]] &&
echo -e "\e[1;31mThis command can only be run from the project root of a gitpod workspace:\e[0m $GITPOD_REPO_ROOT" &&
exit 1

. "$GITPOD_REPO_ROOT"/.gp/bash/spinner.sh

c_red='\e[38;5;124m'
c_orange='\e[38;5;208m'
c_green='\e[38;5;76m'
c_blue='\e[38;5;147m'
c_hot_pink="\e[38;5;213m"
c_end='\e[0m'

_pass_msg() {
  echo -e "$c_green""SUCCESS$c_end:$c_end $1"
}

_fail_msg() {
  local msg script_path prefix
  if [[ $1 == '--show-path' ]]; then
    msg="$2"
    prefix="ERROR "
    script_path=$(readlink -f "$0")
  else
    msg="$1"
    prefix="ERROR"
  fi
  echo -e "$c_red$prefix$c_end$c_blue$script_path$c_end$c_red:$c_end$c_orange $msg$c_end"
}

_warn_msg() {
  echo -e "$c_orange""$1$c_end"
}

_info_msg() {
  echo -e "$c_blue""$1$c_end"
}

echo -e "$c_hot_pink""Scaffolding react on rails, you should only ever do this once.$c_end"
if [[ ! -d config/webpack ]]; then
  msg="Installing Webpacker"
  start_spinner "$msg"
  yes | rails webpacker:install --silent 2> >(grep -v warning 1>&2) > /dev/null 2>&1
  ec=$?
  if [[ $ec -eq 0 ]]; then
    stop_spinner $ec
  else
    stop_spinner $ec
    _fail_msg "$msg"
  fi
else
  _warn_msg "Webpacker appears to be installed"
  _warn_msg "skipping Webpacker installation"
fi
# run rails webpacker:install:react blindly as there is no hook to determine if it has been run already
msg="Configuring Webpacker to support react.js"
start_spinner "$msg"
yes | rails webpacker:install:react --silent 2> >(grep -v warning 1>&2) > /dev/null 2>&1
ec=$?
if [[ $ec -eq 0 ]]; then
  stop_spinner $ec
else
  stop_spinner $ec
  _fail_msg "$msg"
fi

if [[ -n $(git status -s) ]]; then
  msg="Committing unstaged files to your local repository"
  start_spinner "$msg"
  if git add -A && git commit -m "Initial scaffolding" >/dev/null 2>&1; then
    stop_spinner 0
    git_committed=1
  else
    stop_spinner 1
    _fail_msg "$msg"
  fi
fi
if [[ ! -f config/initializers/react_on_rails.rb ]]; then
  msg="Generating React on Rails Scaffolding"
  [[ $1 == '--use-redux' ]] && optional_flag='--redux' && msg="${msg} with the flag $optional_flag"
  start_spinner "$msg"
  cp Gemfile tmp/__
  rails generate react_on_rails:install "$optional_flag" --ignore-warnings --skip --quiet > /dev/null 2>&1
  ec=$?
  if [[ $ec -eq 0 ]]; then
    mv tmp/__ Gemfile
    stop_spinner 0
  else
    stop_spinner $ec
    _fail_msg "$msg"
  fi
else
  _warn_msg "React on Rails Scaffolding appears to already be in place"
  _warn_msg "Skipping generation of React on Rails Scaffolding"
fi

msg="Finishing up, running: bundle && yarn"
start_spinner "$msg"
bundle > /dev/null 2>&1 && yarn > /dev/null 2>&1
if [[ $ec -eq 0 ]]; then
  stop_spinner 0
else
  stop_spinner $ec
  _fail_msg "$msg"
fi

if [[ -n $git_committed ]]; then
  _info_msg "Unstaged changes were committed to the local git repository using the message 'Initial scaffolding'"
  _info_msg "To view the files for this commit before you push them to your remote run the command:"
  _info_msg "git show --name-only --oneline $(git rev-parse --short HEAD)"
fi
echo -e "$c_hot_pink""Scaffolding react on rails is done$c_end"