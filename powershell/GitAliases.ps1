# Git command shortcuts for interactive PowerShell (dot-source from profile).
# Removes built-in aliases that collide with these names (same idea as POSIX-style shims).

$__gafwCollisions = @(
  'g', 'gc', 'gi', 'gl', 'gm', 'gp', 'gs', 'gcb'
)
foreach ($__n in $__gafwCollisions) {
  if (Get-Alias -Name $__n -ErrorAction SilentlyContinue) {
    Remove-Item -Path "Alias:\$__n" -Force -ErrorAction SilentlyContinue
  }
}

function g { git @args }
function ga { git add @args }
function gaa { git add --all @args }
function gapa { git add --patch @args }
function gb { git branch @args }
function gba { git branch -a @args }
function gbd { git branch -d @args }
function gbl { git blame -b -w @args }
function gbnm { git branch --no-merged @args }
function gbr { git branch --remote @args }
function gbs { git bisect @args }
function gbsb { git bisect bad @args }
function gbsg { git bisect good @args }
function gbsr { git bisect reset @args }
function gbss { git bisect start @args }
function gc { git commit -v @args }
${function:gc!} = { git commit -v --amend @args }
function gca { git commit -v -a @args }
${function:gcan!} = { git commit -v -a --no-edit --amend @args }
${function:gcans!} = { git commit -v -a -s --no-edit --amend @args }
function gcam { git commit -a -m @args }
function gcsm { git commit -s -m @args }
function gcb { git checkout -b @args }
function gcf { git config --list @args }
function gcl { git clone --recursive @args }
function gclean { git clean -fd @args }
function gpristine {
  git reset --hard
  if ($LASTEXITCODE -ne 0) { return }
  git clean -dfx
}
function gcm { git checkout master @args }
function gcd { git checkout develop @args }
function gcmsg { git commit -m @args }
function gco { git checkout @args }
function gcount { git shortlog -sn @args }
function gd { git diff @args }
function gi { git init @args }
function gm { git merge @args }
function glog { git log --oneline --decorate --color --graph @args }
function ggpull { git pull @args }
function gl { git pull @args }
function ggpush { git push @args }
function gp { git push @args }
function gs { git status @args }
function gst { git status @args }

function gss { git status -s @args }
function gf { git fetch @args }
function gfo { git fetch origin @args }
function gdc { git diff --cached @args }
function gup { git pull --rebase @args }
function gsh { git show @args }
function grb { git rebase @args }
function grbi { git rebase -i @args }
function grba { git rebase --abort @args }
function grbc { git rebase --continue @args }
function gsta { git stash @args }
function gstp { git stash pop @args }
function gstaa { git stash apply @args }
function gsw { git switch @args }
function gswc { git switch -c @args }
function grt { git restore @args }
function grts { git restore --staged @args }
function gcp { git cherry-pick @args }
function gcpa { git cherry-pick --abort @args }
function gcpc { git cherry-pick --continue @args }
