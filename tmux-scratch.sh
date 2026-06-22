#!/bin/sh
# Cycle through tmux scratch popup sessions
# Usage: tmux-scratch.sh [1|-1]  (1 = forward/Alt-J, -1 = backward/Alt-K)
# Deploy to: ~/tmux-scratch.sh  (chmod +x)
N=3
DIRECTION=${1:-1}

idx=$(cat /tmp/tmux_scratch_idx 2>/dev/null || echo 0)

if [ "$DIRECTION" = "1" ]; then
  idx=$(( (idx % N) + 1 ))
else
  idx=$(( ((idx - 2 + N) % N) + 1 ))
fi

echo $idx > /tmp/tmux_scratch_idx

tmux display-popup -E \
  -x 0 -y S -w 100% -h 50% \
  "tmux new-session -A -s scratch-$idx"
