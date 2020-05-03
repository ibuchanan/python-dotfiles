zstyle ':completion:*' completer _complete _ignored _approximate
zstyle ':completion:*' matcher-list '' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}'
zstyle ':completion:*' max-errors 2 numeric
zstyle :compinstall filename '$HOME/.zshrc'
autoload -Uz compinit
compinit
HISTFILE=~/.histfile
HISTSIZE=500
SAVEHIST=10000
setopt autocd beep notify
bindkey -v

LANG=en_US.UTF-8
bb=$HOME/dev/git/bitbucket.com/ian_buchanan
GITHUB_USER=ibuchanan

if [ -d "$HOME/bin" ]; then
    PATH=$HOME/bin:$PATH
fi
if [ -d "$HOME/.local/bin" ]; then
    PATH=$HOME/.local/bin:$PATH
fi

EDITOR="code"

# Python
if [ -x "$(command -v python)" ]; then
    WORKON_HOME=$HOME/.virtualenvs
    PYENV_ROOT="$HOME/.pyenv"
    if [ -d "$PYENV_ROOT" ]; then
        CFLAGS='-O2'
        PATH="$PYENV_ROOT/bin:$PATH"
        if [ -x "$(command -v pyenv)" ]; then
            eval "$(pyenv init -)"
        fi
    fi
    # if [ -x "$(command -v python3)" ]; then
    #     VIRTUALENV_PYTHON=$(command -v python3)
    #     VIRTUALENVWRAPPER_PYTHON=$(command -v python3)
    # fi
fi

# Lastpass
if [ -x "$(command -v lpass)" ]; then
    LPASS_AGENT_TIMEOUT=$(( 12 * 60 * 60 ))
fi

source ~/.gvm/scripts/gvm
source ~/.antigen/antigen.zsh

antigen use oh-my-zsh

antigen bundle command-not-found
antigen bundle common-aliases
antigen bundle git
antigen bundle git-extras
antigen bundle go
antigen bundle golang
antigen bundle httpie
antigen bundle node
antigen bundle npm
antigen bundle nvm
antigen bundle pip
antigen bundle python
antigen bundle sudo
#antigen bundle virtualenvwrapper

antigen bundle mattberther/zsh-pyenv
antigen bundle zsh-users/zsh-syntax-highlighting
# antigen bundle joel-porquet/zsh-dircolors-solarized.git

# antigen theme https://bitbucket.org/ian_buchanan/ibuchanan.zsh-theme ibuchanan
#antigen bundle nojhan/liquidprompt

antigen apply

eval "$(starship init zsh)"
eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)
