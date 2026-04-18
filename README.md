# git-aliases-for-windows

DOSKEY shortcuts for **Command Prompt** (`cmd.exe`) and matching **functions** for **PowerShell**, inspired by common git plugin aliases. Aliases are **not** `git config alias.*` entries; they are shell-level commands (for example `gs` → `git status`).

## Requirements

- Git for Windows (or another install where `git` is on your `PATH`).
- For aliases such as `gsw`, `grt`, and `grts`, use a Git version that supports **switch** and **restore** (Git 2.23+).

## Install (recommended)

You can clone this repository **anywhere**. Files are copied under your profile data so the path does not depend on the clone location.

1. Clone the repository.
2. Open PowerShell in the repo root and run:

   ```powershell
   Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass -Force
   .\scripts\install.ps1
   ```

   You can also run `scripts\install.ps1` by full path from any directory; it locates `cmd\` and `powershell\` from the repo layout.

3. Open a **new** Command Prompt or PowerShell tab (Windows Terminal counts).

`scripts\install.ps1` does the following:

- Copies `cmd\aliases.cmd` and `powershell\GitAliases.ps1` to  
  `%LOCALAPPDATA%\git-aliases-for-windows\`
- Sets `HKCU\Software\Microsoft\Command Processor\AutoRun` to that `aliases.cmd` using **REG_EXPAND_SZ** (so `%LOCALAPPDATA%` expands when `cmd` starts).
- Appends a small marked block to your **current host** PowerShell profile (`$PROFILE`) that dot-sources `GitAliases.ps1` from the same install folder.

**Windows 11 / Windows Terminal:** the default profile is often PowerShell. Without the profile block, only CMD would load aliases; use `scripts\install.ps1` so both shells stay in sync.

**Command Prompt:** DOSKEY macros are meant for normal interactive typing at the `cmd` prompt. Some non-interactive `cmd /c` uses do not expand macros the same way; day-to-day use in Terminal or `cmd.exe` is unaffected.

## Uninstall

From the repo root:

```powershell
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass -Force
.\scripts\uninstall.ps1
```

To also remove the copied files under `%LOCALAPPDATA%\git-aliases-for-windows\`:

```powershell
.\scripts\uninstall.ps1 -RemoveFiles
```

## Troubleshooting

- **`cmd /D`:** skips `AutoRun` for that session.
- **PowerShell:** built-in aliases such as `g` and `gc` are removed when `GitAliases.ps1` loads so the git shortcuts can take those names.
- **Child `cmd` processes:** a global `AutoRun` runs whenever `cmd` starts (including some scripted uses). `aliases.cmd` stays silent to avoid breaking `for /f` and similar patterns.
- **Execution policy:** use `-Scope Process` with `Bypass` only for the session where you run `scripts\install.ps1` / `scripts\uninstall.ps1` if your machine restricts scripts.

## Alias list

Every name should exist in **both** `cmd\aliases.cmd` and `powershell\GitAliases.ps1` when you contribute.

| Alias | Command |
|-------|---------|
| `g` | `git` |
| `ga` | `git add` |
| `gaa` | `git add --all` |
| `gapa` | `git add --patch` |
| `gb` | `git branch` |
| `gba` | `git branch -a` |
| `gbd` | `git branch -d` |
| `gbl` | `git blame -b -w` |
| `gbnm` | `git branch --no-merged` |
| `gbr` | `git branch --remote` |
| `gbs` | `git bisect` |
| `gbsb` | `git bisect bad` |
| `gbsg` | `git bisect good` |
| `gbsr` | `git bisect reset` |
| `gbss` | `git bisect start` |
| `gc` | `git commit -v` |
| `gc!` | `git commit -v --amend` |
| `gca` | `git commit -v -a` |
| `gcan!` | `git commit -v -a --no-edit --amend` |
| `gcans!` | `git commit -v -a -s --no-edit --amend` |
| `gcam` | `git commit -a -m` |
| `gcsm` | `git commit -s -m` |
| `gcb` | `git checkout -b` |
| `gcf` | `git config --list` |
| `gcl` | `git clone --recursive` |
| `gclean` | `git clean -fd` |
| `gpristine` | `git reset --hard` then `git clean -dfx` |
| `gcm` | `git checkout master` |
| `gcd` | `git checkout develop` |
| `gcmsg` | `git commit -m` |
| `gco` | `git checkout` |
| `gcount` | `git shortlog -sn` |
| `gd` | `git diff` |
| `gi` | `git init` |
| `gm` | `git merge` |
| `glog` | `git log --oneline --decorate --color --graph` |
| `ggpull` | `git pull` |
| `gl` | `git pull` |
| `ggpush` | `git push` |
| `gp` | `git push` |
| `gs` | `git status` |
| `gst` | `git status` |
| `gss` | `git status -s` |
| `gf` | `git fetch` |
| `gfo` | `git fetch origin` |
| `gdc` | `git diff --cached` |
| `gup` | `git pull --rebase` |
| `gsh` | `git show` |
| `grb` | `git rebase` |
| `grbi` | `git rebase -i` |
| `grba` | `git rebase --abort` |
| `grbc` | `git rebase --continue` |
| `gsta` | `git stash` |
| `gstp` | `git stash pop` |
| `gstaa` | `git stash apply` |
| `gsw` | `git switch` |
| `gswc` | `git switch -c` |
| `grt` | `git restore` |
| `grts` | `git restore --staged` |
| `gcp` | `git cherry-pick` |
| `gcpa` | `git cherry-pick --abort` |
| `gcpc` | `git cherry-pick --continue` |

## How to contribute

1. Clone this repository.
2. Add or update aliases in **both** `cmd\aliases.cmd` (`doskey`) and `powershell\GitAliases.ps1` (`function`), and extend the table above if you add names.
3. Avoid breaking existing names without a good reason (downstream users type them from muscle memory).
4. Open a pull request.
