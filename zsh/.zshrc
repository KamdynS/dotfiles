# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.config/zsh/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Path to your Oh My Zsh installation.
export ZSH="$ZDOTDIR/ohmyzsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time Oh My Zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"

plugins=(git docker zsh-syntax-highlighting zsh-autocomplete)

source $ZSH/oh-my-zsh.sh
# opencode
export PATH=/Users/kamdynshaeffer/.opencode/bin:$PATH

# Work stuff
export VAULT_ADDR=https://vault.infra.subsplash.io
export PATH=$PATH:/usr/local/go/bin 
export PATH=$PATH:$HOME/go/bin

# To customize prompt, run `p10k configure` or edit ~/.config/zsh/.p10k.zsh.
[[ ! -f ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh
export PATH="/opt/homebrew/opt/postgresql@15/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"

# fzf
source <(fzf --zsh)
export FZF_DEFAULT_OPTS="--style full --border --padding 1,2 --border-label ' Demo ' --input-label ' Input ' --header-label ' File Type ' --preview 'fzf-preview.sh {}'  fi' --bind 'focus:transform-preview-label:[[ -n {} ]] && printf \" Previewing [%s] \" {}' --bind 'focus:+transform-header:file --brief {} || echo \"No file selected\"' --bind 'ctrl-r:change-list-label( Reloading the list )+reload(sleep 2; git ls-files)' --color 'bg:#fbf1c7,bg+:#ebdbb2,fg:#3c3836,fg+:#3c3836,hl:#b57614,hl+:#af3a03,info:#076678,marker:#79740e,prompt:#b57614,spinner:#8f3f71,pointer:#af3a03,header:#076678,border:#a89984,label:#7c6f64,preview-border:#a89984,preview-label:#7c6f64,list-border:#98971a,list-label:#79740e,input-border:#cc241d,input-label:#9d0006,header-border:#458588,header-label:#076678'"xport FZF_DEFAULT_OPTS="--style=full --preview 'fzf-preview.sh {}'"
