
#!/bin/bash 
SESSION="PROG"
ROOT="/home/gabe/"
CWD=$(pwd)


if ! tmux has-session -t "$SESSION" 2>/dev/null; then
  tmux new-session -d -s "$SESSION" -n Prog -c "$CWD"
  tmux split-window -v -t "$SESSION":Prog -c "$CWD"
  tmux select-pane -t "$SESSION":Prog.0
	tmux send-keys -t "$SESSION":Prog 'nvim' C-m
  tmux send-keys -t "$SESSION":Prog.1 'tmux resize-pane -t "PROG":Prog.1 -y 8 && clear' C-m

  tmux new-window -t "$SESSION" -n Split -c "$CWD"
  tmux split-window -h -t "$SESSION":Split -c "$CWD"

  tmux new-window -t "$SESSION" -n Monitor -c "$CMD"
  tmux send-keys -t "$SESSION":Monitor.0 'btop' C-m
  tmux split-window -h -t "$SESSION":Monitor.0 -c "$CWD"
  tmux send-keys -t "$SESSION":Monitor.1 'yazi' C-m

  tmux new-window -t "$SESSION" -n Obsidian -c "$CWD"
  tmux send-keys -t "$SESSION":Obsidian 'work' C-m
  tmux send-keys -t "$SESSION":Obsidian ':Obsidian today' C-m

  tmux resize-pane -t "$SESSION":Prog.1 -y 8
  tmux resize-pane -t "$SESSION":Prog.0 -y 60


fi

tmux select-window -t "$SESSION":Prog
tmux attach -t "$SESSION"

