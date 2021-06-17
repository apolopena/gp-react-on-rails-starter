#!/bin/bash
#
# SPDX-License-Identifier: MIT
# Copyright © 2021 Apolo Pena
#
# configure-new.sh
# Description:
# Conditionally configures a project that has already been scaffolded for react_on_rails: 
# Implements TailwindCSS and Animate.css into Webpacker
# Adds style and animation to the hello_world react example

[[ $(pwd) != "$GITPOD_REPO_ROOT" ]] &&
echo -e "\e[1;31mThis command can only be run from the project root of a gitpod workspace:\e[0m $GITPOD_REPO_ROOT" &&
exit 1

[[ $(pwd) != "$GITPOD_REPO_ROOT" ]] &&
echo -e "\e[1;31mThis command can only be run from the project root of a gitpod workspace:\e[0m $GITPOD_REPO_ROOT" &&
exit 1

. "$GITPOD_REPO_ROOT/.gp/bash/spinner.sh"

c_red='\e[38;5;124m'
c_orange='\e[38;5;208m'
c_green='\e[38;5;76m'
c_blue='\e[38;5;147m'
c_hot_pink="\e[38;5;213m"
c_end='\e[0m'

_green () {
  echo -e "$c_green$1$c_end"
}

_orange () {
  echo -e "$c_orange$1$c_end"
}

_pink () {
  echo -e "$c_hot_pink$1$c_end"
}

_red () {
  echo -e "$c_red$1$c_end"
}

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
  echo -e "$c_orange""WARNING$c_end:$c_end $1"
}

_info_msg() {
  echo -e "$c_blue""$1$c_end"
}

_verify() {
  [[ ! -f "$GITPOD_REPO_ROOT/$2" ]] && 
  _fail_msg "Missing required destination file: $2" && 
  _orange "Did you run scaffold-react first?" &&
  return 1
  [[ ! -f "$GITPOD_REPO_ROOT/$1" ]] && 
  _fail_msg "Missing required source file: $1" && 
  _orange ".gp/snippets/configure-new or it's contents were not found" &&
  return 1
  return 0
}

# source prefix ($1), destination file $(2)
_overwrite() {
  local src dest msg ec
  dest="$1"
  src="$2$(basename "$dest")"
  msg="Overwriting $dest"
  if ! _verify "$src" "$dest"; then _red "process aborted"; exit 1; fi
  start_spinner "$msg" && /bin/cp "$src" "$dest" 
  ec=$? && stop_spinner $ec
}

_force_CSS_scaffolding() {
  local ec
  local src_prefix=.gp/snippets/configure-new/
  local src_file="$src_prefix"application.scss
  local dest_root="app/javascript"
  local target_file="$dest_root/stylesheets/"application.scss

  if [[ ! -d $dest_root ]]; then
    _fail_msg "Missing required directory: $dest_root"
    _orange "Did you run scaffold-react first?" 
    _red "process aborted"
    exit 1
  fi

  if [[ -d $dest_root/stylesheets ]]; then
    start_spinner "Deleting the directory $dest_root/stylesheets and all it's contents"
    rm -rf "$dest_root/stylesheets"
    ec=$?
    stop_spinner $ec
  fi
  mkdir "$dest_root/stylesheets"

  [[ ! -f $src_file ]] &&
  _fail_msg "Missing required source file: $src_file" && exit 1
  start_spinner "  Creating file: $target_file"
  cp "$src_file" "$target_file"
  ec=$?
  stop_spinner $ec

  src_file="$GITPOD_REPO_ROOT/$src_prefix"tailwind.config.js
  target_file="$dest_root/stylesheets/"tailwind.config.js
  [[ ! -f $src_file ]] &&
  _fail_msg "Missing required source file: $src_file" && exit 1
  start_spinner "  Creating file: $target_file"
  cp "$src_file" "$target_file"
  ec=$?
  stop_spinner $ec
}

_configure() {
  local src_prefix=.gp/snippets/configure-new/
  _green "OK"
  _overwrite postcss.config.js "$src_prefix"
  _force_CSS_scaffolding
  _overwrite app/javascript/packs/application.js "$src_prefix"
  _overwrite babel.config.js "$src_prefix"
  _overwrite app/views/hello_world/index.html.erb "$src_prefix/hello_world/"
  _pass_msg "$c_hot_pink""Project has been configured$c_end"
}

main() {
  _pink "Configuring a new project..."
  _warn_msg "$c_blue""The following files will be overwritten$c_end:"
  _green "  postcss.config.js"
  _green "  app/javascript/packs/application.js"
  _green "  babel.config.js"
  _green "  views/hello_world/index.html.erb"
  _orange "The following directory and all of it's contents will be removed if it exists:"
  _green "  app/javascript/stylesheets/"
  while true; do
      echo -en "$c_red""Are you sure? $c_end$c_orange(Yy, Nn)$c_end "
      read -rp "" yn
      case $yn in
          [Yy]* ) _configure && exit;;
          [Nn]* ) _green "OK process aborted" && exit 0;;
          * ) _orange "Please answer yes or no.";;
      esac
  done;
}

main



