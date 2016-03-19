# vim: ft=zsh

function zle-keymap-select() {
    zle reset-prompt
    zle -R
}

MODE_INDICATOR="  $emoji[taco]  "
function vim_mode_prompt_info() {
    echo "${${KEYMAP/vicmd/$MODE_INDICATOR}/(main|viins)/}"
}

#if [[ $VIM_MODE ]]; then
#    zle -N zle-keymap-select
#    bindkey -v
#    bindkey -M vicmd 'v' edit-command-line
#    RPROMPT='$(vim_mode_prompt_info)'
#fi
