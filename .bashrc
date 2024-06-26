#
# ~/.bashrc
#

[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
# if [ -n "$TMUX" ]; then
#   PS1='$ '
# else
#   tmux new-session -A -s tmux
#   PS1='[\u@\h \W]\$ '
# fi

source ~/.env/bin/activate

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

export ANDROID_HOME=$HOME/Android/Sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/platform-tools
export PATH=$PATH:$HOME/.cargo/bin
export PATH=$PATH:$HOME/.dotnet/tools
export PATH=$PATH:/var/lib/snapd/snap/bin

eval "$(zoxide init --cmd cd bash)"
