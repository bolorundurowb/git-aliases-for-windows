@echo off

doskey g=git $*

doskey ga=git add $*

doskey gaa=git add --all

doskey gapa=git add --patch

doskey gb=git branch $*

doskey gba=git branch -a

doskey gbd=git branch -d $*

doskey gbl=git blame -b -w

doskey gbnm=git branch --no-merged $*

doskey gbr=git branch --remote $*

doskey gbs=git bisect

doskey gbsb=git bisect bad

doskey gbsg=git bisect good

doskey gbsr=git bisect reset

doskey gbss=git bisect start

doskey gc=git commit -v

doskey gc!=git commit -v --amend

doskey gca=git commit -v -a

doskey gcan!=git commit -v -a --no-edit --amend

doskey gcans!=git commit -v -a -s --no-edit --amend

doskey gcam=git commit -a -m $*

doskey gcsm=git commit -s -m $*

doskey gcb=git checkout -b $*

doskey gcf=git config --list

doskey gcl=git clone --recursive $*

doskey gclean=git clean -fd

doskey gpristine=git reset --hard $T git clean -dfx

doskey gcm=git checkout master

doskey gcd=git checkout develop

doskey gcmsg=git commit -m $*

doskey gco=git checkout $*

doskey gcount=git shortlog -sn

doskey gd=git diff $*

doskey gi=git init

doskey gm=git merge $*

doskey glog=git log --oneline --decorate --color --graph

doskey ggpull=git pull

doskey gl=git pull

doskey ggpush=git push

doskey gp=git push

doskey gs=git status

doskey gst=git status
