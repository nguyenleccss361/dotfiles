# Setup fzf
# ---------
if [[ ! "$PATH" == */home/nguyenlh6/.fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}/home/nguyenlh6/.fzf/bin"
fi

eval "$(fzf --bash)"
