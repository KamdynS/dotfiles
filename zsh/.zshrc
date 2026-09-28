# Powerlevel10k needs a terminal-backed interactive shell.
if [[ -t 0 || -t 1 ]] &&
  [[ -r "$XDG_CACHE_HOME/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "$XDG_CACHE_HOME/p10k-instant-prompt-${(%):-%n}.zsh"
fi

typeset -U fpath
_brew_prefix="${HOMEBREW_PREFIX:-/opt/homebrew}"
_omz_plugins="$XDG_DATA_HOME/oh-my-zsh/plugins"
export ZSH_CACHE_DIR="$XDG_CACHE_HOME/oh-my-zsh"
mkdir -p "$ZSH_CACHE_DIR/completions" "$XDG_CACHE_HOME/zsh" "$XDG_DATA_HOME/zsh"
fpath=("$ZSH_CACHE_DIR/completions" "$_omz_plugins/docker/completions" "$_brew_prefix/share/zsh/site-functions" $fpath)

autoload -Uz compinit
compinit -d "$XDG_CACHE_HOME/zsh/zcompdump"

_mise="${commands[mise]:-$_brew_prefix/bin/mise}"
[[ -x "$_mise" ]] && eval "$("$_mise" activate zsh)"

HISTSIZE=10000
SAVEHIST=10000
HISTFILE="$XDG_DATA_HOME/zsh/history"
setopt HIST_FCNTL_LOCK HIST_IGNORE_DUPS HIST_IGNORE_SPACE SHARE_HISTORY
unsetopt APPEND_HISTORY EXTENDED_HISTORY HIST_EXPIRE_DUPS_FIRST \
  HIST_FIND_NO_DUPS HIST_IGNORE_ALL_DUPS HIST_SAVE_NO_DUPS

[[ -r "$_brew_prefix/share/zsh-autosuggestions/zsh-autosuggestions.zsh" ]] &&
  source "$_brew_prefix/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
ZSH_AUTOSUGGEST_STRATEGY=(history)

[[ -r "$_omz_plugins/git/git.plugin.zsh" ]] && source "$_omz_plugins/git/git.plugin.zsh"
[[ -r "$_omz_plugins/docker/docker.plugin.zsh" ]] && source "$_omz_plugins/docker/docker.plugin.zsh"

[[ -t 0 || -t 1 ]] && (( $+commands[fzf] )) && source <(fzf --zsh)
export FZF_DEFAULT_OPTS="--style=full"
(( $+commands[zoxide] )) && eval "$(zoxide init zsh)"
(( $+commands[direnv] )) && eval "$(direnv hook zsh)"

if [[ -t 0 || -t 1 ]]; then
  [[ -r "$_brew_prefix/share/powerlevel10k/powerlevel10k.zsh-theme" ]] &&
    source "$_brew_prefix/share/powerlevel10k/powerlevel10k.zsh-theme"
  [[ -r "$ZDOTDIR/.p10k.zsh" ]] && source "$ZDOTDIR/.p10k.zsh"
fi

alias bruno-media-open='$HOME/darwin-config/scripts/open-team-media-bruno.sh'
alias bruno-media-sync='$HOME/darwin-config/scripts/sync-team-media-bruno.py'
alias gotestfiles='go test -coverprofile=/tmp/coverage.out ./... && go tool cover -func=/tmp/coverage.out'
alias hunk-main='hunk diff main...HEAD'
alias hunk-unstaged='hunk diff'
alias l='ls -CF'
alias v=nvim

omz_history() {
  builtin fc -l "${@:-1}"
}

unalias -g ... .... ..... ...... 2>/dev/null
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ......='cd ../../../../..'
alias gs='git status'
alias gc='git commit'
alias glog='git log --oneline --graph'
alias ls='ls -G'
alias ll='ls -la'
alias la='ls -a'
alias crb='cargo run --features bevy/dynamic_linking'

rust-doc() {
  open "$(rustc --print sysroot)/share/doc/rust/html/std/index.html"
}

renew-token() {
  local token
  token="$(get-token -env "${1:-prod}" -output simple)" || return
  export TOKEN="$token" JWT="$token" RELEASE_JWT="$token"
}

[[ -r "$ZDOTDIR/.zshrc.local" ]] && source "$ZDOTDIR/.zshrc.local"

[[ -r "$_brew_prefix/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]] &&
  source "$_brew_prefix/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main)

unset _brew_prefix _mise _omz_plugins
