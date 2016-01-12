# vim: ft=zsh

_nodenv_installed() {
    type nodenv &> /dev/null
}

if _nodenv_installed; then
    eval "$(nodenv init -)"
fi
