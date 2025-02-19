###########
### zsh ###
###########

whatami=${(%):-%N}
ts "$whatami starting (sourced by $0)"


# Don't require escaping globbing characters in zsh.
unsetopt nomatch

# Custom $PATH with extra locations.
export PATH=/usr/local/bin:/usr/local/sbin:$HOME/bin:$HOME/.local/bin:$PATH:/opt/homebrew/bin

# Bash-style time output.
export TIMEFMT=$'\nreal\t%*E\nuser\t%*U\nsys\t%*S'

# Alias and function definitions
source ~/.zsh_aliases
source ~/.zsh_functions

# Allow history search via up/down keys https://formulae.brew.sh/formula/zsh-history-substring-search
source $(brew --prefix)/share/zsh-history-substring-search/zsh-history-substring-search.zsh
bindkey "^[[A" history-substring-search-up
bindkey "^[[B" history-substring-search-down

ts Setup completions

# Completions.
autoload -Uz compinit && compinit
# Case insensitive.
zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*'

# Add zsh-completions to fpath
fpath=(/usr/local/share/zsh-completions $fpath)

ts Setup highlighting

# Enable https://formulae.brew.sh/formula/zsh-fast-syntax-highlighting
source $(brew --prefix)/opt/zsh-fast-syntax-highlighting/share/zsh-fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh

# Enable https://formulae.brew.sh/formula/zsh-autosuggestions
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh

##########
# HISTORY
##########

HISTSIZE=50000
SAVEHIST=50000

setopt INC_APPEND_HISTORY     # Immediately append to history file.
setopt EXTENDED_HISTORY       # Record timestamp in history.
# setopt HIST_EXPIRE_DUPS_FIRST # Expire duplicate entries first when trimming history.
setopt HIST_IGNORE_DUPS       # Dont record an entry that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS   # Delete old recorded entry if new entry is a duplicate.
setopt HIST_FIND_NO_DUPS      # Do not display a line previously found.
setopt HIST_IGNORE_SPACE      # Dont record an entry starting with a space.
setopt HIST_SAVE_NO_DUPS      # Dont write duplicate entries in the history file.
# setopt SHARE_HISTORY          # Share history between all sessions.
# unsetopt HIST_VERIFY          # Execute commands using history (e.g.: using !$) immediately

#################
### Oh My Zsh ###
#################

ts Setup oh-my-zsh plugins

# Enable plugins.
plugins=(git docker ssh-agent kubectl brew history-substring-search)

# Path to your oh-my-zsh installation.
export ZSH=/Users/mark/.oh-my-zsh

# Choose a theme.
ZSH_THEME=jnrowe

ts Load oh-my-zsh
source $ZSH/oh-my-zsh.sh
ts Load oh-my-zsh complete

############
### Apps ###
############

# Tell homebrew to not autoupdate every single time I run it (just once a week).
export HOMEBREW_AUTO_UPDATE_SECS=604800

ts Setup pyenv

## Pyenv
if [[ -d "$HOME/.pyenv" ]]; then
  # set up shims path
  eval "$(pyenv init --path)"
  # initialize pyenv autocompletions
  eval "$(pyenv init -)"
  # initialize pyenv virtualenv
  eval "$(pyenv virtualenv-init -)"
fi

ts Setup nvm

## Node version manager
export NVM_DIR="$HOME/.nvm"
[ -d $NVM_DIR ] || mkdir $NVM_DIR
brew_prefix=$(brew --prefix)
[ -s "${brew_prefix}/opt/nvm/nvm.sh" ] && \. "${brew_prefix}/opt/nvm/nvm.sh"  # This loads nvm
[ -s "${brew_prefix}/opt/nvm/etc/bash_completion.d/nvm" ] && \. "${brew_prefix}/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

# Tell gpg-agent to manage this shell.
export GPG_TTY=$(tty)

ts Load .docker/init-zsh.sh

source /Users/mark/.docker/init-zsh.sh || true # Added by Docker Desktop

ts Load fuzzy finder

# Enable fuzzy finder
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

whatami=${(%):-%N}
ts "$whatami finished (sourced by $0)"
