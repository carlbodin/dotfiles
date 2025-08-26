# ===============================================================
# Purposes:
# 1. Command bar information (time, user, host, path, git branch)
# 2. Bash history (timestamp, size)
# 3. Aliases
# 4. Setup programs, keybindings, and autocomplete
# 5. Setup path with environment variables
# ===============================================================

# If not running interactively, don't do anything.
[[ $- != *i* ]] && return

# If there are local extensions to .bashrc, add them.
[[ -f ~/.bashrc_local ]] && . ~/.bashrc_local

# Add timestamp to bash history.
export HISTTIMEFORMAT="%Y-%m-%d %H:%M:%S "

# History length.
HISTSIZE=3000
HISTFILESIZE=5000

# PS1 command prompt.
get_directory_name() {
    local display_path=$(dirs +0)
    if git rev-parse --is-inside-work-tree &>/dev/null; then
        local git_root=$(git rev-parse --show-toplevel)
        local rel_path="${PWD#$git_root}"
        local git_root_name="${git_root##*/}"
        echo "${git_root_name}${rel_path}"
    else
        echo "$display_path"
    fi
}
get_git_branch() {
    if git rev-parse --is-inside-work-tree &>/dev/null; then
        echo " ($(git rev-parse --abbrev-ref HEAD))"
    else
        echo " "
    fi
}
PS1='\[\033[38;5;242m\]$(date +"%H:%M") \[\033[38;5;2m\]\u@\h \[\033[38;5;6m\]$(get_directory_name)\[\033[38;5;3m\]$(get_git_branch)\[\033[0m\]$ '

# Aliases.
alias ls='ls --color=auto'
alias ll='ls -la --color=auto'
alias l='ls --color=auto'
alias grep='grep --color=auto'
alias o='xdg-open'
alias pss='ps -aux | grep'
alias fz='fzf --preview "cat {}" | xargs -r code'
alias po='sudo udisksctl power-off -b'  # Power off block device.

# Set up fzf key bindings and fuzzy completion.
eval "$(fzf --bash)"
