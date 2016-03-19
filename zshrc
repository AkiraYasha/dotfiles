# Reset Path
# Hack to prevent new instances of zsh from adding to $PATH, we should always handle PATH from a default state
export PATH=/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin

# Allow editing of command in $EDITOR with ctrl+x ctrl+e
autoload -U edit-command-line
zle -N edit-command-line
bindkey '\C-x\C-e' edit-command-line

# Show a fortune
echo ""
fortune
echo ""

# Load grml
source ~/.zshrc.grml

# Load plugins
source ~/.zsh/functions.zsh
source ~/.zsh/completions/init.zsh

source ~/.zsh/plugins/vim_mode.zsh
source ~/.zsh/plugins/aliases.zsh
source ~/.zsh/plugins/git.zsh
source ~/.zsh/plugins/grc.zsh
source ~/.zsh/plugins/rbenv.zsh
source ~/.zsh/plugins/pyenv.zsh
source ~/.zsh/plugins/nodenv.zsh
source ~/.zsh/plugins/gitignore.zsh
source ~/.zsh/plugins/json.zsh
source ~/.zsh/plugins/thefuck.zsh
source ~/.zsh/plugins/spssh.zsh

source ~/.zsh/plugins/emoji/emoji.zsh

# syntax highlighting
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/.zsh/syntax-colors.zsh

# Load user specific stuff and things
source ~/.${USER}.zsh

user_prompt() {
  local symbols
  symbols=()
  [[ $UID -eq 0 ]] && symbols+="%B%F{3} ⚡"
  [[ $UID -ne 0 ]] && symbols+="%B%F{5} Λ"

  echo $symbols
}

# Prompt
prompt off
setopt PROMPT_SUBST
PS1='$(user_prompt)%B%F{5} %B%F{3}|%B%F{1} %(?..%?)%b %F{4}%40<..<%~%<< $(git_remote_prompt) %F{10}$(git_prompt_short_sha)%f %(!.#.$) '

# Use local bins
export PATH=~/bin:$PATH
export PATH=bin:$PATH

jdk 1.8
