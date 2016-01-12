# vim: ft=zsh

_rbenv_installed() {
    type rbenv &> /dev/null
}

if _rbenv_installed; then
    eval "$(rbenv init -)"
fi
