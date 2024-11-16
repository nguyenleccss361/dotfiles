# Setup fzf
# ---------
if [[ ! "$PATH" == */home/finn/.fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}/home/finn/.fzf/bin"
fi

eval "$(fzf --bash)"
