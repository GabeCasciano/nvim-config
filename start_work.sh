
#!/bin/bash 
SESSION="WorkDash"
ROOT="/home/gabe/"
CWD=$(pwd)

# Make sure Mqtt is ready 

# Idividual components should check if their required component are ready, set
# them up if necessary and throw an erro if it cant

# Create a new session
if ! tmux has-session -t "$SESSION" 2>/dev/null; then
	tmux new-session -d -s "$SESSION" -n Obsidian -c "$ROOT"
  tmux send-keys -t "$SESSION":Obsidian 'work' C-m
  tmux send-keys -t "$SESSION":Obsidian ':Obsidian today' C-m
  tmux split-window -h -t "$SESSION":Obsidian 
  tmux split-window -v -t "$SESSION":Obsidian.1 
  tmux send-keys -t "$SESSION":Obsidian.2 'tmux resize-pane -t "$SESSION":Obsidian.1 -y 20 && clear && weather' C-m
  tmux send-keys -t "$SESSION":Obsidian.1 'wtfutil' C-m
  tmux select-pane -t "$SESSION":Obsidian.0

  tmux new-window -t "$SESSION" -n Monitor -c "$CMD"
  tmux split-window -h -t "$SESSION":Monitor 
  tmux send-keys -t "$SESSION":Monitor.0 'btop' C-m
  tmux send-keys -t "$SESSION":Monitor.1 'y' C-m
fi

tmux select-window -t "$SESSION":Obsidian
tmux attach -t "$SESSION"

