# vim: ft=zsh

# get the name of the branch we are on
function git_current_branch() {
  ref=$(command git symbolic-ref HEAD 2> /dev/null) || \
  ref=$(command git rev-parse --short HEAD 2> /dev/null) || return
  echo "${ref#refs/heads/}"
}

function git_remote_prompt() {
  prompt_info=$(git_current_branch) || return
  echo "%F{3}[%F{2}$prompt_info%f$(git_remote_status)%F{3}]%f"
}

# Formats prompt string for current git commit short SHA
function git_prompt_short_sha() {
  SHA=$(command git rev-parse --short HEAD 2> /dev/null) && echo "$SHA"
}

# between the local and remote branches
function git_remote_status() {
  remote=${$(git rev-parse --verify ${hook_com[branch]}@{upstream} --symbolic-full-name 2>/dev/null)/refs\/remotes\/}
  if [[ -n ${remote} ]] ; then
    ahead=$(git rev-list $remote..HEAD 2>/dev/null | wc -l)
    behind=$(git rev-list HEAD..$remote 2>/dev/null | wc -l)

    if [ $ahead -eq 0 ] && [ $behind -eq 0 ]
    then
      status_str="%F{2}="
    else
      status_str=""

      if [ $ahead -gt 0 ]
      then
        status_str="$status_str%F{191}+${ahead// /}"
      fi

      if [ $ahead -gt 0 ] && [ $behind -gt 0 ]
      then
        status_str="$status_str/"
      fi

      if [ $behind -gt 0 ]
      then
        status_str="$status_str%F{1}-${behind// /}"
      fi
    fi

    echo $status_str
  fi
}
