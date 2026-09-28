if [[ -x /opt/homebrew/bin/brew ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Reassert managed paths after macOS path_helper rewrites login-shell PATH.
typeset -U path PATH
path=(
  "$HOME/.opencode/bin"
  "$HOME/go/bin"
  "$HOME/.local/bin"
  "$PNPM_HOME"
  "$XDG_DATA_HOME/mise/shims"
  /opt/homebrew/opt/ffmpeg@6/bin
  /opt/homebrew/opt/llvm/bin
  /opt/homebrew/opt/postgresql@15/bin
  /opt/homebrew/opt/unzip/bin
  $path
)
