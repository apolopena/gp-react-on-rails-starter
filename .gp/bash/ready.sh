#!/bin/bash
#
# SPDX-License-Identifier: MIT
# Copyright © 2021 Apolo Pena
#
# ready.sh
# Description:
# opens an Initial preview or displays a welcome message

. .gp/bash/spinner.sh

c_hot_pink="\e[38;5;213m"
c_green='\e[38;5;76m'
c_orange='\e[38;5;208m'
c_blue='\e[38;5;147m'
c_end='\e[0m'

blue() {
  echo -e "$c_blue$1$c_end"
}
green () {
  echo -e "$c_green$1$c_end"
}
orange () {
  echo -e "$c_orange$1$c_end"
}
pink () {
  echo -e "$c_hot_pink$1$c_end"
}

setup_one_time_msg() {
  pink "Welcome!"
  green "Your starter project is being set up now."
  green "This will take a couple of minutes."
}

task1() {
  blue "Installing project gems and creating database..."
  gp sync-await task1 > /dev/null 2>&1
}

task2() {
  blue "Scaffolding react_on_rails..."
  gp sync-await task2 > /dev/null 2>&1
}

task3() {
  blue "Configuring starter project..."
  gp sync-await task3 > /dev/null 2>&1
}

preview() {
  start_spinner "$c_green""Opening preview when server is ready$c_end"
  gp sync-await server-ready > /dev/null 2>&1  && stop_spinner 0
  #bash -ic 'op' && sleep 5 && bash -ic 'op hello_world'
  if ! bash -ic 'op hello_world'; then 
    orange "Gitpod preview command failed. This is not fatal."
    green "Try opening the preview manually using the op command or try op --help."
  fi
}

setup_msg() {
  pink "Welcome!"
  green "Your project has already been scaffolded."
  green "Getting your project up and running. This will take a minute or less."
}

task_a() {
  blue "Installing gems..."
  gp sync-await task_a > /dev/null 2>&1
}

task_b() {
  if [[ ! -d node_modules ]]; then
    blue "Installing node modules..."
  fi
  gp sync-await task_b > /dev/null 2>&1
}

task_c() {
  blue "Creating database..."
  gp sync-await task_c > /dev/null 2>&1
}

clear
if [[ ! -f .gp/bash/locks/starter.lock ]]; then
  setup_one_time_msg; task1; task2; task3; preview
else
  if [[ $(bash .gp/bash/helpers.sh is_inited) == 0 ]]; then
    setup_msg; task_a; task_b; task_c; 
    pink "All Done"
    echo -e "$c_green""Start the development server with:$c_end$c_blue dserver start$c_end"
    green "The development server will automatically compile the client assets"
    echo -e "$c_green""Once client assets are compiled, open a preview with:$c_end$c_blue op hello_world$c_end"
    echo -e "$c_green""For more help opening a preview run:$c_end$c_blue op --help$c_end"
  else
    pink "Welcome back!"
    orange "The development server and preview browser have been closed"
    echo -e "$c_green""To start the development server again, run:$c_end$c_blue dserver start$c_end"
    echo -e "$c_green""To open the preview again run something like:$c_end$c_blue op hello_world$c_end"
  fi
fi
