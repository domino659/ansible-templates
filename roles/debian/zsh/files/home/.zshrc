### ─── AGENT SSH AUTOMATIQUE ─────────────────────────────────────────────────
# Fichier temporaire contenant les variables de l’agent SSH
SSH_AGENT_CONF="$HOME/.ssh/agent"

# Si ce fichier existe, on le source pour restaurer l'agent existant
if [ -e "$SSH_AGENT_CONF" ]; then
    . "$SSH_AGENT_CONF" > /dev/null
fi

# Si aucune clé n’est chargée, on démarre un nouvel agent et on ajoute la clé privée
ssh-add -l 2>/dev/null >/dev/null
if [ $? -ne 0 ]; then
    ssh-agent >| "$SSH_AGENT_CONF"
    if [ $? -ne 0 ]; then
        echo "ERROR: Could not launch ssh-agent" >&2
    fi
    . "$SSH_AGENT_CONF" > /dev/null
    ssh-add "$HOME/.ssh/msion"
fi

### ─── ANSIBLE ────────────────────────────────────────────────────────────────

# Active le plugin `profile_tasks` d’Ansible, qui affiche la durée d’exécution de chaque tâche.
export ANSIBLE_CALLBACKS_ENABLED=profile_tasks

### ─── DOCKER (commenté par défaut) ──────────────────────────────────────────

# Définir l'hôte Docker (selon la configuration locale ou distante) :
# export DOCKER_HOST="tcp://192.168.1.10:2375"                       # Non sécurisé
# export DOCKER_HOST="tcp://192.168.1.3:2376" DOCKER_TLS_VERIFY=1   # Sécurisé TLS
# export DOCKER_HOST="unix:///mnt/wsl/shared-docker/docker.sock"    # Socket Unix (WSL)

### ─── CHEMINS PERSONNELS ────────────────────────────────────────────────────
# Ajoute les binaires locaux (~/.local/bin) au PATH (ex. pour `pip install --user`)
export PATH="$PATH:$HOME/.local/bin"

### ─── GIT DEBUG (désactivé par défaut) ──────────────────────────────────────
# Ces variables activent la journalisation Git (réseau, curl, etc.)
# export GIT_TRACE_PACKET=0
# export GIT_TRACE=0
# export GIT_CURL_VERBOSE=0

### ─── TERMINAL TILIX / VTE ──────────────────────────────────────────────────
# Active la gestion dynamique du chemin dans Tilix ou terminal compatible VTE
if [ "$TILIX_ID" ] || [ "$VTE_VERSION" ]; then
    source /etc/profile.d/vte.sh
fi

### ─── INTÉGRATION VISUAL STUDIO CODE ───────────────────────────────────────
# Active l'intégration shell dans VS Code (amélioration du terminal intégré)
[[ "$TERM_PROGRAM" == "vscode" ]] && . "$(code --locate-shell-integration-path zsh)"

### ─── ALIAS UTILES ─────────────────────────────────────────────────────────
# Active l’environnement virtuel principal (Ansible Core)
alias devops='source ~/.venv/ansible-core/bin/activate'

# Mise à jour complète du système avec nettoyage
alias update='sudo apt update && sudo apt list --upgradable && sleep 5 && sudo apt dist-upgrade -y && sudo apt autoremove --purge -y'