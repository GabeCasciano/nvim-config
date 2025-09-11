
#!/bin/bash 
SESSION="WORK"
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
  tmux resize-pane -t "$SESSION":Obsidian.2 -y 20

  tmux send-keys -t "$SESSION":Obsidian.1 'tock -m -s -c -f %m-%d-%y -H 2 -W 3' C-m
  tmux send-keys -t "$SESSION":Obsidian.2 'weather' C-m

  tmux select-pane -t "$SESSION":Obsidian.0

	tmux new-window -t "$SESSION" -n Prog -c "$CWD"
	tmux send-keys -t "$SESSION":Prog 'nvim' C-m
  tmux split-window -v -t "$SESSION":Prog -c "$CWD"
  tmux resize-pane -t "$SESSION":Prog.1 -y 1
  tmux select-pane -t "$SESSION":Prog.0

  tmux new-window -t "$SESSION" -n Split -c "$CWD"
  tmux split-window -h -t "$SESSION":Split -c "$CWD"
fi

tmux select-window -t "$SESSION":Obsidian
tmux attach -t "$SESSION"

