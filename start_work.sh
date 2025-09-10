
#!/bin/bash 
set -euo pipefail 

SESSION="WORK"
ROOT="/home/gabe/"
CWD=$(pwd)

DLOGGER="$ROOT/Datalogger"

# Make sure Mqtt is ready 

# Idividual components should check if their required component are ready, set
# them up if necessary and throw an erro if it cant

# Create a new session
if ! tmux has-session -t "$SESSION" 2>/dev/null; then
	tmux new-session -d -s "$SESSION" -n Obsidian -c "$ROOT"
  tmux send-keys -t "$SESSION":Obsidian 'work' C-m

	tmux new-window -t "$SESSION" -n Prog -c "$CWD"
	tmux send-keys -t "$SESSION":Prog 'nvim' C-m
  tmux split-window -v -t "$SESSION":Prog -c "$CWD" -p 25
fi

tmux select-window -t "$SESSION":Obsidian
tmux attach -t "$SESSION"


