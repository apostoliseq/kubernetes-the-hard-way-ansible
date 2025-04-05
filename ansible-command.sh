#!/bin/bash

ansible-playbook playbook.yml --ask-become-pass
# ansible-playbook playbook.yml --ask-become-pass -vvv

# if [ -z "$1" ]; then
#     echo "Usage: $0 <playbook-file> [ansible-playbook-options]"
#     exit 1
# fi

# PLAYBOOK_FILE="$1"
# shift  # Remove the first argument (playbook file) to pass the rest to ansible-playbook

# if [ ! -f "$PLAYBOOK_FILE" ]; then
#     echo "Error: Playbook file '$PLAYBOOK_FILE' not found!"
#     exit 1
# fi

# ansible-playbook "$PLAYBOOK_FILE" "$@"

# ansible-playbook tags.yml --tags <tag>
# ansible-playbook tags.yml --list-tags
# ansible-playbook tags.yml --skip-tags
# ansible-playbook tags.yml --start-at-task 'Generate resources'
# ansible-playbook tags.yml --step
## - hosts: localhost
##   connection: local
# ansible-playbook use_templates.yml --check
# ~/projects/my-ansible-project/roles$ ansible-galaxy init testrole1