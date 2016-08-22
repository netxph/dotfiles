alias.commit-rnd=!sh -c "git commit -m '$(curl -s http://whatthecommit.com/index.txt)'"
alias.clean-branches=!git branch | grep -v master | xargs git branch -D
