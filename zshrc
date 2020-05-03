LANG=en_US.UTF-8
GITHUB_USER=ibuchanan
EDITOR="code"

# Homebrew
if [ -x "$(command -v /home/linuxbrew/.linuxbrew/bin/brew)" ]; then
    eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)
fi

# Lastpass
if [ -x "$(command -v lpass)" ]; then
    LPASS_AGENT_TIMEOUT=$(( 12 * 60 * 60 ))
fi

# Pip --user commands
if [ -d "$HOME/.local/bin" ]; then
    export PATH=$HOME/.local/bin:$PATH
fi

# Personal commands
if [ -d "$HOME/bin" ]; then
    export PATH=$HOME/bin:$PATH
fi

# Python
export WORKON_HOME=$HOME/.virtualenvs
export PYENV_ROOT="$HOME/.pyenv"
if [ -d "$PYENV_ROOT" ]; then
    CFLAGS='-O2'
    PATH="$PYENV_ROOT/bin:$PATH"
    if [ -x "$(command -v pyenv)" ]; then
        eval "$(pyenv init -)"
    fi
fi
# Path for brew pip
if [ -d "$(brew --prefix)/share/python" ]; then
    export PATH=$PATH:$(brew --prefix)/share/python
fi

# Go
if [ -d ~/.gvm ]; then
    source ~/.gvm/scripts/gvm
fi

# Node
export NVM_DIR="$HOME/.nvm"
if [ -d "$NVM_DIR" ]; then
    [ -s "/home/linuxbrew/.linuxbrew/opt/nvm/nvm.sh" ] && . "/home/linuxbrew/.linuxbrew/opt/nvm/nvm.sh"
    [ -s "/home/linuxbrew/.linuxbrew/opt/nvm/etc/bash_completion.d/nvm" ] && . "/home/linuxbrew/.linuxbrew/opt/nvm/etc/bash_completion.d/nvm"
fi

# Prompt
eval "$(starship init zsh)"

# Zinit

### Added by Zinit's installer
if [[ ! -f $HOME/.zinit/bin/zinit.zsh ]]; then
    print -P "%F{33}▓▒░ %F{220}Installing %F{33}DHARMA%F{220} Initiative Plugin Manager (%F{33}zdharma/zinit%F{220})…%f"
    command mkdir -p "$HOME/.zinit" && command chmod g-rwX "$HOME/.zinit"
    command git clone https://github.com/zdharma/zinit "$HOME/.zinit/bin" && \
        print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
        print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi

source "$HOME/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zinit-zsh/z-a-patch-dl \
    zinit-zsh/z-a-as-monitor \
    zinit-zsh/z-a-bin-gem-node

### End of Zinit's installer chunk

# Load plugins
zinit load DarrinTisdale/zsh-aliases-exa
zinit load zsh-users/zsh-syntax-highlighting
zinit load zsh-users/zsh-completions
zinit load zsh-users/zsh-autosuggestions
zinit snippet OMZ::plugins/command-not-found
