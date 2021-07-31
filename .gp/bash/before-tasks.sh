#!/bin/bash
#
# SPDX-License-Identifier: MIT
# Copyright © 2021 Apolo Pena
#
# before-tasks.sh
# Description:
# Tasks that should be run everytime the worspace is created or started.
# 


# Aliases for git
bash .gp/bash/utils.sh add_file_to_file_after "\\[alias\\]" .gp/snippets/git/emoji-log ~/.gitconfig &&
bash .gp/bash/utils.sh add_file_to_file_after "\\[alias\\]" .gp/snippets/git/aliases ~/.gitconfig