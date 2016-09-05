# Load custom shell dotfiles:
for file in ~/.{bash_prompt,aliases,functions,env}; do
  [ -r "$file" ] && source "$file"
done
unset file

# Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob

# Append to the Bash history file, rather than overwriting it
shopt -s histappend

# Autocorrect typos in path names when using `cd`
shopt -s cdspell

# Enable some Bash 4 features when possible:
# * `autocd`, e.g. `**/qux` will enter `./foo/bar/baz/qux`
# * Recursive globbing, e.g. `echo **/*.txt`
for option in autocd globstar; do
  shopt -s "$option" 2> /dev/null
done

# Prefer US English and use UTF-8
export LC_ALL="en_US.UTF-8"
export LANG="en_US"

# Add tab completion for SSH hostnames based on ~/.ssh/config, ignoring wildcards
[ -e "$HOME/.ssh/config" ] && complete -o "default" -o "nospace" -W "$(grep "^Host" ~/.ssh/config | grep -v "[?*]" | cut -d " " -f2)" scp sftp ssh

# Add tab completion for `defaults read|write NSGlobalDomain`
# You could just use `-g` instead, but I like being explicit
complete -W "NSGlobalDomain" defaults

# Add `killall` tab completion for common apps
complete -o "nospace" -W "Contacts Calendar Dock Finder Mail Safari iTunes SystemUIServer Terminal Twitter" killall

# If possible, add tab completion for many more commands
[ -f /etc/bash_completion ] && source /etc/bash_completion

# Load git completions
[ -f /usr/local/etc/bash_completion.d/git-prompt.sh ] && source /usr/local/etc/bash_completion.d/git-prompt.sh
[ -f /usr/local/etc/bash_completion.d/git-completion.bash ] && source /usr/local/etc/bash_completion.d/git-completion.bash

# Include brew bins in PATH
PATH=.:/usr/local/sbin:/usr/local/bin:/Users/billtrik/bin:$PATH
export PATH

# Load NPM autocompletion
[ -f /usr/local/lib/node_modules/npm/lib/utils/completion.sh ] && source /usr/local/lib/node_modules/npm/lib/utils/completion.sh

# Load GRUNT autocompletion
# eval "$(grunt --completion=bash)"

# RBENV STUFF
# export RBENV_ROOT=/usr/local/var/rbenv
eval "$(rbenv init -)"

# NODE STUFF
export NODE_PATH=/usr/local/lib/node_modules

## NPM STUFF
PATH=./node_modules/.bin:$PATH
export PATH

export EDITOR='subl -w'

echo Provided By Bilou Industries C.O.
echo
