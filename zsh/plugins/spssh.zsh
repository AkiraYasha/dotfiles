# vim: ft=zsh

_spssh() {
    if hash knife 2>/dev/null; then
        if [[ ! -f ~/.spssh_comp ]]; then
            knife node list > ~/.spssh_comp
        fi
        compadd $(<~/.spssh_comp)
    fi
}

compdef _spssh spssh
