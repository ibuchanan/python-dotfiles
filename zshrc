LANG=en_US.UTF-8
GITHUB_USER=ibuchanan
EDITOR="code"

# Homebrew
if [ -x "$(command -v /home/linuxbrew/.linuxbrew/bin/brew)" ]; then
    eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)
fi

# Pip --user commands
if [ -d "$HOME/.local/bin" ]; then
    export PATH=$HOME/.local/bin:$PATH
fi

# Personal commands
if [ -d "$HOME/bin" ]; then
    export PATH=$HOME/bin:$PATH
fi

# Lastpass & secrets
if [ -x "$(command -v lpass)" ]; then
    LPASS_AGENT_TIMEOUT=$(( 12 * 60 * 60 ))
    ## Atlassian Developer Environment
    LPASS_ENV="devpartisan"
    ATLASSIAN_ACCOUNT_EMAIL=$(lpass show ".env\\${LPASS_ENV}/account" --username)
    ATLASSIAN_ACCOUNT_API_KEY=$(lpass show ".env\\${LPASS_ENV}/account" --password)
    ATLASSIAN_ACCOUNT_ID=$(lpass show ".env\\${LPASS_ENV}/account" --field="id")
    ATLASSIAN_APP_3LO_CLIENT_ID=$(lpass show ".env\\${LPASS_ENV}/3lo" --username)
    ATLASSIAN_APP_3LO_CLIENT_SECRET=$(lpass show ".env\\${LPASS_ENV}/3lo" --password)
    ATLASSIAN_APP_3LO_REDIRECT_URI=$(lpass show ".env\\${LPASS_ENV}/3lo" --url)
    ATLASSIAN_APP_2LO_CLIENT_ID=$(lpass show ".env\\${LPASS_ENV}/2lo" --username)
    ATLASSIAN_APP_2LO_CLIENT_SECRET=$(lpass show ".env\\${LPASS_ENV}/2lo" --password)
    ATLASSIAN_APP_NAME=$(shuf -n1  /usr/share/dict/words)-$(shuf -n1  /usr/share/dict/words)-$(shuf -n1  /usr/share/dict/words)
    ATLASSIAN_APP_ID=$(uuidgen)
    ATLASSIAN_APP_CONNECT_PORT=
    ATLASSIAN_APP_CONNECT_BASE_URL=https://${ATLASSIAN_APP_NAME}.example.com/
    ATLASSIAN_ORGANIZATION_ID=$(lpass show ".env\\${LPASS_ENV}/organization" --username)
    ATLASSIAN_ORGANIZATION_BEARER=$(lpass show ".env\\${LPASS_ENV}/organization" --password)
    ATLASSIAN_SITE_NAME=$(lpass show ".env\\${LPASS_ENV}/site" --field="name")
    ATLASSIAN_SITE_BASE_URL=$(lpass show ".env\\${LPASS_ENV}/site" --url)
    ATLASSIAN_SITE_CLOUD_ID=$(lpass show ".env\\${LPASS_ENV}/site" --field="id")
    ATLASSIAN_SITE_BASIC_USER=$(lpass show ".env\\${LPASS_ENV}/site" --username)
    ATLASSIAN_SITE_BASIC_PASS=$(lpass show ".env\\${LPASS_ENV}/site" --password)
fi

# Python
export WORKON_HOME=$HOME/.virtualenvs
export PYENV_ROOT="$HOME/.pyenv"
if [ -d "$PYENV_ROOT" ]; then
    export CFLAGS='-O2'
    export LDFLAGS="-L$(brew --prefix)/opt/zlib/lib -L$(brew --prefix)/opt/bzip2/lib -L$(brew --prefix)/opt/sqlite3/lib"
    export CPPFLAGS="-I$(brew --prefix)/opt/zlib/include -I$(brew --prefix)/opt/bzip2/include -I$(brew --prefix)/opt/sqlite3/include"
    PATH="$PYENV_ROOT/bin:$PATH"
    if [ -x "$(command -v pyenv)" ]; then
        eval "$(pyenv init -)"
    fi
fi
# Path for brew pip
if [ -d "$(brew --prefix)/share/python" ]; then
    export PATH=$PATH:$(brew --prefix)/share/python
fi

# Java
if [ -x "$(command -v jenv)" ]; then
    eval "$(jenv init -)"
fi

# Ruby
export RBENV_HOME="$HOME/.rbenv"
if [ -d "$RBENV_HOME" ]; then
	export PATH=$RBENV_HOME/bin:$PATH
	eval "$(rbenv init -)"
fi

# Go
if [ -d ~/.gvm ]; then
    source ~/.gvm/scripts/gvm
fi

# Node
export NODE_ENV=development
export NVM_DIR="$HOME/.nvm"
if [ -d "$NVM_DIR" ] && [ -s "$(brew --prefix nvm)/opt/nvm/nvm.sh" ]; then
    $(brew --prefix nvm)/opt/nvm/nvm.sh
fi

# Prompt
export STARSHIP_CONFIG=~/.starship.toml
if [ -x "$(command -v lpass)" ]; then
    eval "$(starship init zsh)"
fi
if [ -x "$(command -v neofetch)" ]; then
    neofetch
fi

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
