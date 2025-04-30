```bash
# --------------------------------------------------------------
# Main zsh configuration file
# Create       : 2025/01/29
# Modificate   : 2025/04/17
# Location     : /etc/zsh/
# Dependency   : zgit, zscreen, zsh-fzf-history, dir-colors
# --------------------------------------------------------------

# Alias
alias ls='ls --tabsize=0 --literal --color=auto --show-control-chars --human-readable --time-style="+%d/%m/%y %H:%M:%S" --group-directories-first'
alias ll='ls -l'
alias la='ls -A'
alias l='ls -CF'
alias lla='ls -Al'

alias cp='cp --interactive'
alias mv='mv --interactive'
alias rm='rm --interactive'
alias df='df --human-readable'
alias du='du --human-readable'

alias ..='cd ..'
alias s='cd ..'
alias ...='cd ../..'

alias c='clear -x'
alias less='less --quiet'
alias less='less --quiet'
alias history='history -i 0'

# Options
setopt nobeep              # disable bip
setopt autocd              # change directory just by typing its name
#setopt correct            # auto correct mistakes
setopt interactivecomments # allow comments in interactive mode
setopt magicequalsubst     # enable filename expansion for arguments of the form ‘anything=expression’
setopt nonomatch           # hide error message if there is no match for the pattern
setopt notify              # report the status of background jobs immediately
setopt numericglobsort     # sort filenames numerically when it makes sense
setopt promptsubst         # enable command substitution in prompt
setopt hist_verify         # Si on utilise '!' la commande est juste écriteet et non exécutée
setopt clobber             # use >| force write file
unsetopt hup               # ne pas envoyer 'HUP' aux jobs qui tournent quand le shell se ferme

# History
HISTFILE=~/.history
HISTSIZE=5000
SAVEHIST=8000

setopt hist_expire_dups_first    # delete duplicates first when HISTFILE size exceeds HISTSIZE
setopt hist_ignore_dups          # ignore duplicated commands history list
setopt hist_ignore_space         # ignore commands that start with space
setopt hist_verify               # show command with history expansion to user before running it
#setopt share_history             # share command history data
setopt share_history             # Share history across multiple zsh sessions

# Bindkey
bindkey -e
bindkey '^A'     beginning-of-line                 # HOME
bindkey '^[[1~'  beginning-of-line                 # HOME
bindkey '^[[H'   beginning-of-line                 # HOME
bindkey '^E'     end-of-line                       # END
bindkey '^[[4~'  end-of-line                       # END
bindkey '^[[F'   end-of-line                       # END
bindkey '^D'     delete-char                       # DEL
bindkey '^[[3~'  delete-char                       # DEL
bindkey '^[[2~'  overwrite-mode                    # INS
bindkey '^[[5~'  history-search-backward           # PG UP
bindkey '^[[6~'  history-search-forward            # PG DOWN
bindkey '^R' history-incremental-search-backward   # CTRL+R
bindkey '^[[1;5C' forward-word                     # ctrl + ->
bindkey '^[[1;5D' backward-word                    # ctrl + <-
bindkey '^[[3;5~' kill-word                        # ctrl + del
bindkey '^[[Z' undo                                # shift + tab

if [ "$COLORTERM" = "gnome-terminal" ]
then
   bindkey '^[OH' beginning-of-line          # HOME
   bindkey '^[OF' end-of-line                # END
fi

# Completion
autoload -Uz compinit
unset list_ambiguous                              # Schema de completion C
compinit -d ~/.cache/zcompdump
zstyle ':completion:*:*:*:*:*' menu select
zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' rehash true
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

# Enable syntax-highlighting
if [ -f /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
    . /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
    ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern)
    ZSH_HIGHLIGHT_STYLES[default]=none
    ZSH_HIGHLIGHT_STYLES[unknown-token]=underline
    ZSH_HIGHLIGHT_STYLES[reserved-word]=fg=cyan,bold
    ZSH_HIGHLIGHT_STYLES[suffix-alias]=fg=green,underline
    ZSH_HIGHLIGHT_STYLES[global-alias]=fg=green,bold
    ZSH_HIGHLIGHT_STYLES[precommand]=fg=green,underline
    ZSH_HIGHLIGHT_STYLES[commandseparator]=fg=blue,bold
    ZSH_HIGHLIGHT_STYLES[autodirectory]=fg=green,underline
    ZSH_HIGHLIGHT_STYLES[path]=bold
    ZSH_HIGHLIGHT_STYLES[path_pathseparator]=
    ZSH_HIGHLIGHT_STYLES[path_prefix_pathseparator]=
    ZSH_HIGHLIGHT_STYLES[globbing]=fg=blue,bold
    ZSH_HIGHLIGHT_STYLES[history-expansion]=fg=blue,bold
    ZSH_HIGHLIGHT_STYLES[command-substitution]=none
    ZSH_HIGHLIGHT_STYLES[command-substitution-delimiter]=fg=magenta,bold
    ZSH_HIGHLIGHT_STYLES[process-substitution]=none
    ZSH_HIGHLIGHT_STYLES[process-substitution-delimiter]=fg=magenta,bold
    ZSH_HIGHLIGHT_STYLES[single-hyphen-option]=fg=green
    ZSH_HIGHLIGHT_STYLES[double-hyphen-option]=fg=green
    ZSH_HIGHLIGHT_STYLES[back-quoted-argument]=none
    ZSH_HIGHLIGHT_STYLES[back-quoted-argument-delimiter]=fg=blue,bold
    ZSH_HIGHLIGHT_STYLES[single-quoted-argument]=fg=yellow
    ZSH_HIGHLIGHT_STYLES[double-quoted-argument]=fg=yellow
    ZSH_HIGHLIGHT_STYLES[dollar-quoted-argument]=fg=yellow
    ZSH_HIGHLIGHT_STYLES[rc-quote]=fg=magenta
    ZSH_HIGHLIGHT_STYLES[dollar-double-quoted-argument]=fg=magenta,bold
    ZSH_HIGHLIGHT_STYLES[back-double-quoted-argument]=fg=magenta,bold
    ZSH_HIGHLIGHT_STYLES[back-dollar-quoted-argument]=fg=magenta,bold
    ZSH_HIGHLIGHT_STYLES[assign]=none
    ZSH_HIGHLIGHT_STYLES[redirection]=fg=blue,bold
    ZSH_HIGHLIGHT_STYLES[comment]=fg=black,bold
    ZSH_HIGHLIGHT_STYLES[named-fd]=none
    ZSH_HIGHLIGHT_STYLES[numeric-fd]=none
    ZSH_HIGHLIGHT_STYLES[arg0]=fg=cyan
    ZSH_HIGHLIGHT_STYLES[bracket-error]=fg=red,bold
    ZSH_HIGHLIGHT_STYLES[bracket-level-1]=fg=blue,bold
    ZSH_HIGHLIGHT_STYLES[bracket-level-2]=fg=green,bold
    ZSH_HIGHLIGHT_STYLES[bracket-level-3]=fg=magenta,bold
    ZSH_HIGHLIGHT_STYLES[bracket-level-4]=fg=yellow,bold
    ZSH_HIGHLIGHT_STYLES[bracket-level-5]=fg=cyan,bold
    ZSH_HIGHLIGHT_STYLES[cursor-matchingbracket]=standout
fi

# Enable auto-suggestion
if [ -f /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh ]; then
    . /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
    # change suggestion color
    ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=#999'
fi

# Eenable command-not-found
if [ -f /etc/zsh_command_not_found ]; then
    . /etc/zsh_command_not_found
fi

# Config title on term
case "$TERM" in
xterm*|rxvt*|Eterm|aterm|kterm|gnome*|alacritty)
    TERM_TITLE=$'\e]0;${debian_chroot:+($debian_chroot)}${VIRTUAL_ENV:+($(basename $VIRTUAL_ENV))}%n@%m: %~\a'
    ;;
*)
    ;;
esac

# Config dir_colors
if [ -x /usr/bin/dircolors ]; then
    if [ -r ~/.dir_colors ]; then
        eval "`dircolors ~/.dir_colors`"
    elif [ -r /etc/dir_colors ]; then
        eval "`dircolors /etc/dir_colors`"
    else
        eval "`dircolors`"
    fi

    export LS_COLORS="$LS_COLORS:ow=30;44:" # fix ls color for folders with 777 permissions

    #alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
    alias diff='diff --color=auto'
    alias ip='ip --color=auto'

    export LESS_TERMCAP_mb=$'\E[1;31m'     # begin blink
    export LESS_TERMCAP_md=$'\E[1;36m'     # begin bold
    export LESS_TERMCAP_me=$'\E[0m'        # reset bold/blink
    export LESS_TERMCAP_so=$'\E[01;33m'    # begin reverse video
    export LESS_TERMCAP_se=$'\E[0m'        # reset reverse video
    export LESS_TERMCAP_us=$'\E[1;32m'     # begin underline
    export LESS_TERMCAP_ue=$'\E[0m'        # reset underline

    # Take advantage of $LS_COLORS for completion as well
    zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
    zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
fi

# Other prompt
source /etc/zsh/zgit
source /etc/zsh/zscreen
source /etc/zsh/ztmux
source /etc/zsh/zsh-fzf-history

# Prompt
VIRTUAL_ENV_DISABLE_PROMPT=1           # Disable venv prompt
PROMPT_EOL_MARK=""                     # Hide EOL sign (%)
NEWLINE_BEFORE_PROMPT=yes              # Add new line before prompt

configure_prompt() {
    prompt_symbol="󰁥"
    [ "$EUID" -eq 0 ] && prompt_symbol=""
    prompt_zone1="(TERRE)─"

    PROMPT=$'%F{%(#.red.blue)}┬─'$prompt_zone1$'${VIRTUAL_ENV:+(󰌠$(basename $VIRTUAL_ENV))─}$(git_super_status)(%B%F{%(#.red.blue)}%n%F{3}'$prompt_symbol$'%B%F{%(#.red.blue)}%m%b%F{%(#.red.blue)})─(%B%F{reset}%(6~.%-1~/…/%4~.%5~)%b%F{%(#.red.blue)})\n╰─>(%B%F{33}%*%b%F{%(#.red.blue)})$(super_screen)$(super_tmux) %B%F{%(#.red.blue)}►%b%F{reset} '

    unset prompt_symbol
    unset prompt_zone1
}


stats="%F{9}[%f\$loadavg %F{154}-%f \$memory%F{9}]%f"
RPS1="$stats%{$reset_color%}"

precmd() {
    # Print the previously configured title
    print -Pnr -- "$TERM_TITLE"

    # For RPROMPT
    load=(${$(< /proc/loadavg)})
    loadavg="$load[1] $load[2]"
    buffer=(${$(free)})
    memory="$((100 * $buffer[10] / $buffer[8]))%%"               # ram
#    memory="$memory $((100 * $buffer[16] / $buffer[15] ))%%"    # swap


    # Print a new line before the prompt, but only if it is not the first line
    if [ "$NEWLINE_BEFORE_PROMPT" = yes ]; then
        if [ -z "$_NEW_LINE_BEFORE_PROMPT" ]; then
            _NEW_LINE_BEFORE_PROMPT=1
        else
            print ""
        fi
    fi
}

# Load the prompt
configure_prompt

# Other functions
logview() { ccze -A < $1 | less -R }
logtail() { tail -f $1 | ccze }
```