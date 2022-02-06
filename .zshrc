###########
### zsh ###
###########

whatami=${(%):-%N}
echo -e "Hello from $whatami (sourced by $0)"

# Don't require escaping globbing characters in zsh.
unsetopt nomatch

# Custom $PATH with extra locations.
export PATH=/usr/local/bin:/usr/local/sbin:$HOME/bin:$PATH

# Bash-style time output.
export TIMEFMT=$'\nreal\t%*E\nuser\t%*U\nsys\t%*S'

# Alias definitions
source ~/.zsh_aliases

# Allow history search via up/down keys https://formulae.brew.sh/formula/zsh-history-substring-search
source $(brew --prefix)/share/zsh-history-substring-search/zsh-history-substring-search.zsh
bindkey "^[[A" history-substring-search-up
bindkey "^[[B" history-substring-search-down

# Completions.
autoload -Uz compinit && compinit
# Case insensitive.
zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*'

# Add zsh-completions to fpath
fpath=(/usr/local/share/zsh-completions $fpath)

# Enable https://formulae.brew.sh/formula/zsh-fast-syntax-highlighting
source $(brew --prefix)/opt/zsh-fast-syntax-highlighting/share/zsh-fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh

# Enable https://formulae.brew.sh/formula/zsh-autosuggestions
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh

#################
### Oh My Zsh ###
#################

# Enable plugins.
plugins=(git docker ssh-agent kubectl brew history-substring-search)

# Path to your oh-my-zsh installation.
export ZSH=/Users/mark/.oh-my-zsh

# Choose a theme.
ZSH_THEME=jnrowe

source $ZSH/oh-my-zsh.sh

############
### Apps ###
############

# Tell homebrew to not autoupdate every single time I run it (just once a week).
export HOMEBREW_AUTO_UPDATE_SECS=604800

## Pyenv
if [[ -d "$HOME/.pyenv" ]]; then
  # initialize pyenv
  eval "$(pyenv init -)"
  # initialize pyenv virtualenv
  eval "$(pyenv virtualenv-init -)"
fi

## Node version manager
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Tell gpg-agent to manage this shell.
export GPG_TTY=$(tty)
