@echo off

doskey g=git $*

doskey ga=git add .

doskey gb=git branch

doskey gc=git checkout $*

doskey gcd=git checkout develop

doskey gd=git diff

doskey gi=git init

doskey gm=git merge $*

doskey glog=git log --oneline --decorate --color --graph

doskey ggpull=git pull

doskey ggpush=git push

doskey gs=git status