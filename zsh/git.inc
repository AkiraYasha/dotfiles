function git_remote_prompt() {
  prompt_info=$(git_prompt_info) || return
  echo "%F{blue}[%F{cyan}$prompt_info%f$(git_remote_status)%F{blue}]%f"
}

# get the name of the branch we are on
function git_prompt_info() {
  ref=$(command git symbolic-ref HEAD 2> /dev/null) || \
  ref=$(command git rev-parse --short HEAD 2> /dev/null) || return
  echo "${ref#refs/heads/}"
}

# Checks if there are commits ahead from remote
function git_prompt_ahead() {
  if $(echo "$(command git log origin/$(current_branch)..HEAD 2> /dev/null)" | grep '^commit' &> /dev/null); then
    echo "$ZSH_THEME_GIT_PROMPT_AHEAD"
  fi
}

# Formats prompt string for current git commit short SHA
function git_prompt_short_sha() {
  SHA=$(command git rev-parse --short HEAD 2> /dev/null) && echo "$SHA"
}

# Formats prompt string for current git commit long SHA
function git_prompt_long_sha() {
  SHA=$(command git rev-parse HEAD 2> /dev/null) && echo "$SHA"
}

# Get the status of the working tree
git_prompt_status() {
  INDEX=$(command git status --porcelain -b 2> /dev/null)
  STATUS=""
  if $(echo "$INDEX" | grep -E '^\?\? ' &> /dev/null); then
    # UNTRACKED
    STATUS="%F{red}…$STATUS"
  fi
  if $(echo "$INDEX" | grep '^A  ' &> /dev/null); then
    # ADDED
    STATUS="%F{cyan}●$STATUS"
  elif $(echo "$INDEX" | grep '^M  ' &> /dev/null); then
    # ADDED
    STATUS="%F{cyan}●$STATUS"
  fi
  if $(echo "$INDEX" | grep '^ M ' &> /dev/null); then
    # MODIFIED
    STATUS="%F{green}✚$STATUS"
  elif $(echo "$INDEX" | grep '^AM ' &> /dev/null); then
    # MODIFIED
    STATUS="%F{green}✚$STATUS"
  elif $(echo "$INDEX" | grep '^ T ' &> /dev/null); then
    # MODIFIED
    STATUS="%F{green}✚$STATUS"
  fi
  if $(echo "$INDEX" | grep '^R  ' &> /dev/null); then
    # RENAMED
  fi
  if $(echo "$INDEX" | grep '^ D ' &> /dev/null); then
    # DELETED
  elif $(echo "$INDEX" | grep '^D  ' &> /dev/null); then
    # DELETED
  elif $(echo "$INDEX" | grep '^AD ' &> /dev/null); then
    # DELETED
  fi
  if $(command git rev-parse --verify refs/stash >/dev/null 2>&1); then
    # STASHED
  fi
  if $(echo "$INDEX" | grep '^UU ' &> /dev/null); then
    # UNMERGED
    STATUS="%F{red}✖$STATUS"
  fi
  if $(echo "$INDEX" | grep '^## .*ahead' &> /dev/null); then
    # AHEAD
  fi
  if $(echo "$INDEX" | grep '^## .*behind' &> /dev/null); then
    # BEHIND
  fi
  if $(echo "$INDEX" | grep '^## .*diverged' &> /dev/null); then
    # DIVERGED
  fi
  if $(echo "$INDEX" | grep -v '^## ' &> /dev/null); then
  else
    # CLEAN
    STATUS="%F{green}✔$STATUS"
  fi
  echo $STATUS
}

#compare the provided version of git to the version installed and on path
#prints 1 if input version <= installed version
#prints -1 otherwise
function git_compare_version() {
  local INPUT_GIT_VERSION=$1;
  local INSTALLED_GIT_VERSION
  INPUT_GIT_VERSION=(${(s/./)INPUT_GIT_VERSION});
  INSTALLED_GIT_VERSION=($(command git --version 2>/dev/null));
  INSTALLED_GIT_VERSION=(${(s/./)INSTALLED_GIT_VERSION[3]});

  for i in {1..3}; do
    if [[ $INSTALLED_GIT_VERSION[$i] -lt $INPUT_GIT_VERSION[$i] ]]; then
      echo -1
      return 0
    fi
  done
  echo 1
}


# between the local and remote branches
function git_remote_status() {
  remote=${$(git rev-parse --verify ${hook_com[branch]}@{upstream} --symbolic-full-name 2>/dev/null)/refs\/remotes\/}
  if [[ -n ${remote} ]] ; then
    ahead=$(git rev-list $remote..HEAD 2>/dev/null | wc -l)
    behind=$(git rev-list HEAD..$remote 2>/dev/null | wc -l)

    if [ $ahead -eq 0 ] && [ $behind -eq 0 ]
    then
      status_str='='
    else
      status_str=''

      if [ $ahead -gt 0 ]
      then
        status_str="$status_str%F{green}+${ahead// /}"
      fi

      if [ $ahead -gt 0 ] && [ $behind -gt 0 ]
      then
        status_str="$status_str/"
      fi

      if [ $behind -gt 0 ]
      then
        status_str="$status_str%F{red}-${behind// /}"
      fi
    fi

    echo $status_str
  fi
}

#this is unlikely to change so make it all statically assigned
POST_1_7_2_GIT=$(git_compare_version "1.7.2")
#clean up the namespace slightly by removing the checker function
unset -f git_compare_version