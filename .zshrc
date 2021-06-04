# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=/home/shini/.oh-my-zsh

export TERM="xterm-256color"

DISABLE_UPDATE_PROMPT=true
DISABLE_AUTO_UPDATE=true

# ZSH THEMES
POWERLEVEL9K_INSTALLATION_PATH="$ZSH/custom/themes/powerlevel10k"
POWERLEVEL9K_MODE="awesome-fontconfig"
ZSH_THEME="powerlevel10k/powerlevel10k"

POWERLEVEL9K_STATUS_VERBOSE=true
POWERLEVEL9K_STATUS_OK_IN_NON_VERBOSE=true
POWERLEVEL9K_PROMPT_ADD_NEWLINE=true
POWERLEVEL9K_PROMPT_ON_NEWLINE=true
POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX=''
POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX='%K{0252}%F{black} \Uf017 %D{%H:%M:%S} %f%k%F{0252}%f '
POWERLEVEL9K_SHORTEN_DIR_LENGTH=3
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(background_jobs status_joined context dir_writable dir vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(kubecontext vpn_ip)
POWERLEVEL9K_DIR_HOME_FOREGROUND="white"
POWERLEVEL9K_DIR_HOME_SUBFOLDER_FOREGROUND="white"
POWERLEVEL9K_DIR_DEFAULT_FOREGROUND="white"
POWERLEVEL9K_PROMPT_ADD_NEWLINE=true
POWERLEVEL9K_STATUS_OK_BACKGROUND="black"
POWERLEVEL9K_STATUS_OK_FOREGROUND="green"
POWERLEVEL9K_STATUS_ERROR_BACKGROUND="black"
POWERLEVEL9K_STATUS_ERROR_FOREGROUND="red"
#POWERLEVEL9K_VPN_IP_INTERFACE="tun"
POWERLEVEL9K_VPN_IP_BACKGROUND="red"
POWERLEVEL9K_VPN_IP_FOREGROUND="white"
POWERLEVEL9K_IP_BACKGROUND="252"
POWERLEVEL9K_IP_FOREGROUND="black"
POWERLEVEL9K_KUBECONTEXT_BACKGROUND="027"
POWERLEVEL9K_KUBECONTEXT_FOREGROUND="white"
POWERLEVEL9K_KUBERNETES_ICON="\U2638"
POWERLEVEL9K_KUBECONTEXT_SHOW_ON_COMMAND='kubectl|kubens|kubectx'
POWERLEVEL9K_TIME_BACKGROUND="cyan"
POWERLEVEL9K_TIME_FOREGROUND="black"
POWERLEVEL9K_CONTEXT_DEFAULT_BACKGROUND="black"
POWERLEVEL9K_CONTEXT_DEFAULT_FOREGROUND="green"
POWERLEVEL9K_CONTEXT_REMOTE_BACKGROUND="black"
POWERLEVEL9K_CONTEXT_REMOTE_FOREGROUND="darkgreen"
POWERLEVEL9K_CONTEXT_REMOTE_SUDO_BACKGROUND="black"
POWERLEVEL9K_CONTEXT_REMOTE_SUDO_FOREGROUND="darkorange"
#POWERLEVEL9K_CONTEXT_SUDO_BACKGROUND="black"
#POWERLEVEL9K_CONTEXT_SUDO_FOREGROUND="orange"
POWERLEVEL9K_CONTEXT_ROOT_BACKGROUND="black"
POWERLEVEL9K_CONTEXT_ROOT_FOREGROUND="red"
POWERLEVEL9K_BACKGROUND_JOBS_BACKGROUND="black"
POWERLEVEL9K_BACKGROUND_JOBS_FOREGROUND="red"
POWERLEVEL9K_BACKGROUND_TIME="white"
POWERLEVEL9K_BACKGROUND_TIME="block"

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
HIST_STAMPS="dd.mm.yyyy"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(zsh-256color zsh-z git git-remote-branch git-auto-fetch svn vagrant docker docker-compose systemd apt vault kubectl zsh-completions)

source $ZSH/oh-my-zsh.sh

# Automatically update PATH entries
zstyle ':completion:*' rehash true

# User configuration
eval $(dircolors)

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
alias svi="sudo nvim"
alias vi="nvim"
alias vim="nvim"
alias vimdiff="nvim -d"
alias service="sudo service"
alias ipa="ip --brief --color a"
alias ssa="ss -plantue"

# bat
export BAT_THEME="Solarized (light)"
alias cat="bat"
export MANPAGER="sh -c 'col -bx | bat -l man -p'"
