alias ssh-kawalab="ssh mitsui@frigate.ic.kanazawa-it.ac.jp"

# Linux
alias la='ls -A'
alias lal='ls -all'

# Git
alias g='git'
alias gst='git status'
alias gad='git add'
alias gcm='git commit'
alias gco='git checkout'
alias gbr='git branch'

# Docker
alias dc='docker-compose'
alias dk='docker'

# Plugin
set -U FZF_LEGACY_KEYBINDINGS 0

alias dox='docker exec -it `docker ps --format '{{.Names}}' | fzf` fish'

alias vimf='vim (fzf)'
set -g theme_display_git_master_branch yes

function fish_prompt
  echo -n (set_color cyan)(prompt_pwd)(set_color green)

  # Git
  set last_status $status
  printf '%s> ' (__fish_git_prompt)
  set_color normal
end

set -gx XDG_CONFIG_HOME "$HOME/.config"

#go
set -x GOPATH "$HOME/go"
set -x PATH $PATH "$GOPATH/bin"

#mysql
set -x PATH $PATH "/usr/local/opt/mysql-client/bin"

# rbenv
status --is-interactive; and rbenv init - fish | source
