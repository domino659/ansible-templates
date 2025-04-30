```bash
# variables
# ansible 2.9 : export ANSIBLE_CALLBACK_WHITELIST=profile_tasks
export ANSIBLE_CALLBACKS_ENABLED=profile_tasks
#export DOCKER_HOST="tcp://192.168.1.10:2375"
#export DOCKER_HOST=tcp://192.168.1.3:2376 DOCKER_TLS_VERIFY=1
# export DOCKER_HOST="unix:///mnt/wsl/shared-docker/docker.sock"
export PATH="$PATH:$HOME/.local/bin"

#export GIT_TRACE_PACKET=0
#export GIT_TRACE=0
#export GIT_CURL_VERBOSE=0

# ssh keys
SSH_AGENT_CONF="$HOME/.ssh/agent"
if [ -e "$SSH_AGENT_CONF" ];then
        . $SSH_AGENT_CONF > /dev/null
fi
ssh-add -l 2>/dev/null >/dev/null
if [ $? -ne 0 ];then
        ssh-agent >| $SSH_AGENT_CONF
        if [ $? -ne 0 ];then
                echo "ERROR: Could no launch ssh-agent" >&2
        fi
        . $SSH_AGENT_CONF > /dev/null
        ssh-add $HOME/.ssh/lguesse-cegid
        ssh-add $HOME/.ssh/lguesse-azure
fi

if [ $TILIX_ID ] || [ $VTE_VERSION ]; then
    source /etc/profile.d/vte.sh
fi

# for vscode

[[ "$TERM_PROGRAM" == "vscode" ]] && . "$(code --locate-shell-integration-path zsh)"

# other alias
alias ansible2.9="source ~/.venv/ansible2.9/bin/activate"
alias ansible2.12="source ~/.venv/ansible2.12/bin/activate"
alias ansible2.14="source ~/.venv/ansible2.14/bin/activate"
alias ansible-core='source ~/.venv/ansible-core/bin/activate'
#alias devops='ansible-core && sleep 2 && code $1'
alias devops='source ~/.venv/ansible-core/bin/activate'
alias update='sudo apt update && sudo apt list --upgradable && sleep 5 && sudo apt dist-upgrade -y && sudo apt autoremove --purge -y'
```