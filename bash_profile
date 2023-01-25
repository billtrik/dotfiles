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

# Brew completion
if type brew &>/dev/null
then
  HOMEBREW_PREFIX="$(brew --prefix)"
  if [[ -r "${HOMEBREW_PREFIX}/etc/profile.d/bash_completion.sh" ]]
  then
    source "${HOMEBREW_PREFIX}/etc/profile.d/bash_completion.sh"
  else
    for COMPLETION in "${HOMEBREW_PREFIX}/etc/bash_completion.d/"*
    do
      [[ -r "${COMPLETION}" ]] && source "${COMPLETION}"
    done
  fi
fi

# Include brew bins in PATH
export PATH=.:$HOMEBREW_PREFIX/sbin:$HOMEBREW_PREFIX/bin:$HOME/bin:$PATH

# NODE PATH
export NODE_PATH=$HOMEBREW_PREFIX/lib/node_modules

## NPM PATH
export PATH=./node_modules/.bin:$PATH

# Yarn
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

## Add ~/bin to the path
export PATH=~/bin:$PATH
 
# Poetry stuff
export PATH="$HOME/.poetry/bin:$PATH"

# RBENV STUFF
# export RBENV_ROOT=/usr/local/var/rbenv
eval "$(rbenv init -)"

## Direnv
eval "$(direnv hook bash)"

## ondir
[ -f $HOME/.hook_ondir.sh ] && source $HOME/.hook_ondir.sh

# Deprecations
export BASH_SILENCE_DEPRECATION_WARNING=1
export TK_SILENCE_DEPRECATION=1

# Terraform
complete -C "${HOMEBREW_PREFIX}/bin/terraform" terraform

export EDITOR='vim'

echo Provided By Bilou Industries C.O.
echo
