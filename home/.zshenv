export EDITOR="nvim"
export VISUAL="nvim"

export DOTFILES="$HOME/repos/dotfiles-linux"

export MANPAGER='nvim +Man!'
# export MANPAGER="sh -c 'col -bx | batcat -l man -p'"

export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_SCREENSHOTS_DIR="$HOME/Pictures/Screenshots"

export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
export HISTFILE="$XDG_CACHE_HOME/zsh/.zhistory"    # History filepath
export HISTSIZE=10000                   # Maximum events for internal history
export SAVEHIST=10000                   # Maximum events in history file

export STARSHIP_CONFIG=$ZDOTDIR/starship.toml

export PATH=$PATH:$HOME/docker/bin

# export JAVA_HOME=$(readlink -f /usr/bin/javac | sed "s:/bin/javac::")

export PATH=$PATH:$HOME/.bin

# npm {{{
export NODE_PATH=$HOME/.npm-packages
export PATH=$PATH:$HOME/.npm-packages/bin
# }}}

# python {{{
export PATH=$PATH:$HOME/.local/bin/
export PYTHONSTARTUP=$HOME/.pythonrc
export PIPENV_VENV_IN_PROJECT=1

# export PYENV_ROOT=$HOME/.pyenv
# [[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
# eval "$(pyenv init - zsh)"
# }}}

# golang {{{
export GOPATH=$HOME/gocode
export PATH=$PATH:/usr/local/go/bin:/home/juanolon/gocode/bin
# }}}


# PHP {{{
# if composer installed: composer global config bin-dir --absolute --quiet
export COMPOSER_HOME=/home/juanolon/.config/composer
export PATH=$PATH:/home/juanolon/.config/composer/vendor/bin
# }}}

# ANDROID {{
export ANDROID_SDK_ROOT=${HOME}/.android
export ANDROID_HOME=${HOME}/.android/
export PATH=${PATH}:${ANDROID_HOME}/cmdline-tools/latest/bin:${ANDROID_HOME}
export PATH=${PATH}:${ANDROID_HOME}/platform-tools
export PATH=${PATH}:/usr/local/bin/genymotion
# }}

# DART {{
export DART_HOME=${HOME}/.dart
export PATH=${PATH}:${DART_HOME}/bin:${HOME}/.pub-cache/bin
# }}

# FLUTTER {{
export FLUTTER_HOME=${HOME}/.fluttersdk
export PATH=${PATH}:${FLUTTER_HOME}/bin
# zstyle ':completion:*:*:flutter:*' script ~/.git-completion.bash
# }}

# LATEX {{
export MANPATH=${MANPATH}:~/.TinyTeX/texmf-dist/doc/man
# export INFOPATH=${INFOPATH}:~/.TinyTeX/texmf-dist/doc/info
export PATH=${PATH}:~/.TinyTeX/bin/x86_64-linux
# }}

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# GEOMETRY_PROMPT=(geometry_status geometry_echo geometry_hostname geometry_path)
# PROMPT_GEOMETRY_RPROMPT_ASYNC=true
# GEOMETRY_PROMPT_PLUGINS=(virtualenv git)
# PROMPT_GEOMETRY_COLORIZE_ROOT=true
# source $HOME/repos/geometry/geometry.zsh


# requirement for CG exercises
export MESA_GL_VERSION_OVERRIDE=3.3
export LIBGL_DEBUG=somethingelse
# export LIBGL_DEBUG=verbose
# export MESA_DEBUG=1

# xset dpms 0 0 0 # disable display power managemenet system

# ROS
# export ROS_MASTER_URI=http://192.168.1.170:11311
# export ROS_IP=http://192.168.1.188:11311
# export ROS_HOSTNAME=http://192.168.1.188:11311

# ZK
export ZK_NOTEBOOK_DIR=$HOME/notes

# cargo
export PATH=$PATH:$HOME/.cargo/bin

# perl
# export PATH=$PATH:$HOME/perl5/bin
# eval $(perl -I ~/perl5/lib/perl5 -Mlocal::lib)

# fzf
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border'

# WAYLAND enabled
export MOZ_ENABLE_WAYLAND=1
export ANKI_WAYLAND=1
export QT_QPA_PLATFORM=wayland
export XDG_CURRENT_DESKTOP=sway
# export XDG_CURRENT_DESKTOP=niri

# sass
export PATH=$PATH:$HOME/.bin/dart-sass

# cargo env
if [ -f "$HOME/.cargo/env" ]; then
    . "$HOME/.cargo/env"
fi
