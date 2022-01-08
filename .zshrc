# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH
export TERM="xterm-256color"

# Path to your oh-my-zsh installation.
export ZSH=/Users/rajesh.kaki/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
#ZSH_THEME="robbyrussell"
#ZSH_THEME="agnoster"
#ZSH_THEME="powerlevel9k/powerlevel9k"
ZSH_THEME=powerlevel10k/powerlevel10k

typeset -g POWERLEVEL9K_KUBECONTEXT_SHOW_ON_COMMAND='kubectl|helm|kubens|kubectx'
# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git zsh-autosuggestions)
#plugins=(git zsh-autosuggestions)
#plugins=(git)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(dir rbenv vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(command_execution_time kubecontext status root_indicator background_jobs time)
#POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(command_execution_time time)
bindkey ^f forward-word
bindkey ^b backward-word
#cd /Users/rajesh.kaki/Flipkart/
source ~/.profile

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# Show directory path in prompt similar to fish shell
POWERLEVEL9K_SHORTEN_DIR_LENGTH=1
POWERLEVEL9K_SHORTEN_DELIMITER=""
POWERLEVEL9K_SHORTEN_STRATEGY="truncate_from_right"

# Rename tmux window title to ssh hostname
function ssh() {
    if [ "$(ps -p $(ps -p $$ -o ppid=) -o comm=)" = "tmux" ]; then
    	tmux rename-window "$(echo $* | rev | cut -d ' ' -f1 | rev)"
        #tmux rename-window "$(echo $* | cut -d . -f 1)" 
	    command ssh "$@"
      tmux set-window-option automatic-rename "on" 1>/dev/null
    else
        command ssh "$@"
    fi
}

function chpwd() {
    if [ "$(ps -p $(ps -p $$ -o ppid=) -o comm=)" = "tmux" ]; then
	print -Pn "\033k%C\033\\"
    fi
}
export EDITOR=vim

# Use GNU utils by default
export PATH="/usr/local/opt/coreutils/libexec/gnubin:/usr/local/bin:$PATH"
alias f='cd /Users/rajesh.kaki/Flipkart'
#alias man='_() { echo $1; man -M $(brew --prefix)/opt/coreutils/libexec/gnuman $1 1>/dev/null 2>&1;  if [ "$?" -eq 0 ]; then man -M $(brew --prefix)/opt/coreutils/libexec/gnuman $1; else man $1; fi }; _'

# To fix slow zsh copy paste
### Fix slowness of pastes with zsh-syntax-highlighting.zsh
pasteinit() {
  OLD_SELF_INSERT=${${(s.:.)widgets[self-insert]}[2,3]}
  zle -N self-insert url-quote-magic # I wonder if you'd need `.url-quote-magic`?
}

pastefinish() {
  zle -N self-insert $OLD_SELF_INSERT
}
zstyle :bracketed-paste-magic paste-init pasteinit
zstyle :bracketed-paste-magic paste-finish pastefinish
### Fix slowness of pastes

# To highlight commands
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
# Escape single quotes - https://stackoverflow.com/questions/1250079/how-to-escape-single-quotes-within-single-quoted-strings
alias vm_stat='vm_stat | perl -ne '"'"'/page size of (\d+)/ and $size=$1; /Pages\s+([^:]+)[^\d]+(\d+)/ and printf("%-16s % 16.2f Mi\n", "$1:", $2 * $size / 1048576);'"'"
alias s='source ~/.zshrc'
alias chrome='ps aux | grep Chrome | awk '"'"'{print $6}'"'"' | awk '"'"'{count+=$0} END { print count/1024 "M" }'"'"
alias ustart='VBoxManage startvm UbuntuServer --type headless'
alias ustop='VBoxManage controlvm UbuntuServer poweroff'
alias ulogin='ssh -p 2222 mac@localhost'

# Open the current command in vim by pressing Esc v 
autoload -U edit-command-line
zle -N edit-command-line
bindkey -M vicmd v edit-command-line
# To open a command in vim, run bindkey -v and press Esc v

# In case copying in zsh console takes time, this is the fix - https://github.com/robbyrussell/oh-my-zsh/issues/4854
export PATH="/usr/local/opt/libxml2/bin:$PATH"
export PATH="/usr/local/opt/gettext/bin:$PATH"
alias css='/usr/local/Cellar/csshx/0.74/bin/csshX'
alias w='cd "/Users/rajesh.kaki/Library/Application Support/Alfred 2/Alfred.alfredpreferences/workflows/user.workflow.66A630A8-6F3A-41A4-9336-BB123C1BFCB9"'
alias vpn='bash /Users/rajesh.kaki/Flipkart/scripts/rsatoken &'
# https://github.com/arcanericky/totp
alias totp='/Users/rajesh.kaki/Flipkart/totp/bin/totp-darwin-amd64'
alias im='cd "/Users/rajesh.kaki/Library/Application Support/Alfred 2/Alfred.alfredpreferences/workflows/user.workflow.405632F7-06C1-4FAA-8D34-00D8A5498DF8"'
alias ls='ls --color'
set linespace=0
#alias git='/usr/local/Cellar/git/2.27.0/bin/git'
alias gg='git log --oneline --abbrev-commit --all --graph --decorate --color --date-order'
alias psaux='ps axo user:20,pid,pcpu,pmem,vsz,rss,tty,stat,start,time,comm'
alias orctools='/usr/local/Cellar/orc-tools/1.4.1/bin/orc-tools'
alias pg_start="launchctl load ~/Library/LaunchAgents/homebrew.mxcl.postgresql.plist"
alias pg_stop="launchctl unload ~/Library/LaunchAgents/homebrew.mxcl.postgresql.plist"
alias sed="/usr/local/bin/gsed"
export PATH="/usr/local/opt/mysql@5.7/bin:$PATH"
export LC_ALL=en_US.UTF-8
DISABLE_UPDATE_PROMPT=true
alias ipython3='~/Library/Python/3.7/bin/ipython3'
#alias k='minikube kubectl'
#alias kubectl='minikube kubectl'
#. /usr/local/etc/profile.d/z.sh
export KUBECONFIG=~/.kube/config:~/.kube/config_fk:~/.kube/config_playground_5:~/.kube/config_fk_app:~/.kube/config_playground_5_app:~/.kube/config_fk_ch_meta

[ -f ~/.kubectl_aliases ] && source ~/.kubectl_aliases
function kubectl() { echo "+ kubectl $@">&2; command kubectl $@; }
function ks() { echo "+ kubectl exec -n paas-mtl -it $@ -- bash">&2; command kubectl exec -n paas-mtl -it $@ -- bash; }
#alias ssh=/Users/rajesh.kaki/Downloads/wssh-0.1.0_darwin-amd64/wssh
#source "/usr/local/opt/kube-ps1/share/kube-ps1.sh"
#PS1='$(kube_ps1)'$PS1
alias wssh='/Users/rajesh.kaki/Flipkart/wssh 10.33.18.38'
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"

# Jumping around dirs
. /Users/rajesh.kaki/z/z.sh
alias kctx='kubectx -'
alias kx='kubectx'

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
alias ev='/Users/rajesh.kaki/Downloads/clinote-0.6.1-macos/clinote'
alias evs='/Users/rajesh.kaki/Downloads/clinote-0.6.1-macos/clinote note list --search'
alias evso='/Users/rajesh.kaki/Downloads/clinote-0.6.1-macos/clinote note'

alias vim='/usr/local/Cellar/vim/8.2.2825/bin/vim'
alias v='vim ~/.vimrc'
alias vt='vim ~/Flipkart/vimTips'
# Vim bindings for ZSH Command line editor - http://web.cs.elte.hu/zsh-manual/zsh_14.html
# bindkey -v
#
alias jmc='/Library/Java/JavaVirtualMachines/jdk1.8.0_60.jdk/Contents/Home/bin/java -XstartOnFirstThread -Djava.net.preferIPv4Stack=true -Dorg.eclipse.swt.internal.carbon.smallFonts -jar /Library/Java/JavaVirtualMachines/jdk1.8.0_60.jdk/Contents/Home/lib/missioncontrol/mc.jar -ws cocoa'
alias pdfmerge="/System/Library/Automator/Combine\ PDF\ Pages.action/Contents/Resources/join.py"
alias ssh="fkst-cli installCert; ssh"

# Short of learning how to actually configure OSX, here's a hacky way to use
# GNU manpages for programs that are GNU ones, and fallback to OSX manpages otherwise
# alias man='_() { echo $1; man -M $(brew --prefix)/opt/coreutils/libexec/gnuman $1 1>/dev/null 2>&1;  if [ "$?" -eq 0 ]; then man -M $(brew --prefix)/opt/coreutils/libexec/gnuman $1; else man $1; fi }; _'
export JAVA_HOME="/Library/Java/JavaVirtualMachines/jdk1.8.0_172.jdk/Contents/Home"
alias elc="/Users/rajesh.kaki/Flipkart/personal/scratchspace/elc.sh"
