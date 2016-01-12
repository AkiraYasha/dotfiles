# vim: ft=zsh

_pyenv_installed() {
    type pyenv &> /dev/null
}

if _pyenv_installed; then
    eval "$(pyenv init -)"
fi
