#!/usr/bin/env zsh

fpath=($ZDOTDIR/plugins $fpath)

# +------------+
# | NAVIGATION |
# +------------+

# setopt AUTO_CD              # Go to folder path without using cd.

setopt AUTO_PUSHD           # Push the old directory onto the stack on cd.
setopt PUSHD_IGNORE_DUPS    # Do not store duplicates in the stack.
setopt PUSHD_SILENT         # Do not print the directory stack after pushd or popd.

setopt CORRECT              # Spelling correction
setopt CDABLE_VARS          # Change directory to a path stored in a variable.
setopt EXTENDED_GLOB        # Use extended globbing syntax.

# +---------+
# | HISTORY |
# +---------+

setopt EXTENDED_HISTORY          # Write the history file in the ':start:elapsed;command' format.
setopt SHARE_HISTORY             # Share history between all sessions.
setopt HIST_EXPIRE_DUPS_FIRST    # Expire a duplicate event first when trimming history.
setopt HIST_IGNORE_DUPS          # Do not record an event that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS      # Delete an old recorded event if a new event is a duplicate.
setopt HIST_FIND_NO_DUPS         # Do not display a previously found event.
setopt HIST_IGNORE_SPACE         # Do not record an event starting with a space.
setopt HIST_SAVE_NO_DUPS         # Do not write a duplicate event to the history file.
setopt HIST_VERIFY               # Do not execute immediately upon history expansion.

# PROMPT
eval "$(/usr/local/bin/starship init zsh)"

# COLORS
source $ZDOTDIR/current-lscolor.zsh

# FUNCTIONS
fpath=($ZDOTDIR/plugins/archive/functions $fpath)
autoload -Uz archive
autoload -Uz lsarchive
autoload -Uz unarchive

eval "$(jump shell zsh)"

# forgit
export PATH=$PATH:$ZDOTDIR/plugins/git-fuzzy/bin

source $ZDOTDIR/plugins/forgit/forgit.plugin.zsh
export PATH=$PATH:$ZDOTDIR/plugins/forgit/bin

# ALIASES
source $ZDOTDIR/aliases.zsh

# COMPLETION
# use modified zpresto completion settings
source $ZDOTDIR/completion.zsh

# BINDINGS

# zzbindings: original zpresto bindings file
# zbindings: striped version of zpresto bindings file
source "$ZDOTDIR/zbindings.zsh"
# source "$ZDOTDIR/zzbindings.zsh"

# TODO move this to bindings file
# ^d should not close the window
autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
# CLI EDITING {{{
# bindkey "^j" history-beginning-search-forward ## down arrow for fwd-history-search
# bindkey "^k" history-beginning-search-backward ## up arrow for back-history-search
bindkey "^k" up-line-or-beginning-search ## down arrow for fwd-history-search
bindkey "^j" down-line-or-beginning-search ## up arrow for back-history-search

bindkey "^h" backward-char
bindkey "^l" forward-char

bindkey "^w" forward-word ## go forward one word
bindkey "^b" backward-word ## go back one word

bindkey "^d" backward-kill-word
bindkey '^e' end-of-line
bindkey '^a' beginning-of-line

bindkey '^u' undo
bindkey '^r' redo

bindkey  "^_" history-incremental-pattern-search-backward # ctrl+?
bindkey '^.' history-incremental-pattern-search-forward # ctrl+.

# }}}


# PYENV
# TODO why doesn't work in zshenv?
# export PYENV_ROOT=$HOME/.pyenv
# [[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
# eval "$(pyenv init - zsh)"
source "$ZDOTDIR/python.zsh"


# SSH ENV
SSH_ENV=$HOME/.ssh/environment

# start the ssh-agent
function start_agent {
    echo "Initializing new SSH agent..."
    # spawn ssh-agent
    /usr/bin/ssh-agent | sed 's/^echo/#echo/' > ${SSH_ENV}
    echo succeeded
    chmod 600 ${SSH_ENV}
    . ${SSH_ENV} > /dev/null
    /usr/bin/ssh-add
}

if [ -f "${SSH_ENV}" ]; then
     . ${SSH_ENV} > /dev/null
     ps -ef | grep ${SSH_AGENT_PID} | grep ssh-agent$ > /dev/null || {
        start_agent;
    }
else
    start_agent;
fi

# mcfly - shell history
# TODO: change dark/light theme with day-night
export MCFLY_LIGHT=FALSE
export MCFLY_KEY_SCHEME=vim
export MCFLY_INTERFACE_VIEW=BOTTOM
export MCFLY_PROMPT="※"
eval "$(mcfly init zsh)"

# nvm: node version manager
export NVM_DIR="$HOME/.config/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
# pnpm
export PNPM_HOME="/home/juanolon/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

# homeshick
source "$HOME/.homesick/repos/homeshick/homeshick.sh"

# SYNTAX HIGHLIGHTING
# must be at the end of file
source $ZDOTDIR/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
