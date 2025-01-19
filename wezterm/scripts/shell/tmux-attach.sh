#!/bin/bash
 
# Check if there are any tmux sessions
if tmux has-session 2>/dev/null; then
    # If there are, attach to the latest session
    tmux attach-session -t "$(tmux ls | tail -n 1 | cut -d: -f1)" >/dev/null 2>&1
else
    # If no sessions exist, create a new one
    tmux new-session -s new-session >/dev/null 2>&1
fi
