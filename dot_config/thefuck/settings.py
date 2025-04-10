# The Fuck settings file
#
# The rules are defined as in the example bellow:
#
# rules = ['cd_parent', 'git_push', 'python_command', 'sudo']
#
# The default values are as follows. Uncomment and change to fit your needs.
# See https://github.com/nvbn/thefuck#settings for more information.
#

# Rules enabled by default
rules = [
    'sudo',                # Prepends sudo to the previous command
    'no_command',         # Fixes wrong command names
    'cd_parent',          # Changes .. to cd ..
    'git_push',           # Fixes common git push errors
    'git_checkout',       # Fixes git checkout errors
    'git_pull',           # Fixes git pull errors
    'git_branch_exists',  # Fixes git branch creation errors
    'pip_unknown_command',# Fixes pip command errors
    'brew_unknown_command',# Fixes brew command errors
    'brew_install',       # Fixes brew installation errors
    'brew_upgrade',       # Fixes brew upgrade errors
    'mkdir_p',           # Adds -p to mkdir automatically
    'ssh_known_hosts',   # Fixes SSH known hosts errors
    'grep_recursive',    # Adds -r to grep when needed
    'docker_not_command',# Fixes docker command errors
    'ls_all',           # Adds -a to ls when needed
    'yarn_command_not_found', # Fixes yarn command errors
    'npm_command_not_found',  # Fixes npm command errors
]

# Use a more visible color for the command suggestion
require_confirmation = True
wait_command = 3
no_colors = False
priority = {'sudo': 100, 'no_command': 9999}
debug = False
history_limit = 9999
alter_history = True
wait_slow_command = 15
slow_commands = ['lein', 'react-native', 'gradle', './gradlew', 'vagrant']
repeat = False
instant_mode = True
num_close_matches = 4
excluded_search_path_prefixes = []

# Environment variables
env = {'LC_ALL': 'C', 'LANG': 'C', 'GIT_TRACE': '1'}