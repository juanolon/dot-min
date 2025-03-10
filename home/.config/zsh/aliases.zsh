alias grep='grep -i'
alias h='history'
alias vim='/usr/bin/nvim'
# alias v='f -t -e vim -b viminfo'
alias ag='ag --color-line-number=91 --color-match=31 --color-path="35" -S'
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
# alias gd='git diff'
alias gs='git status'
# alias commit='git commit -m'
# alias gA='git add -A'
alias add='git add'
# alias push='git push'
# alias pull='git pull'

alias tree='tree -CA -L 3'
alias treed='tree -dCA -L 3'

alias json='jq'

## global aliases, this is not good but it's useful
# alias -g L='|less'
# alias -g G='|grep'
# alias -g T='|tail'
# alias -g H='|head'
# alias -g W='|wc -l'
# alias -g S='|sort'
# alias -g UC='|uniq -c'
# alias -g US='|sort -u'
# alias -g NS='|sort -n'
# alias -g RNS='|sort -nr'
# alias -g N='&>/dev/null&'

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

e() (
  RELOAD='reload:rg --column --color=always --smart-case {q} || :'
  OPENER='if [[ $FZF_SELECT_COUNT -eq 0 ]]; then
            nvim {1} +{2}     # No selection. Open the current line in Vim.
          else
            nvim +cw -q {+f}  # Build quickfix list for the selected items.
          fi'
  fzf < /dev/null \
      --disabled --ansi --multi \
      --bind "start:$RELOAD" --bind "change:$RELOAD" \
      --bind "enter:become:$OPENER" \
      --bind "ctrl-o:execute:$OPENER" \
      --bind 'alt-a:select-all,alt-d:deselect-all,ctrl-/:toggle-preview' \
      --delimiter : \
      --preview 'batcat --style=full --color=always --line-range=:500 --highlight-line {2} {1}' \
      --preview-window '~4,+{2}+4/3,<80(up)' \
      --query "$*"
)

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
      --preview 'batcat --style=full --color=always --line-range=:500 {2}' \
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

function fgf() {
	local -r prompt_add="Add > "
	local -r prompt_reset="Reset > "

	local -r git_root_dir=$(git rev-parse --show-toplevel)
	local -r git_unstaged_files="git ls-files --modified --deleted --other --exclude-standard --deduplicate $git_root_dir"

	local git_staged_files='git status --short | grep "^[A-Z]" | awk "{print \$NF}"'

	local -r git_reset="git reset -- {+}"
	local -r enter_cmd="($git_unstaged_files | grep {} && git add {+}) || $git_reset"

	local -r preview_status_label="[ Status ]"
	# local -r preview_status="git status --short"
	local -r preview_status="git diff --no-ext-diff --color -- {-1} | cat; cat {-1}"

	local -r header_status=$(git status --short)
	local -r header=$(cat <<-EOF
		> CTRL-S to switch between Add Mode and Reset mode
		> CTRL_T for status preview | CTRL-F for diff preview | CTRL-B for blame preview
		> ALT-E to open files in your editor
		> ALT-C to commit | ALT-A to append to the last commit
		EOF
	)

	local -r add_header=$(cat <<-EOF
		$header_status
		$header
		> ENTER to add files
		> ALT-P to add patch
	EOF
	)

	local -r reset_header=$(cat <<-EOF
		$header
		> ENTER to reset files
		> ALT-D to reset and checkout files
	EOF
	)

	local -r mode_reset="change-prompt($prompt_reset)+reload($git_staged_files)+change-header($reset_header)+unbind(alt-p)+rebind(alt-d)"
	local -r mode_add="change-prompt($prompt_add)+reload($git_unstaged_files)+change-header($add_header)+rebind(alt-p)+unbind(alt-d)"

	eval "$git_unstaged_files" | fzf \
	--multi \
	--reverse \
	--no-sort \
	--prompt="Add > " \
	--preview-label="$preview_status_label" \
	--preview="$preview_status" \
	--header "$add_header" \
	--header-first \
	--bind='start:unbind(alt-d)' \
	--bind="ctrl-t:change-preview-label($preview_status_label)" \
	--bind="ctrl-t:+change-preview($preview_status)" \
	--bind='ctrl-f:change-preview-label([ Diff ])' \
	--bind='ctrl-f:+change-preview(git diff --color=always {} | sed "1,4d")' \
	--bind='ctrl-b:change-preview-label([ Blame ])' \
	--bind='ctrl-b:+change-preview(git blame --color-by-age {})' \
	--bind="ctrl-s:transform:[[ \$FZF_PROMPT =~ '$prompt_add' ]] && echo '$mode_reset' || echo '$mode_add'" \
	--bind="enter:execute($enter_cmd)" \
	--bind="enter:+reload([[ \$FZF_PROMPT =~ '$prompt_add' ]] && $git_unstaged_files || $git_staged_files)" \
	--bind="enter:+refresh-preview" \
	--bind='alt-p:execute(git add --patch {+})' \
	--bind="alt-p:+reload($git_unstaged_files)" \
	--bind="alt-d:execute($git_reset && git checkout {+})" \
	--bind="alt-d:+reload($git_staged_files)" \
	--bind='alt-c:execute(git commit)+abort' \
	--bind='alt-a:execute(git commit --amend)+abort' \
	--bind='alt-e:execute(${EDITOR:-vim} {+})' \
	--bind='f1:toggle-header' \
	--bind='f2:toggle-preview' \
	--bind='ctrl-y:preview-up' \
	--bind='ctrl-e:preview-down' \
	--bind='ctrl-u:preview-half-page-up' \
	--bind='ctrl-d:preview-half-page-down'
}
function fgc() {
	local -r git_log=$(cat <<-EOF
		git log --graph --color --format="%C(white)%h - %C(green)%cs - %C(blue)%s%C(red)%d"
	EOF
	)

	local -r git_log_all=$(cat <<-EOF
		git log --all --graph --color --format="%C(white)%h - %C(green)%cs - %C(blue)%s%C(red)%d"
	EOF
	)


	local get_hash
	read -r -d '' get_hash <<-'EOF'
		echo {} | grep -o "[a-f0-9]\{7\}" | sed -n "1p"
	EOF

	local -r git_show="[[ \$($get_hash) != '' ]] && git show --color \$($get_hash)"
	local -r git_show_subshell=$(cat <<-EOF
		[[ \$($get_hash) != '' ]] && sh -c "git show --color \$($get_hash) | less -R"
	EOF
	)

	local -r git_checkout="[[ \$($get_hash) != '' ]] && git checkout \$($get_hash)"
	local -r git_reset="[[ \$($get_hash) != '' ]] && git reset \$($get_hash)"
	local -r git_rebase_interactive="[[ \$($get_hash) != '' ]] && git rebase --interactive \$($get_hash)"
	local -r git_cherry_pick="[[ \$($get_hash) != '' ]] && git cherry-pick \$($get_hash)"

	local -r header=$(cat <<-EOF
		> ENTER to display the diff with less
	EOF
	)

	local -r header_branch=$(cat <<-EOF
		$header
		> CTRL-S to switch to All Commits mode
		> ALT-C to checkout the commit | ALT-R to reset to the commit
		> ALT-I to rebase interactively until the commit
	EOF
	)

	local -r header_all=$(cat <<-EOF
		$header
		> CTRL-S to switch to Branch Commits mode
		> ALT-P to cherry pick
	EOF
	)

	local -r branch_prompt='Branch > '
	local -r all_prompt='All > '

	local -r mode_all="change-prompt($all_prompt)+reload($git_log_all)+change-header($header_all)+unbind(alt-c)+unbind(alt-r)+unbind(alt-i)+rebind(alt-p)"
	local -r mode_branch="change-prompt($branch_prompt)+reload($git_log)+change-header($header_branch)+rebind(alt-c)+rebind(alt-r)+rebind(alt-i)+unbind(alt-p)"

	eval "$git_log" | fzf \
		--ansi \
		--reverse \
		--no-sort \
		--prompt="$branch_prompt" \
		--header-first \
		--header="$header_branch" \
		--preview="$git_show" \
		--bind='start:unbind(alt-p)' \
		--bind="ctrl-s:transform:[[ \$FZF_PROMPT =~ '$branch_prompt' ]] && echo '$mode_all' || echo '$mode_branch'" \
		--bind="enter:execute($git_show_subshell)" \
		--bind="alt-c:execute($git_checkout)+abort" \
		--bind="alt-r:execute($git_reset)+abort" \
		--bind="alt-i:execute($git_rebase_interactive)+abort" \
		--bind="alt-p:execute($git_cherry_pick)+abort" \
		--bind='f1:toggle-header' \
		--bind='f2:toggle-preview' \
		--bind='ctrl-y:preview-up' \
		--bind='ctrl-e:preview-down' \
		--bind='ctrl-u:preview-half-page-up' \
		--bind='ctrl-d:preview-half-page-down'
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
