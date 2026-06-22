# AGENTS.md

Notes for AI agents working in this repo.

## Deploy instructions

Files in this repo that require manual placement in the home directory:

### tmux-scratch.sh

Destination: `~/tmux-scratch.sh`

```sh
cp tmux-scratch.sh ~/tmux-scratch.sh
chmod +x ~/tmux-scratch.sh
```

Cycles through 3 persistent tmux popup sessions as lower-half overlays.
Bound to Alt-J (forward) and Alt-K (backward) in `.tmux.conf.local`.
Dismiss each popup with `Ctrl-a d` (detach — session stays alive).
