alias grep='grep -i'
alias h='history'
alias vim='/usr/bin/nvim'
# alias v='f -t -e vim -b viminfo'
# alias ag='ag --color-line-number=91 --color-match=31 --color-path=35 --nogroup -S'
alias ag='ag --color-line-number=91 --color-match=31 --color-path=35 -S' 
alias agg='ag -g'
alias mv='nocorrect mv -i'
alias cp='nocorrect cp -i'
alias rm='nocorrect rm -i'
alias mkdir='nocorrect mkdir -p'
alias man='nocorrect man'
alias find='noglob fdfind'
alias grep='grep --colour'
alias less='less -R'
alias ran='ranger-cd'
alias ls='ls --color=auto'
alias l='ls'
alias ll='ls -hl'
alias la='ls -alh'
alias lsh='ls -ls .*' ## list only file beginning with "."
alias lsd='ls -ld *(-/DN)' ## list only dirs
# alias c='fasd_cd -d'
alias :q='exit'

# git
alias gd='git df'
alias gs='git status'
# alias commit='git commit -m'
# alias gA='git add -A'
alias add='git add'
# alias push='git push'
# alias pull='git pull'

alias tree='tree -CA -L 3'
alias treed='tree -dCA -L 3'

alias json='jq'

alias -g feh='feh --scale-down --auto-zoom'
# alias qutebrowser='export set PYTHONPATH=/usr/local/lib/python3.5/site-packages/:/usr/local/Cellar/pyqt5/5.5_1/lib/python3.5/site-packages/ && qutebrowser'

#Show progress while file is copying

# Rsync options are:
#  -p - preserve permissions
#  -o - preserve owner
#  -g - preserve group
#  -h - output in human-readable format
#  --progress - display progress
#  -b - instead of just overwriting an existing file, save the original
#  --backup-dir=/tmp/rsync - move backup copies to "/tmp/rsync"
#  -e /dev/null - only work on local files
#  -- - everything after this is an argument, even if it looks like an option

alias cpv="rsync -poghb --backup-dir=/tmp/rsync -e /dev/null --progress --"

alias icat="kitty +kitten icat"

alias ne="zk edit"

zcompile_all() {
  local file zwc
  for file in "${ZDOTDIR:-$HOME}"**/*.zsh; do
    zwc=${file%.zsh}.zwc
    if [[ "$file" -nt "$zwc" ]]; then
      zcompile "$file"
    fi
  done
  echo "Recompiled any changed .zsh → .zwc files."
}


usb() {
  error_exit() {
    echo "Error: $1" >&2
    return 1
  }

  USB_ENTRY=$(mount | awk '$1 ~ "/dev/sd" && $3 != "/data"')
  MOUNT_POINT=$(echo "$USB_ENTRY" | awk '{print $3}')
  DEVICE=$(echo "$USB_ENTRY" | awk '{print $1}')
  FILE_SYSTEM=$(echo "$USB_ENTRY" | awk '{print $5}')

  if [[ -z "$MOUNT_POINT" ]]; then
    error_exit "No USB device found or mounted."
    return 1
  fi

  case "$1" in
    cd)
      if cd "$MOUNT_POINT"; then
        echo "Changed directory to: $MOUNT_POINT"
      else
        error_exit "Could not change directory to $MOUNT_POINT."
        return 1
      fi
      ;;
    open)
      if command -v yy >/dev/null 2>&1; then
        yy "$MOUNT_POINT" || error_exit "Could not open $MOUNT_POINT."
        echo "Opened: $MOUNT_POINT"
      else
        error_exit "The 'yy' command is not available."
        return 1
      fi
      ;;
    info)
      echo "USB Device Information:"
      echo "  Path: $MOUNT_POINT"
      echo "  Device: $DEVICE"
      echo "  File System: $FILE_SYSTEM"
      echo "  Total Size: $(df -h "$MOUNT_POINT" | awk 'NR==2 {print $2}')"
      echo "  Used: $(df -h "$MOUNT_POINT" | awk 'NR==2 {print $3}')"
      echo "  Available: $(df -h "$MOUNT_POINT" | awk 'NR==2 {print $4}')"
      ;;
    umount)
      if umount "$MOUNT_POINT"; then
        echo "Successfully unmounted: $MOUNT_POINT ($DEVICE)"
      else
        error_exit "Failed to unmount $MOUNT_POINT ($DEVICE). Make sure it's not in use."
        return 1
      fi
      ;;
    *)
      echo "Usage: usb [cd|open|info|umount]"
      echo "  cd     - Change directory to the USB mount point."
      echo "  open   - Open the USB mount point in the default file manager."
      echo "  info   - Display information about the mounted USB device."
      echo "  umount - Unmount the USB device."
      return 1
      ;;
  esac
}

f() {
  local show_hidden=false
  local type_filter=""      # “file” or “dir”
  local query=""            # the current fzf query
  local debug=true          # set to false to silence debug prints

  # ─── Build the fdfind command string ────────────────────────
  build_cmd() {
    local cmd="fdfind --color=always -L"
    $show_hidden      && cmd+=" --hidden"
    [[ "$type_filter" == file ]] && cmd+=" -t f"
    [[ "$type_filter" == dir  ]] && cmd+=" -t d"
    # cmd+=" -- ."             # list everything under "."
    # cmd+=" || :"          # swallow errors (e.g. no matches)
    cmd+=" --"             # list everything under "."
    echo "$cmd"
  }

  # ─── Build the prompt (replacing the “> “) ─────────────────
  build_prompt_status() {
    local parts=()
    $show_hidden      && parts+=("[HIDDEN]")
    [[ "$type_filter" == file ]] && parts+=("[FILES]")
    [[ "$type_filter" == dir  ]] && parts+=("[DIRS]")
    if (( ${#parts} )); then
      echo "${(j: :)parts} > "
    else
      echo "> "
    fi
  }

  local help="Ctrl-H: hidden | Ctrl-E: files | Ctrl-D: dirs | Ctrl-R: reset | Enter: open"

  while true; do
    local reload_cmd prompt_status output

    reload_cmd=$(build_cmd)
    prompt_status=$(build_prompt_status)

    $debug && print -u2 "DEBUG CMD: $reload_cmd"

    # ─── Launch fzf ────────────────────────────────────────────
    output=$(
      fzf < /dev/null \
        --ansi \
        --layout=reverse \
        --query="$query" \
        --print-query \
        --header="$help" \
        --prompt="$prompt_status" \
        --bind "start:reload:$reload_cmd {q} -- . || :" \
        --bind "change:reload:$reload_cmd {q} -- . || :" \
        --bind "ctrl-h:abort" \
        --bind "ctrl-e:abort" \
        --bind "ctrl-d:abort" \
        --bind "ctrl-r:abort" \
        --preview '[[ -d {1} ]] && tree -C {1} | head -200 || batcat --theme ansi --style=full --color=always {1}' \
        --preview-window 'nohidden,40%,<50(down,50%,border-rounded)' \
        --expect ctrl-h,ctrl-e,ctrl-d,ctrl-r,enter
    )

    # Exit on ESC (empty output)
    [[ -z "$output" ]] && return

    # Split into lines: 1=query, 2=key, 3=selection
    local -a lines
    IFS=$'\n' read -rd '' -A lines <<<"$output"
    query="${lines[1]}"
    key="${lines[2]}"
    selected="${lines[3]}"

    case "$key" in
      ctrl-h)
        show_hidden=$([ "$show_hidden" = false ] && echo true || echo false)
        ;;
      ctrl-e)
        [[ "$type_filter" == file ]] && type_filter="" || type_filter="file"
        ;;
      ctrl-d)
        [[ "$type_filter" == dir ]] && type_filter="" || type_filter="dir"
        ;;
      ctrl-r)
        show_hidden=false
        type_filter=""
        ;;
      enter)
        if [[ -n "$selected" ]]; then
          if [[ -d "$selected" ]]; then
            cd "$selected"
          else
            nvim "$selected"
          fi
        fi
        return
        ;;
      *)
        return
        ;;
    esac
    # Loop back: fzf will reopen with same query + updated filters
  done
}


t-widget() {
  zle -I
  f
  zle reset-prompt
}
zle -N t-widget
bindkey '^T' t-widget

s() (
  RELOAD='reload:rg --column -L --color=always --smart-case {q} || :'
  OPENER='if [[ $FZF_SELECT_COUNT -eq 0 ]]; then
            nvim {1} +{2}     # No selection. Open the current line in Vim.
          else
            nvim +cw -q {+f}  # Build quickfix list for the selected items.
          fi'
  fzf < /dev/null \
      --disabled --ansi --multi \
      --layout=reverse \
      --bind "start:$RELOAD" --bind "change:$RELOAD" \
      --bind "enter:become:$OPENER" \
      --bind "ctrl-o:execute:$OPENER" \
      --bind 'alt-a:select-all,alt-d:deselect-all,ctrl-/:toggle-preview' \
      --delimiter : \
      --preview 'batcat --theme ansi --style=full --color=always --line-range=:500 --highlight-line {2} {1}' \
    --preview-window "nohidden,40%,<50(down,50%,border-rounded)" \
      --query "$*"
)

s-widget() {
  zle -I
  s
  zle reset-prompt
}
zle -N s-widget
bindkey '^S' s-widget

n() (
  RELOAD='reload:docsim --show-scores --limit 5 --best-first {q} ~/notes/**/*.md || :'
  OPENER='if [[ $FZF_SELECT_COUNT -eq 0 ]]; then
            nvim {2} +{3}     # No selection. Open the current line in Vim.
          else
            nvim +cw -q {+f}  # Build quickfix list for the selected items.
          fi'
  fzf < /dev/null \
      --disabled --ansi --multi \
      --bind "start:$RELOAD" --bind "change:$RELOAD" \
      --bind "enter:become:$OPENER" \
      --bind "ctrl-o:execute:$OPENER" \
      --bind 'alt-a:select-all,alt-d:deselect-all,ctrl-/:toggle-preview' \
      --delimiter "\\t" \
      --preview 'batcat --theme ansi --style=full --color=always --line-range=:500 {2}' \
      --preview-window '~4,<80(up)' \
      --query "$*"
)

fkill() {
    local pid 
    if [ "$UID" != "0" ]; then
        pid=$(ps -f -u $UID | sed 1d | fzf -m | awk '{print $2}')
    else
        pid=$(ps -ef | sed 1d | fzf -m | awk '{print $2}')
    fi  

    if [ "x$pid" != "x" ]
    then
        echo $pid | xargs kill -${1:-9}
    fi  
}

function yy() {
    local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
    yazi "$@" --cwd-file="$tmp"
    if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
        cd -- "$cwd"
    fi
    rm -f -- "$tmp"
}

function fgb() {
	local -r git_branches="git branch --all --color --format=$'%(HEAD) %(color:yellow)%(refname:short)\t%(color:green)%(committerdate:short)\t%(color:blue)%(subject)' | column --table --separator=$'\t'"
	local -r get_selected_branch='echo {} | sed "s/^[* ]*//" | awk "{print \$1}"'
	local -r git_log="git log \$($get_selected_branch) --graph --color --format='%C(white)%h - %C(green)%cs - %C(blue)%s%C(red)%d'"
	local -r git_diff='git diff --color $(git branch --show-current)..$(echo {} | sed "s/^[* ]*//" | awk "{print \$1}")'
	local -r git_show_subshell=$(cat <<-EOF
		[[ \$($get_selected_branch) != '' ]] && sh -c "git show --color \$($get_selected_branch) | less -R"
	EOF
	)
	local -r header=$(cat <<-EOF
	> ALT-M to merge with current * branch | ALT-R to rebase with current * branch
	> ALT-C to checkout the branch
	> ALT-D to delete the merged local branch | ALT-X to force delete the local branch
	> ENTER to open the diff with less
	EOF
	)

	eval "$git_branches" \
	| fzf \
		--ansi \
		--reverse \
		--no-sort \
		--preview-label '[ Commits ]' \
		--preview "$git_log" \
		--header-first \
		--header="$header" \
		--bind="alt-c:execute(git checkout \$($get_selected_branch))" \
		--bind="alt-c:+reload($git_branches)" \
		--bind="alt-m:execute(git merge \$($get_selected_branch))" \
		--bind="alt-r:execute(git rebase \$($get_selected_branch))" \
		--bind="alt-d:execute(git branch --delete \$($get_selected_branch))" \
		--bind="alt-d:+reload($git_branches)" \
		--bind="alt-x:execute(git branch --delete --force \$($get_selected_branch))" \
		--bind="alt-x:+reload($git_branches)" \
		--bind="enter:execute($git_show_subshell)" \
		--bind='ctrl-f:change-preview-label([ Diff ])' \
		--bind="ctrl-f:+change-preview($git_diff)" \
		--bind='ctrl-i:change-preview-label([ Commits ])' \
		--bind="ctrl-i:+change-preview($git_log)" \
		--bind='f1:toggle-header' \
		--bind='f2:toggle-preview' \
		--bind='ctrl-y:preview-up' \
		--bind='ctrl-e:preview-down' \
		--bind='ctrl-u:preview-half-page-up' \
		--bind='ctrl-d:preview-half-page-down'
}
