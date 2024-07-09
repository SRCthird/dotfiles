# -----------------------------------------------------------------------------
# ~/.bashrc
# -----------------------------------------------------------------------------
[[ $- != *i* ]] && return

# -----------------------------------------------------------------------------
# ALIASES
# -----------------------------------------------------------------------------
alias ls='ls --color=auto'
alias grep='grep --color=auto'

# -----------------------------------------------------------------------------
# PYTHON
# -----------------------------------------------------------------------------
source ~/.env/bin/activate

# -----------------------------------------------------------------------------
# NODE
# -----------------------------------------------------------------------------
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# -----------------------------------------------------------------------------
# PATH
# -----------------------------------------------------------------------------
export ANDROID_HOME=$HOME/Android/Sdk
export PATH=$HOME/.local/bin:$PATH
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/platform-tools
export PATH=$PATH:$HOME/.cargo/bin
export PATH=$PATH:$HOME/.dotnet/tools
export PATH=$PATH:/var/lib/snapd/snap/bin

# -----------------------------------------------------------------------------
# WEZTERM + ZOXIDE
# -----------------------------------------------------------------------------
if [ -n $WSLENV ]; then
  eval "$(zoxide init bash)"
  function cd () {
    z "$@"    # perform the actual cd
    [[ TERM_PROGRAM -eq "WezTerm" ]] && 
      wezterm.exe set-working-directory $(pwd)
    }
else
  eval "$(zoxide init --cmd cd bash)"
fi

# -----------------------------------------------------------------------------
# PS1
# -----------------------------------------------------------------------------
function parse_git_dirty {
  [[ $(git status --porcelain 2> /dev/null) ]] && echo "*"
}
function parse_git_branch {
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/ (\1$(parse_git_dirty))/"
}

# Glyphs
LEFTCIRC=$'\xee\x82\xb6'  # 
ARCH=$'\xef\x8c\x83'      #  
RIGHTCIRC=$'\xee\x82\xb4' # 

# Colors
WHITE_BG=$'\e[47m'
WHITE_FG=$'\e[97m'
BLUE_BG=$'\e[44m'
BLUE_FG=$'\e[34m'
CYAN_BG=$'\e[46m'
CYAN_FG=$'\e[36m'
PURPLE_BG=$'\e[45m'
PURPLE_FG=$'\e[35m'
RESET=$'\e[0m'

# Chunks
DISTRO="${BLUE_FG}${LEFTCIRC}${RESET}${BLUE_BG}${WHITE_FG}${ARCH} ${RESET}${BLUE_FG}${CYAN_BG}${RIGHTCIRC}${RESET}"
w="${CYAN_BG}${WHITE_FG} \w${RESET}${CYAN_FG}${PURPLE_BG}${RIGHTCIRC}${RESET}"
GB="${PURPLE_BG}${WHITE_FG}\$(parse_git_branch)${RESET}${PURPLE_FG}${RIGHTCIRC}${RESET}"

# Whole
export PS1="${DISTRO}${w}${GB} \$ "
