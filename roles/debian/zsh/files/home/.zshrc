# # Set up the prompt

# autoload -Uz promptinit
# promptinit
# prompt adam1

# setopt histignorealldups sharehistory

# # Use emacs keybindings even if our EDITOR is set to vi
# bindkey -e

# # Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
# HISTSIZE=1000
# SAVEHIST=1000
# HISTFILE=~/.zsh_history

# # Use modern completion system
# autoload -Uz compinit
# compinit

# zstyle ':completion:*' auto-description 'specify: %d'
# zstyle ':completion:*' completer _expand _complete _correct _approximate
# zstyle ':completion:*' format 'Completing %d'
# zstyle ':completion:*' group-name ''
# zstyle ':completion:*' menu select=2
# eval "$(dircolors -b)"
# zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
# zstyle ':completion:*' list-colors ''
# zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
# zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
# zstyle ':completion:*' menu select=long
# zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
# zstyle ':completion:*' use-compctl false
# zstyle ':completion:*' verbose true

# zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
# zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'


# # ```bash
# # # variables
# # # ansible 2.9 : export ANSIBLE_CALLBACK_WHITELIST=profile_tasks
# # export ANSIBLE_CALLBACKS_ENABLED=profile_tasks
# # #export DOCKER_HOST="tcp://192.168.1.10:2375"
# # #export DOCKER_HOST=tcp://192.168.1.3:2376 DOCKER_TLS_VERIFY=1
# # #export DOCKER_HOST="unix:///mnt/wsl/shared-docker/docker.sock"
# # export PATH="$PATH:$HOME/.local/bin"

# # #export GIT_TRACE_PACKET=0
# # #export GIT_TRACE=0
# # #export GIT_CURL_VERBOSE=0

# # # ssh keys
# # SSH_AGENT_CONF="$HOME/.ssh/agent"
# # if [ -e "$SSH_AGENT_CONF" ];then
# #         . $SSH_AGENT_CONF > /dev/null
# # fi
# # ssh-add -l 2>/dev/null >/dev/null
# # if [ $? -ne 0 ];then
# #         ssh-agent >| $SSH_AGENT_CONF
# #         if [ $? -ne 0 ];then
# #                 echo "ERROR: Could no launch ssh-agent" >&2
# #         fi
# #         . $SSH_AGENT_CONF > /dev/null
# #         ssh-add $HOME/.ssh/lguesse-cegid
# #         ssh-add $HOME/.ssh/lguesse-azure
# # fi

# # if [ $TILIX_ID ] || [ $VTE_VERSION ]; then
# #     source /etc/profile.d/vte.sh
# # fi

# # # for vscode

# # # [[ "$TERM_PROGRAM" == "vscode" ]] && . "$(code --locate-shell-integration-path zsh)"

# # # # other alias
# # # alias ansible2.9="source ~/.venv/ansible2.9/bin/activate"
# # # alias ansible2.12="source ~/.venv/ansible2.12/bin/activate"
# # # alias ansible2.14="source ~/.venv/ansible2.14/bin/activate"
# # # alias ansible-core='source ~/.venv/ansible-core/bin/activate'
# # # #alias devops='ansible-core && sleep 2 && code $1'
# # # alias devops='source ~/.venv/ansible-core/bin/activate'
# # # alias update='sudo apt update && sudo apt list --upgradable && sleep 5 && sudo apt dist-upgrade -y && sudo apt autoremove --purge -y'
# # # ```

# # # zsh-syntax-highlighting
# # source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
# # if [ -f /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh ]; then
# #     . /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
# #     # change suggestion color
# #     ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=#999'
# # fi