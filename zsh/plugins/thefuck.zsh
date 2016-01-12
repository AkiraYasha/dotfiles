# vim: ft=zsh

_thefuck_installed() {
    type thefuck &> /dev/null
}

if _thefuck_installed; then
    eval "$(thefuck --alias)" 
fi
