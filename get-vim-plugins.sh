find ~/.vim/bundle -maxdepth 1 | xargs -n 1 -I{} sh -c '(cd {} && git remote -v)' | awk '/\(fetch\)/ { print $2 }' > vim_plugins.txt
