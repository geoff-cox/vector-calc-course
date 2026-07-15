# Python, VENV, & PreTeXt Guide

This document assumes Linux/WSL commands.

## I. Get Ubuntu 24.04 WSL

Ubuntu 24.04 LTS defaults to Python 3.12, while Ubuntu 22.04 LTS defaults to Python 3.10 and officially lists Python 3.10/3.11 as available Python 3 versions.

### 1. Install Ubuntu 24.04

From **PowerShell**, first see what distro you currently have:

```powershell
wsl -l -v
```

Note the distroNAME for below.

Back up the current distro before making changes. Microsoft recommends `wsl --export` / `wsl --import` for backing up or moving WSL distributions.

```powershell
mkdir $env:USERPROFILE\wsl-backups

wsl --export Ubuntu \
$env:USERPROFILE\wsl-backups\<distroNAME>-backup.tar
```

List the available distros:

```powershell
wsl --list --online
```

Install Ubuntu 24.04 if listed:

```powershell
wsl --install -d Ubuntu-24.04
```

---

### 2. After launching Ubuntu 24.04

Inside the new Ubuntu terminal:

```bash
sudo apt update
sudo apt upgrade
```

Install common development tools:

```bash
sudo apt install \
  build-essential \
  pkg-config \
  git \
  curl \
  unzip \
  python3 \
  python3-venv \
  python3-dev \
  python3-pip \
  libcairo2-dev \
  librsvg2-bin \
  libxml2-dev \
  libxslt1-dev \
  jing
```

Check Python:

```bash
python3 --version
which python3
```

You should see Python 3.12 on Ubuntu 24.04.

---

### 3. Do not delete the old WSL distro immediately

Keep both for a while. WSL supports multiple installed Linux distributions side-by-side. ([Microsoft Learn][4])

You can enter a specific one from PowerShell with:

```powershell
wsl -d Ubuntu-24.04
```

When the new one is fully working and backed up, you can remove the old one with:

```powershell
wsl --unregister Ubuntu
```

Be careful: `--unregister` deletes that distro’s Linux filesystem.

---

## II. Python/`venv` Cleanup & Fresh Start

### 0. Clean up unused dependencies:

```bash
sudo apt autoremove --purge
sudo apt clean
```

---

### 1. Check your Ubuntu version and current Python

```bash
lsb_release -a
which python3
python3 --version
which python3.12 || true
python3.12 --version || true
```

```text
Ubuntu 22.04 → system Python is usually 3.10
Ubuntu 24.04 → system Python is usually 3.12
```

You want Python 3.12.

---

### 2. Delete any unwanted venvs

Conservative manual method:

```bash
rm -rf /path/to/project/.venv
rm -rf /path/to/project/venv
rm -rf /path/to/project/env
```

For example:

```bash
rm -rf ~/my-repo/.venv
```

---

### 3. Optional Cleanup

These are optional, but useful if you want a clean start.

Check pipx:

```bash
command -v pipx && pipx list
```

Remove pipx environments only if you want to remove all pipx-installed tools:

```bash
rm -rf ~/.local/pipx
```

Check common Python caches:

```bash
du -sh ~/.cache/pip 2>/dev/null
du -sh ~/.cache/pypoetry 2>/dev/null
du -sh ~/.cache/uv 2>/dev/null
```

Optional cleanup:

```bash
rm -rf ~/.cache/pip
rm -rf ~/.cache/pypoetry
rm -rf ~/.cache/uv
```

Check for pyenv, if relevant:

```bash
command -v pyenv && pyenv versions
```

If you previously installed pyenv and want it gone:

```bash
rm -rf ~/.pyenv
```

Then remove any `pyenv` lines from:

```bash
~/.bashrc
~/.profile
~/.bash_profile
~/.zshrc
```

---

Verify the cleanup

```bash
python3 --version
which python3
which python3.12 || true
python3.12 --version || true
apt list --installed 2>/dev/null | grep -E '^(python3\.12|libpython3\.12)' || true
grep -R "deadsnakes" /etc/apt/sources.list /etc/apt/sources.list.d/ 2>/dev/null || true
```

A clean result on Ubuntu 22.04 would usually look something like:

```text
python3 --version
Python 3.10.x

which python3
/usr/bin/python3

which python3.12
# no output
```

## III. Python `venv` Setup Basics

### 0. Upgrade the venv tooling:

```bash
python -m pip install --upgrade pip setuptools wheel
```

### 1. Standard repo-local venv setup

The usual pattern is one virtual environment per repo, named `.venv`.

```text
my-repo/
├── .venv/              # local virtual environment; do not commit
├── .vscode/
│   └── settings.json   # optional VS Code repo settings
├── requirements.txt
└── ...
```

From the repo root:

```bash
python3 -m venv .venv
source .venv/bin/activate
python -m pip install --upgrade pip
```

Install dependencies:

```bash
python -m pip install -r requirements.txt
```

Install a new package:

```bash
python -m pip install package-name
```

Save the current environment:

```bash
python -m pip freeze > requirements.txt
```

Deactivate the environment:

```bash
deactivate
```

Prefer:

```bash
python -m pip install ...
```

over bare:

```bash
pip install ...
```

because it guarantees that `pip` belongs to the active Python interpreter.

---

### 2. Verify that the venv is active

Basic check:

```bash
which python
python -c "import sys; print(sys.executable)"
```

Expected output should include something like:

```text
/path/to/my-repo/.venv/bin/python
```

More reliable check:

```bash
python -c "import sys; print(sys.prefix != sys.base_prefix)"
```

Expected output:

```text
True
```

This test is especially useful when working with shared or symlinked virtual environments.

---

### 3. VS Code setup

Install the VS Code extensions:

```text
Python
Pylance
```

Create:

```text
.vscode/settings.json
```

For a repo-local `.venv`, use:

```json
{
  "python.defaultInterpreterPath": "${workspaceFolder}/.venv/bin/python",
  "python-envs.workspaceSearchPaths": [
    "./.venv"
  ]
}
```

Then select the interpreter once:

```text
Ctrl+Shift+P → Python: Select Interpreter → ./.venv/bin/python
```

After selecting the interpreter, kill the existing terminal and open a new one:

```text
Terminal → Kill Terminal
Terminal → New Terminal
```

The new terminal should auto-activate the venv.

---

### 4. Enable VS Code terminal auto-activation

In your VS Code **user settings**, use:

```json
{
  "python-envs.terminal.autoActivationType": "command",
  "python.terminal.activateEnvironment": true
}
```

The newer setting is:

```json
"python-envs.terminal.autoActivationType": "command"
```

The older setting is:

```json
"python.terminal.activateEnvironment": true
```

Keeping both is usually harmless and helps across VS Code/Python extension versions.

After changing these settings, kill the current terminal and open a new one.

---

### 5. Sharing one venv across related projects

The usual best practice is one venv per repo. However, sharing a single venv is reasonable when several projects intentionally use the same dependency stack.

This is often convenient for related personal projects, such as several PreTeXt book repositories, where the goal is to avoid maintaining the same packages repeatedly.

Use a shared venv when:

* The projects use the same Python version.
* The projects have nearly identical dependencies.
* You control all of the projects.
* You are comfortable with package updates affecting all of them.
* The venv is mainly for development or build tooling.

Avoid sharing when:

* The projects require different versions of the same package.
* One project needs experimental packages.
* You need strict reproducibility.
* The repo will be used by students, collaborators, or CI.

Practical rule:

> Use a shared venv for closely related personal projects, but keep each repo’s `requirements.txt` accurate so you can recreate a dedicated venv later if needed.

---

### 6. Create a shared venv

Create the shared venv outside any individual repo:
```bash
mkdir -p ~/.venvs
python3 -m venv ~/.venvs/shared-pretext
```

Activate the shared venv
```bash
source ~/.venvs/shared-pretext/bin/activate
```

Install everything needed for PreTeXt
```bash
python -m pip install --upgrade pip
python -m pip install pretext[all]

```

If there is a `requirements.txt` file, run:
```
python -m pip install -r requirements.txt
```

To activate it directly later:

```bash
source ~/.venvs/shared-pretext/bin/activate
```

---

### 7. Use a shared venv through a repo-local `.venv` symlink

This approach keeps VS Code looking for `.venv`, but makes `.venv` point to the shared environment.

From the repo root:

```bash
ln -s ~/.venvs/shared-pretext .venv
```

Your repo then looks like it has a normal `.venv`, but the environment actually lives at:

```text
~/.venvs/shared-pretext
```

Use this `.vscode/settings.json`:

```json
{
  "python.defaultInterpreterPath": "${workspaceFolder}/.venv/bin/python",
  "python-envs.workspaceSearchPaths": [
    "./.venv"
  ]
}
```

Then select the interpreter once:

```text
Ctrl+Shift+P → Python: Select Interpreter → ./.venv/bin/python
```

This step matters. Creating the symlink is not always enough for VS Code to select the environment automatically.

After selecting the interpreter:

```text
Terminal → Kill Terminal
Terminal → New Terminal
```

The new terminal should auto-activate the shared venv through the local `.venv` symlink.

---

### 8. Important note about symlinked venvs

With a symlinked shared venv, this is expected:

```bash
readlink -f .venv
```

Example output:

```text
/home/gcox/.venvs/shared-pretext
```

But this may resolve to the system Python:

```bash
readlink -f .venv/bin/python
```

Example output:

```text
/usr/bin/python3.10
```

That does not necessarily mean the venv is broken. Many Linux virtual environments use the system Python executable while redirecting packages through the venv.

Use this test instead:

```bash
python -c "import sys; print(sys.prefix != sys.base_prefix)"
```

Expected output:

```text
True
```

If that prints `True`, Python is running inside a virtual environment.

---

### 9. Updating a shared venv

When dependencies change in one repo, activate the shared venv and update it:

```bash
source ~/.venvs/shared-pretext/bin/activate
python -m pip install -r requirements.txt
```

Because the venv is shared, this update affects every repo using it.

---

### 10. Common commands

| Task                                | Command                                                        |
| ----------------------------------- | -------------------------------------------------------------- |
| Create a repo-local venv            | `python3 -m venv .venv`                                        |
| Activate a repo-local venv          | `source .venv/bin/activate`                                    |
| Create a shared venv                | `python3 -m venv ~/.venvs/shared-pretext`                      |
| Activate a shared venv              | `source ~/.venvs/shared-pretext/bin/activate`                  |
| Symlink repo `.venv` to shared venv | `ln -s ~/.venvs/shared-pretext .venv`                          |
| Upgrade `pip`                       | `python -m pip install --upgrade pip`                          |
| Install dependencies                | `python -m pip install -r requirements.txt`                    |
| Add a dependency                    | `python -m pip install package-name`                           |
| Save dependencies                   | `python -m pip freeze > requirements.txt`                      |
| Check interpreter                   | `python -c "import sys; print(sys.executable)"`                |
| Check whether Python is in a venv   | `python -c "import sys; print(sys.prefix != sys.base_prefix)"` |
| Check package install location      | `python -m pip --version`                                      |
| List installed packages             | `python -m pip list`                                           |
| Check for dependency conflicts      | `python -m pip check`                                          |
| Deactivate the venv                 | `deactivate`                                                   |
| Delete a repo-local venv            | `rm -rf .venv`                                                 |
| Delete a shared venv                | `rm -rf ~/.venvs/shared-pretext`                               |

---

### 11. Minimal recipe: repo-local venv

```bash
cd my-repo

python3 -m venv .venv
source .venv/bin/activate

python -m pip install --upgrade pip
python -m pip install -r requirements.txt

mkdir -p .vscode
cat > .vscode/settings.json <<'EOF'
{
  "python.defaultInterpreterPath": "${workspaceFolder}/.venv/bin/python",
  "python-envs.workspaceSearchPaths": [
    "./.venv"
  ]
}
EOF

grep -qxF ".venv/" .gitignore || echo ".venv/" >> .gitignore
```

Then in VS Code:

```text
Ctrl+Shift+P → Python: Select Interpreter → ./.venv/bin/python
Terminal → Kill Terminal
Terminal → New Terminal
```

---

### 12. Minimal recipe: shared venv with repo-local symlink

Create the shared venv once:

```bash
mkdir -p ~/.venvs
python3 -m venv ~/.venvs/shared-pretext
source ~/.venvs/shared-pretext/bin/activate
python -m pip install --upgrade pip
python -m pip install -r requirements.txt
```

In each repo that should use the shared venv:

```bash
cd my-repo

ln -s ~/.venvs/shared-pretext .venv

mkdir -p .vscode
cat > .vscode/settings.json <<'EOF'
{
  "python.defaultInterpreterPath": "${workspaceFolder}/.venv/bin/python",
  "python-envs.workspaceSearchPaths": [
    "./.venv"
  ]
}
EOF

grep -qxF ".venv/" .gitignore || echo ".venv/" >> .gitignore
```

Then in VS Code:

```text
Ctrl+Shift+P → Python: Select Interpreter → ./.venv/bin/python
Terminal → Kill Terminal
Terminal → New Terminal
```

Verify:

```bash
python -c "import sys; print(sys.prefix != sys.base_prefix)"
```

Expected output:

```text
True
```

## IV. PreTeXT installation and Dependencies

A key point: **only PreTeXt/PreFigure go inside the Python venv**. Node.js, LaTeX, and SageMath are external executables that your venv can call.

---

### 0. Confirm your venv is active

You should see your `.venv` path here:

```bash
which python
python --version
which pip
pip --version
```

For example:

```text
/home/gcox/path/to/project/.venv/bin/python
Python 3.12.x
```

Upgrade the venv tooling:

```bash
python -m pip install --upgrade pip setuptools wheel
```

---

### 1. Install useful Ubuntu build libraries

These help with Python packages that compile native extensions, especially `pycairo`, and with PreFigure PDF conversion.

```bash
sudo apt update

sudo apt install \
  build-essential \
  pkg-config \
  git \
  curl \
  unzip \
  python3 \
  python3-venv \
  python3-dev \
  python3-pip \
  libcairo2-dev \
  librsvg2-bin \
  libxml2-dev \
  libxslt1-dev \
  jing
```

PreFigure’s documentation specifically notes that `rsvg-convert`, provided on Ubuntu by `librsvg2-bin`, is needed for making PDF versions of diagrams. ([GitHub][1])

---

### 2. Install PreTeXt and PreFigure in the active venv

Install PreTeXt and its optional dependency set:

```bash
python -m pip install "pretext[all]"
```

---

### 3. Install Node.js

Install `nvm`:

```bash
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.5/install.sh | bash
```

Then load it in the current shell:

```bash
export NVM_DIR="$HOME/.nvm"
. "$NVM_DIR/nvm.sh"
```

Install the current LTS Node:

```bash
nvm install --lts
nvm use --lts
nvm alias default 'lts/*'
```

Verify:

```bash
node --version
npm --version
which node
which npm
```

You want:

```text
node --version
v18.x or later
```

Then initialize PreFigure’s Node assets:

```bash
prefig init
```

PreFigure’s docs say `prefig init` installs MathJax modules and the Braille29 font used for tactile diagrams. ([GitHub][1])

---

### 4. Install LaTeX / TeX Live

For PreTeXt PDF output and `<latex-image>` / TikZ content, the simplest reliable option is full TeX Live:

```bash
sudo apt install texlive-full
```

This is large, but it avoids the common cycle of missing LaTeX packages. The Ubuntu community documentation says Ubuntu provides TeX Live through the repositories and that `texlive-full` installs the complete TeX Live distribution. ([Ubuntu Help][5])

Verify:

```bash
xelatex --version
pdflatex --version
latexmk --version
```

The PreTeXt guide specifically suggests `xelatex --version` as a check for PDF/TikZ support. ([PreTeXt][2])

A smaller but less complete alternative is:

```bash
sudo apt install \
  texlive \
  texlive-latex-extra \
  texlive-xetex \
  texlive-fonts-recommended \
  texlive-pictures \
  latexmk
```

For your PreTeXt work, I would use `texlive-full` unless disk space is a serious concern.

---

### 5. Install SageMath

For Ubuntu 24.04 / WSL, I would **not** try `sudo apt install sagemath` first. SageMath’s own installation guide recommends Conda/Miniforge for WSL, and gives WSL-specific instructions using Miniforge followed by a Conda Sage environment. ([SageMath Documentation][6]) The Conda installation page also says SageMath can be installed on Linux via Conda from `conda-forge`. ([SageMath Documentation][7])

Because you already have a Python venv active, install SageMath separately. You can either open a fresh terminal or temporarily run:

```bash
deactivate
```

Then install Miniforge:

```bash
cd ~
curl -L -O "https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge3-$(uname)-$(uname -m).sh"
bash Miniforge3-$(uname)-$(uname -m).sh
```

Close and reopen the Ubuntu terminal, or load Conda manually if the installer tells you to.

I recommend preventing Conda from auto-activating its base environment:

```bash
conda config --set auto_activate_base false
```

Create a SageMath environment:

```bash
conda create -n sage sage python=3.12
```

Verify Sage:

```bash
conda activate sage
sage --version
sage
```

Exit Sage with:

```python
quit
```

Then leave the Conda environment:

```bash
conda deactivate
```

SageMath’s WSL instructions currently show creating a `sage` Conda environment with `sage python=3.12`. ([SageMath Documentation][6])

---

### 6. Make `sage` available while your Python venv is active

PreTeXt needs to be able to call a `sage` executable. Since Sage is in a Conda environment, the clean solution is to make a small wrapper script.

Create `~/bin` if needed:

```bash
mkdir -p ~/bin
```

Create a wrapper:

```bash
cat > ~/bin/sage <<'EOF'
#!/usr/bin/env bash
exec "$HOME/miniforge3/bin/conda" run -n sage sage "$@"
EOF

chmod +x ~/bin/sage
```

Make sure `~/bin` is on your PATH:

```bash
grep -q 'export PATH="$HOME/bin:$PATH"' ~/.bashrc || echo 'export PATH="$HOME/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc
```

Now reactivate your project venv:

```bash
cd /path/to/your/project
source .venv/bin/activate
```

Verify that the venv can still see Sage:

```bash
which sage
sage --version
```

You should see:

```text
/home/gcox/bin/sage
SageMath version ...
```

---

### 7. Final verification checklist

Run these from inside your project with the venv active:

```bash
which python
python --version

which pretext
pretext --version

which prefig
prefig --help

node --version
npm --version

xelatex --version
latexmk --version

sage --version
```

Then from your PreTeXt project root, try:

```bash
pretext build
```

or target-specific builds, for example:

```bash
pretext build html
pretext build pdf
```

---

### 8. What I would not do

Avoid these:

```bash
sudo pip install pretext
sudo npm install -g ...
sudo apt install sagemath   # on Ubuntu 24.04 this is likely not the right path
```

Use the Python venv for PreTeXt/PreFigure, `nvm` for Node, Ubuntu packages for TeX Live, and Conda/Miniforge for SageMath. This keeps each tool in the environment where it behaves best.