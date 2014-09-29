# Load grml
source ~/.zshrc.grml

# Load plugins
source ~/.zsh/git.inc
source ~/.zsh/ctso.inc

# Load zsh-syntax-highlighting
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Disable autocomplete
unsetopt correct_all
unsetopt correct

# Completions
setopt menu_complete
fpath=(/usr/local/share/zsh-completions $fpath)
rm -f ~/.zcompdump; compinit

# Functions
function removeFromPath {
    export PATH=$(echo $PATH | sed -E -e "s;:$1;;" -e "s;$1:?;;")
}

function jdk {
    if [ $# -ne 0 ]; then
        DESIRED_JAVA_HOME=`/usr/libexec/java_home -v $@`
        if [ $? -eq 0 ]; then
            export JAVA_HOME="${DESIRED_JAVA_HOME}"
        fi
    fi
}

# Prompt
prompt off
setopt PROMPT_SUBST
PS1='%B%F{red}%(?..%? )%b %B%40<..<%~%<< %b$(git_remote_prompt) %F{cyan}$(git_prompt_short_sha)%f %(!.#.») '
RPROMPT='$(git_prompt_status)'

# Aliases
function mountAndroid { hdiutil attach ~/android.dmg.sparseimage -mountpoint /Volumes/android; }
alias ll='ls -l'

alias ping='grc ping'
alias traceroute='grc traceroute'
alias netstat='grc netstat'
alias diff='grc diff'
alias dig='grc dig'
alias ps='grc ps'
alias chef='cd ~/src/chef-gce'

alias grunt='nocorrect grunt'
alias logcat='nocorrect logcat'
alias gradle='nocorrect gradle'

# Add ssh keys
ssh-add -K ~/.ssh/vagrant > /dev/null 2>&1
ssh-add -K ~/.ssh/ops.pem > /dev/null 2>&1
ssh-add -K ~/.ssh/ops-us-west1.pem > /dev/null 2>&1

# pyenv
eval "$(pyenv init -)"

# rbenv
eval "$(rbenv init -)"

# nodenv
eval "$(nodenv init -)"

# Use local bins
export PATH=~/bin:$PATH
export PATH=bin:$PATH

jdk 1.8
