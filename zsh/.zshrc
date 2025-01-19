# figlet -w $(tput cols) -c -f ansi-shadow.flf "wezterm"
# Plugins
plugins=(
  git
  vscode
  npm
  zsh-autosuggestions
  zsh-syntax-highlighting
  web-search
)

# Custom web search engines
ZSH_WEB_SEARCH_ENGINES=(
  lo "http://localhost:"
)

# Add custom paths to PATH
export PATH="/bin:/usr/bin:/usr/local/bin:/sbin:$PATH"
# export PATH="/opt/homebrew/opt/node@14/bin:$PATH"
export PATH="/Applications/Postgres.app/Contents/Versions/latest/bin:$PATH"
# export PATH="~/.console-ninja/.bin:$PATH"

# Load NVM (via Homebrew)
export NVM_DIR="/opt/homebrew/opt/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Automatically load .nvmrc if present
autoload -U add-zsh-hook
load-nvmrc() {
  local node_version="$(nvm version)"
  local nvmrc_path="$(nvm_find_nvmrc)"

  if [ -n "$nvmrc_path" ]; then
    local nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")

    if [ "$nvmrc_node_version" = "N/A" ]; then
      nvm install
    elif [ "$nvmrc_node_version" != "$node_version" ]; then
      nvm use
    fi
  elif [ "$node_version" != "$(nvm version default)" ]; then
    echo "Reverting to nvm default version"
    nvm use default
  fi
}
add-zsh-hook chpwd load-nvmrc
load-nvmrc

# source /opt/homebrew/share/powerlevel10k/powerlevel10k.zsh-theme

source $(nix eval --raw nixpkgs#zsh-autosuggestions)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source $(nix eval --raw nixpkgs#zsh-syntax-highlighting)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

export CATPPUCCIN_FLAVOR="mocha" # Choose from latte, frappe, macchiato, or mocha

# history setup
HISTFILE=$HOME/.zhistory
SAVEHIST=1000
HISTSIZE=999
setopt share_history
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_verify

# completion using arrow keys (based on history)
bindkey '^[[A' history-search-backward
bindkey '^[[B' history-search-forward

# ---- Eza (better ls) -----
alias ls="eza --color=always --long --git --grid --no-filesize --icons=always --no-time --no-user --no-permissions"
alias lsa="eza -la --color=always --icons --all --grid"
alias ll="eza -lg --icons"
alias la="eza -lag --icons"
alias lt="eza -lTg --icons --git-ignore -I=node_modules | build"
alias lta="eza -lTag --icons --git-ignore"
alias ltg="eza -lTag --icons"

# ---- Zoxide (better cd) ----
eval "$(zoxide init zsh)"

alias cd="z"

# Starship
eval "$(starship init zsh)"
export STARSHIP_CONFIG=$HOME/.config/starship/starship.toml

# Aliases
alias cl="clear"
alias vim="nvim"

PATH=~/.console-ninja/.bin:$PATH

# ----- FZF -----
eval "$(fzf --zsh)"

# -- Use fd instead of fzf --

export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"

# Use fd (https://github.com/sharkdp/fd) for listing path candidates.
# - The first argument to the function ($1) is the base path to start traversal
# - See the source code (completion.{bash,zsh}) for the details.
_fzf_compgen_path() {
  fd --hidden --exclude .git . "$1"
}

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fd --type=d --hidden --exclude .git . "$1"
}

# source ~/fzf-git.sh/fzf-git.sh

show_file_or_dir_preview="if [ -d {} ]; then eza --tree --color=always {} | head -200; else bat -n --color=always --line-range :500 {}; fi"

export FZF_CTRL_T_OPTS="--preview '$show_file_or_dir_preview'"
export FZF_ALT_C_OPTS="--preview 'eza --tree --color=always {} | head -200'"

# Advanced customization of fzf options via _fzf_comprun function
# - The first argument to the function is the name of the command.
# - You should make sure to pass the rest of the arguments to fzf.
_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
    cd)           fzf --preview 'eza --tree --color=always {} | head -200' "$@" ;;
    export|unset) fzf --preview "eval 'echo ${}'"         "$@" ;;
    ssh)          fzf --preview 'dig {}'                   "$@" ;;
    *)            fzf --preview "$show_file_or_dir_preview" "$@" ;;
  esac
}
# ----- Setup fzf theme -----

export FZF_DEFAULT_OPTS=" \
--color=bg+:#363a4f,bg:#24273a,spinner:#f4dbd6,hl:#ed8796 \
--color=fg:#cad3f5,header:#ed8796,info:#c6a0f6,pointer:#f4dbd6 \
--color=marker:#b7bdf8,fg+:#cad3f5,prompt:#c6a0f6,hl+:#ed8796 \
--color=selected-bg:#494d64 \
--multi"

# ----- Bat (better cat) -----

# Theme set in .config/bat/config file

# ----- Custom paths ----
export CONFIG_DIR=$(pwd)/.config

# ------ AWS --------
export AWS_PROFILE=default

