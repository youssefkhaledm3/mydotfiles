# ==========================================
# 1. HISTORY SETTINGS (Required for autosuggestions)
# ==========================================
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt SHARE_HISTORY          # Share history across all open terminals
setopt HIST_IGNORE_ALL_DUPS   # Don't record duplicate entries
setopt HIST_IGNORE_SPACE      # Don't record commands starting with a space

# ==========================================
# 2. ENHANCED TAB COMPLETION
# ==========================================
# Include extra completions path
fpath=(/usr/share/zsh/site-functions $fpath)

# Initialize completion system
autoload -Uz compinit && compinit

# Tab completion options
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'  # Case-insensitive tab completion
zstyle ':completion:*' menu select                          # Menu-style selection list when tapping TAB
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"     # Colorize completions matching ls colors

# Arrow key navigation in TAB completion menu
zmodload zsh/complist
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history

# ==========================================
# 3. HISTORY AUTOSUGGESTIONS (Ghost Text)
# ==========================================
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

# Color of the ghost suggestion text (Tokyo Night gray/comment color)
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=#565f89'

# Fetch suggestions from history first, then completion fallback
ZSH_AUTOSUGGEST_STRATEGY=(history completion)

# Shortcut: Press Ctrl+Space to accept word-by-word or Ctrl+E for full line
bindkey '^ ' autosuggest-accept
# ==========================================
# HISTORY PREFIX / SUBSTRING SEARCH
# ==========================================
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

# Bind to Up / Down arrow keys
bindkey '^[[A' up-line-or-beginning-search
bindkey '^[[B' down-line-or-beginning-search

# Also bind for terminfo keycodes (ensures foot/xterm compatibility)
[[ -n "${key[Up]}"   ]] && bindkey "${key[Up]}"   up-line-or-beginning-search
[[ -n "${key[Down]}" ]] && bindkey "${key[Down]}" down-line-or-beginning-search
PROMPT='%1~ %%% '

eval "$(starship init zsh)"
eval "$(zoxide init zsh)"
eval "$(fnm env --use-on-cd --shell zsh)"
export PATH="$HOME/.local/bin:$PATH"
function y() {
	local tmp cwd; tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
	command yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ "$cwd" != "$PWD" ] && [ -d "$cwd" ] && builtin cd -- "$cwd" || builtin true
	command rm -f -- "$tmp"
}
source ~/Downloads/zsh/aliases.zsh
export EDITOR="nvim"
export SUDO_EDITOR="nvim"
export GPG_TTY=$(tty)
source <(fzf --zsh)
alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
compdef _git config=git
zstyle ':completion::complete:git-add:*:argument-rest' __git_ignore_line 'untracked'
