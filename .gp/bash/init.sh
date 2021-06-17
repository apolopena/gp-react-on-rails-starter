#!/bin/bash
#
# SPDX-License-Identifier: MIT
# Copyright © 2021 Apolo Pena
#
# init.sh
# Description:
# Conditional project setup
#

if [[ ! -f .gp/bash/locks/starter.lock ]]; then
  # Move, rename or merge any internal starter project files that need it
  [[ -f "LICENSE" && -d ".gp" && ! -f .gp/LICENSE ]] && mv -f LICENSE .gp/LICENSE
  [[ -f "README.md" && -d ".gp" && ! -f .gp/README.md ]] && mv -f README.md .gp/README.md
  [[ -f "CHANGELOG.md" && -d ".gp" && ! -f .gp/CHANGELOG.md ]] && mv -f CHANGELOG.md .gp/CHANGELOG.md
  
  # Set up project starter, one-time operation
  bundle install && rake db:create && gp sync-done task1 &&
  bash .gp/bash/scaffold-react.sh && gp sync-done task2 &&
  yes | bash .gp/bash/configure-new.sh && gp sync-done task3 &&
  if [[ ! -d .gp/bash/locks ]]; then mkdir .gp/bash/locks; fi
  touch .gp/bash/locks/starter.lock
  bash .gp/bash/helpers.sh mark_as_inited
  bash -ic 'dserver start' & sleep 20 && gp sync-done server-ready
else
  # Hook: if puma is installed, then assume that bundle install has already been called
  if [[ $(gem list puma -i) == 'false' ]]; then 
    bundle
  fi
  gp sync-done task_a
  # Hook: if node_modules is present then assume yarn install has already been called
  if [[ ! -d node_modules ]]; then
    yarn
  fi
  gp sync-done task_b
  # Hook: check if demo_development db exists in postgresql. if not create itm  
  if  [[ -z $( psql -tAc "SELECT 1 FROM pg_database WHERE datname='demo_development'" ) ]]; then
    rake db:create
  fi
  bash .gp/bash/helpers.sh mark_as_inited
  gp sync-done task_c
fi