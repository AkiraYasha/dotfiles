# vim: ft=zsh

unsetopt correct_all
unsetopt correct
zstyle ':completion:*' menu select

#if [[ ! $(brew --prefix zsh-completions 2>/dev/null) ]]; then
#    echo "You should install zsh-completions from homebrew!"
#    echo ""
#fi

fpath=($HOME/.zsh/completions /usr/local/share/zsh-completions $fpath)
rm -f ~/.zcompdump; compinit
