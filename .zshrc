# This config is based on a combination of existing .bashrc & .bash_aliases in
# this directory, adapted to work on zsh.
# Large number of configs:
# http://stackoverflow.com/questions/171563/whats-in-your-zshrc
# For more info, also consult man pages starting with zsh...
############################################################################
# Path Settings
############################################################################
#{{{
# .software is for any precompiled programs & libraries I install.
# .opt is for programs compiled from src, sources stay in OPT/src while bins to OPT/bin
export SOFT=~/.software
export OPTDIR=~/.opt

# Personal scripts go here to stay outside of root.
MYSCRIPTS=~/.my_scripts

# Dir to locally install cabal for haskell.
HASKELL_BIN=~/.cabal/bin

export GRADLE_HOME=$SOFT/gradle
export GROOVY_HOME=$SOFT/groovy
export GOPATH=$HOME/go

# Exported paths.
ANDROID=$SOFT/android-sdk/tools:$SOFT/android-sdk/platform-tools:$SOFT/android-ndk
export JAVA_HOME=$SOFT/jdk
export CLASSPATH=$SOFT/jlibs:$JAVA_HOME/lib:/usr/share/ant/lib:/usr/share/java:$CLASSPATH
# /usr/lib/ccache on path -> links gcc, g++ to ccache aliases, put at front.
export PATH=/usr/lib/ccache:$MYSCRIPTS:$SOFT/bin:$OPTDIR/bin:$JAVA_HOME/bin:$HASKELL_BIN:$ANDROID:$PATH
#export CPATH=$SOFT/libs/include:$CPATH
#export LIBRARY_PATH=$SOFT/libs/lib:$LIBRARY_PATH

# Paths for specific tools.
export ANT_HOME=/usr/share/ant

# Path to lookup functions
fpath=(~/.shell/.zsh-completions/src $fpath)
fpath=(~/.zsh_completions $fpath)
#}}}
############################################################################
# Environment Variables
############################################################################
#{{{
# Default editor for things like sudoedit.
if valid_name vim; then
    export EDITOR=vim
fi

# If you want to have a fallback path lookup, use CDPAth.
#export CDPATH=~/programming

#CCache Directory
#Info: https://ccache.samba.org/manual.html
#export CCACHE_DISABLE=1
export CCACHE_COMPRESS=1
export CCACHE_DIR=~/.ccache

# Change grep color to bold blue
export GREP_COLORS='ms=01;34:mc=01;34:sl=:cx=:fn=35:ln=32:bn=32:se=36'

# Help dir for zsh
export HELPDIR=$OPTDIR/share/man/man1

# Merge tool for hg
export HGMERGE=/usr/bin/kdiff3

# Bash history options
# Set large history file & line limit
export HISTFILE=~/.zsh_history
export HISTSIZE=100000
export SAVEHIST=100000

# Ignore some commands
#export HISTIGNORE='ls *:l *:bg:fg:history'

# Default pager
export PAGER=less

# Make ps print useful info
export PS_FORMAT=user,pid,ppid,tty,pcpu,pmem,stat,start_time,cmd

# If we aren't sshed, set term to 256 color support
if [ -n "$DISPLAY" ]; then
    if [ "$TERM" = "xterm" ]; then
        export TERM=xterm-256color
    elif [ "$TERM" = "screen" ]; then
        export TERM=screen-256color
    fi
fi

# No git state caching, prefer to always be accurate
export ZSH_THEME_GIT_PROMPT_NOCACHE=1
#}}}
############################################################################
# Aliases
############################################################################
#{{{
# Note: First word of alias is expanded as alias, others ignored. Hence ll, expands ls.

# Keep home configs when switching to root
alias su='su --preserve-environment'

# Make ls more convenient
alias l='\ls --color=auto -F --group-directories-first'
alias ls='l --sort=extension'
alias ll='ls -Alh'
alias la='l -A'

# Different sorts
alias lx='ll -XB'  # Extension
alias lk='ll -Sr'  # File size
alias lt='ll -tur' # Access time
alias lc='ll -tcr' # CTime, last change to attributes (fperms, ownership)
alias lm='ll -tr'  # Modification time

# Recursive cp
alias cpr='cp -r'

# Always create non-existing parent dirs
alias mkdir='mkdir -vp'

# Man for use when searching local built libs.
alias manl='man -M libs/share/man'

# Alias for use of pushd/popd
alias pu="pushd"
alias po="popd"

# Grep should always print line
alias grep='grep --color=auto -n --exclude-dir=.git --exclude-dir=.hg --exclude-dir=.bzr --exclude-dir=.svn --exclude-dir=.cvs'
# Re alias these to take advantage of above
alias egrep='grep -E'
alias fgrep='grep -F'
alias rgrep='grep -r'

# Alias for ps, sorts like pstree
alias pst="ps -eH"

# type used to determine what command is, list all entries
alias types='type -a'

# Always open with splits
alias vims='vim -o'

# df/du defaults, du -L to follow symlinks
alias df='df -hT'
alias du='du -h'
if valid_name dfc; then
    alias dfc='dfc -T'
fi

# For vims java eclipse completion
if valid_name eclimd; then
    alias eclimd='eclimd -b -Xss4m -Xms1024m -Xmx2048m'
fi

# Colored cat output
if valid_name pygmentize; then
    alias ccat='pygmentize -g'
    compdef ccat _pygmentize
fi

# Default ack options, use smart case, sort output by file and follow symlinks.
# Filter by type with --type, supported types `ack --help-types`
if valid_name ack; then
    alias ack='ack --smart-case --sort-files --follow --color-match="bold blue"'
    # Alias for ack find file by name
    alias ackf='ack -g'
    # Alias for ack find file by contents
    alias ackl='ack -il'
    compdef ackl _ack
fi

# Alias for silver search
# For type use --type, i.e. --cpp. supported types -> 'ag --list-file-types
if valid_name ag; then
    alias ag='ag --smart-case --follow --color-match="1;34"'
    # Alias for ag find file by name
    alias agf='ag -g'
    # Alias for ag find file by contents
    alias agl='ag -il'
    compdef agl _ag
fi

# Add an "alert" alias for long running commands. Example:
#   sleep 10; alert
if valid_name notify-send; then
    alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'
fi

# Apt aliases
if valid_name apt-get; then
    alias apti='sudo apt-get -y install'
    alias aptr='sudo apt-get -y remove'
    alias aptu='sudo apt-get update && sudo apt-get -y dist-upgrade'
fi

# Alias for color tools.
if valid_name colordiff; then
    alias cod='colordiff'
fi
if valid_name colorgcc; then
    alias cog='colorgcc'
fi
if valid_name colormake; then
    alias com='colormake'
fi

# Silence parallel
if valid_name parallel; then
    alias parallel='parallel --no-notice'
fi

# Useful pstree highlight current parents
if valid_name pstree; then
    alias pstree='pstree -hn'
fi

# Shutdown the current machine immediately
if valid_name shutdown; then
    alias off='sudo shutdown -h now'
fi

# Force 256 colors, woe is me without
if valid_name tmux; then
    alias tmux='tmux -2'
fi

# Use trash instead of RM, have had bad accidents. Need trash-cli library for python.
if valid_name trash-put; then
    alias trash-restore='restore-trash'
    alias tre='restore-trash'
    alias tp='trash-put'
    alias tl='trash-list'
    alias te='trash-empty'
    alias rm='echo "Don''t use. If must, \rm -Rf file."; false'
fi

# Tree program, use instead of recursive ls. Very pretty.
if valid_name tree; then
    alias tree='tree -Csuh'
fi

# Aliases for vimpager
if valid_name vimpager; then
    alias vcat='vimcat'
    alias vpager='vimpager'
fi

# Zsh only aliases
alias help='run-help'

# History with time stamps
alias history='history -E'

# Debug alias, appears xtrace can't be set except outside functions.
alias debug='if debug; then setopt xtrace; else unsetopt xtrace; clear; fi'
#}}}
############################################################################
# Functions
############################################################################
#{{{
# Reruns the last command with sudo.
function please() {
    local cmd="$(fc -l -n -2 | head -n 1 | sed -e "s/^[ \t]*//")"
    echo -e "Will execute with sudo: ${T_BGREEN}${cmd}${T_RESET}";
    echo "Execute? y/n"

    local go
    read go
    go="$(echo "$go" | tr [[:upper:]] [[:lower:]])"
    if [[ "$go" == y* ]]; then
        sudo $cmd
    fi
}

# Take a directory. If it doesn't exist, make it.
function take() {
    local dir="$1"
    mkdir "$dir"
    cd "$dir"
}

# Toggles bash debug mode, when on:
#  * Turns on tracing of every command (xtrace).
#  * Prevents unsetting vars (nounset).
#  * Prints lines before execution (verbose).
#  * Disables bash prompt to avoid pollution with xtrace.
#
#  N.B. zsh bug that xtrace can't be set in a function
function debug() {
    # If ps1 contains debug word, turn off debug mode
    if contains "$PS1" "DEBUG"; then
        PS1="$PS1_STD"
        #unsetopt nounset
        unsetopt sourcetrace
        unsetopt verbose
        unsetopt warncreateglobal
        #unsetopt xtrace
        save_hooks 0
        print "Bash Debug Mode: ${fg_bold[red]}DISABLED${reset_color}"
        return 1
    else
        PS1="$PS1_DEBUG"
        #setopt nounset
        setopt sourcetrace
        setopt verbose
        unsetopt warncreateglobal
        #setopt xtrace
        save_hooks 1
        print "Bash Debug Mode: ${fg_bold[green]}ENABLED${reset_color}"
        print "Careful with ${fg_bold[red]}nounset${reset_color} breaks some completion."
        return 0
    fi
}

# Function to go back up when deep in directories.
# Example: .. 3 == cd ../../..
function ..() {
    if [ $1 -ge 0 2> /dev/null ]; then
        x=$1
    else
        x=1
    fi

    for (( i = 0; i < $x; i++ )); do
        cd ..
    done
}

# Check if connection up at all by pinging google dns
function conTest() {
    for url in "8.8.8.8" "8.8.4.4"; do
        ping -c 3 $url
    done
}

# Check if term supports 256 -> http://www.robmeerman.co.uk/unix/256colours
function termColor() {
    curl http://www.robmeerman.co.uk/_media/unix/256colors2.pl > c.pl 2>/dev/null
    perl ./c.pl
    \rm c.pl
}

# Format a json file to be pretty
function jsonFix() {
    for file ; do
        cat "$file" | python -m json.tool > "fix_$file"
    done
}

# Useful functions inspired by:
#http://www.tldp.org/LDP/abs/html/sample-bashrc.html
# Get info on all network interfaces
function listNics() {
    INTS=( "${(@f)$(ifconfig -s | awk ' /^wlan.*|eth.*/ { print $1 }')}" )
    # Ample use of awk/sed for field extraction.
    for INT in $INTS ; do
        local   MAC=$(ifconfig $INT | awk '/Waddr/ { print $5 } ')
        local    IP=$(ifconfig $INT | awk '/inet / { print $2 } ' | sed -e s/addr://)
        local BCAST=$(ifconfig $INT | awk '/inet / { print $3 } ' | sed -e s/Bcast://)
        local  MASK=$(ifconfig $INT | awk '/inet / { print $4 } ' | sed -e s/Mask://)
        local   IP6=$(ifconfig $INT | awk '/inet6/ { print $3 } ')

        print "Interface: ${fg_bold[green]}$INT${reset_color}"
        print "\tMac:   ${MAC}"
        print "\tIPv4:  ${IP:-"Not connected"}"
        if [[ -n ${IP} ]]; then
            print "\tBCast: ${BCAST}"
            print "\tMask:  ${MASK}"
            print "\tIPv6:  ${IP6:-"N/A."}"
        fi
    done
    unset INTS
}

# Pretty print of df, like dfc.
function prettyDf() {
    for fs ; do

        if [ ! -d $fs ]; then
            print $fs" :No such file or directory"
            continue
        fi

        info=( "${(s/ /)$(command df -P $fs | awk 'END{ print $2,$3,$5 }')}" )
        local free="${(@f)$(command df -Pkh $fs | awk 'END{ print $4 }')}"
        local nbstars=$(( 20 * $info[2] / $info[1] ))
        local out="["
        for ((j=0;j<20;j++)); do
            if [ ${j} -lt ${nbstars} ]; then
               out=$out"*"
            else
               out=$out"-"
            fi
        done
        out=$info[3]" "$out"] ("$free" free on "$fs")"
        print $out
    done
    unset info
}

# Get information on current system
function ii() {
    TOP=$(top -n 1 -o %CPU | sed '/^$/d' | head -n 12 | tail -n 11)
    print
    print "${fg_bold[blue]}$USERNAME${reset_color} is logged on ${fg_bold[blue]}$HOST${reset_color}"
    print "${fg_bold[blue]}Additionnal information :${reset_color} " ; uname -a
    print "${fg_bold[blue]}Users logged on :${reset_color} " ; w -hs |
             cut -d " " -f1 | sort | uniq
    print "${fg_bold[blue]}Current date :${reset_color} " ; date
    print "${fg_bold[blue]}Machine stats :${reset_color} " ; uptime
    print "${fg_bold[blue]}Diskspace :${reset_color} "
    if valid_name dfc; then
        dfc
    else
        mounts=( "${(@f)$(mount -v | awk '/\/dev\/s/ { print $3 }')}" )
        prettyDf $mounts
        unset mounts
    fi
    print "${fg_bold[blue]}Memory stats :${reset_color} " ; free -h
    print "${fg_bold[blue]}Top 5 CPU% :${reset_color} " ; print "$TOP" | head -n 2 ; print "$TOP" | tail -n 6
    print "${fg_bold[blue]}Top 5 MEM% :${reset_color} " ; top -n 1 -o %MEM | sed '/^$/d' | head -n 12 | tail -n 5
    print "${fg_bold[blue]}Network Interfaces :${reset_color}" ; listNics
    print "${fg_bold[blue]}Open connections :${reset_color} "; netstat -pan --inet;
    print
    unset TOP
}

# Highlight many terms with different colors
# Usage: find . | h term1 term2 term3
source ~/.shell/.hhighlighter/h.sh
#}}}
############################################################################
# Misc Options
############################################################################
#{{{
# Enable the windows key on Ubuntu as F13
if valid_name xmodmap; then
    xmodmap -e 'keycode 133 = F13'
fi

# Disable the Ctrl+s/q button that freezes terminal output.
if valid_name stty; then
    stty -ixon
fi

# Set bash tabstop to 4 spaces, default is 8 too wide
if valid_name tabs; then
    tabs 4
fi

# KDE DEV Options:

# I have a kde-bashrc file with shortcuts for building.
# http://techbase.kde.org/Getting_Started/Build/Environment
#. ~/.kde-bashrc
#echo "NOTE IMPORTANT: make is now aliased to makeobj. Remove line from .bash_alias."

# Set default config environment. If need specialize, copy into dir of src tree.
#. ~/.build-config-default
#}}}
############################################################################
# Autoload, Completion & Setopt
############################################################################
#{{{
# Zcalc is a neat cmdline calculator
autoload -U zcalc

# Load zsh shell colors
autoload -U colors && colors
# Loaded colors will be in associated arrays called: fg_no_bold, fg_bold, bg
#   KEYS: red green yellow blue magenta cyan black white
# RESET COLOR $reset_color
# EXAMPLE: print "$fg_no_bold[red] hello $reset_color"

# Allows us to override shell hooks like for before prompt
autoload -U add-zsh-hook

# Use vcs info for bzr & svn
autoload -Uz vcs_info

# Case insensitive
autoload -U compinit
compinit

## case-insensitive (all),partial-word and then substring completion
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' \
    'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

# Faster completion with cache
zstyle ':completion::complete:*' use-cache 1

# Don't complete directory we are already in (../here)
zstyle ':completion:*' ignore-parents parent pwd

# generate descriptions with magic.
zstyle ':completion:*' auto-description 'specify: %d'

# # Don't prompt for a huge list, page it!
zstyle ':completion:*:default' list-prompt '%S%M matches%s'

# # Don't prompt for a huge list, menu it if over 2 eles!
zstyle ':completion:*:default' menu 'select=2'

# # Have the newer files first or alphabtical
zstyle ':completion:*' file-sort modification
#zstyle ':completion:*' file-sort alpha

# # color code completion!!!!  Wohoo!
#zstyle ':completion:*' list-colors "=(#b) #([0-9]#)*=36=31"
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

# Don't complete stuff already on the line for commands in regex
zstyle ':completion::*:(ag|ack|cp|git|hg|mv|rm|tp|vi|vim):*' ignore-line true

# Group completions by type & have blue header above.
#zstyle ':completion:*:descriptions' format $'\e[00;34m%d'
#zstyle ':completion:*:messages' format $'\e[00;31m%d'
#zstyle ':completion:*' group-name ''

# Separate man page sections.  Neat.
zstyle ':completion:*:manuals.*'  group-name   true
zstyle ':completion:*:manuals.*'  insert-sections   true
zstyle ':completion:*:manuals'    separate-sections true
zstyle ':completion:*:man:*'      menu yes select

# Make kill/killall work better
zstyle ':completion:*:*:kill:*' menu yes select
zstyle ':completion:*:kill:*' force-list always
zstyle ':completion:*:*:kill:*:processes' list-colors "=(#b) #([0-9]#)*=29=34"
zstyle ':completion:*:*:killall:*' menu yes select
zstyle ':completion:*:killall:*' force-list always

# Ignore certain files or directories, better than fignore
zstyle ':completion:*:*files' ignored-patterns '*?.(o|class|pyc)' '*?~'
zstyle ':completion:*:*:cd:*' ignored-patterns '(*/|)(bzr|git|hg|svn)'

# Settings for vcs_info
zstyle ':vcs_info:*' enable bzr cvs svn
zstyle ':vcs_info:*' check-for-changes true
# Staged Unstaged [Branch] vcs_type-repo_name
zstyle ':vcs_info:*' formats "%{$fg[green]%}%c%{$reset_color%} %{$fg[red]%}%u%{$reset_color%} [%{$fg_bold[magenta]%}%b%{$reset_color%}] %{$fg_bold[cyan]%}%r%{$reset_color%} <%{$fg[yellow]%}%s%{$reset_color%}>"

# History should append if multiple versions run
setopt APPEND_HISTORY

# History saves beginning and elapsed time for commands
setopt EXTENDED_HISTORY

# History writing better on nfs
setopt HIST_FCNTL_LOCK

# History lookup ignores duplicate commands
setopt HIST_FIND_NO_DUPS

# Ignore duplicates if they are same as previous.
setopt HIST_IGNORE_DUPS

# Ignore the history command itself
setopt HIST_NO_STORE

# Reduce blanks when possible
setopt HIST_REDUCE_BLANKS

# If need to share history or write immediately
# see SHARE_HISTORY, INC_APPEND_HISTORY
setopt SHARE_HISTORY

# Allow braces to define character classes like: file{abcd1234}
setopt BRACE_CCL

# Use extended globbing
setopt EXTENDED_GLOB

# Use ksh globing, brings leading @, +() etc...
setopt KSH_GLOB

# Enable rematch (=~) to use pcre instead of shell regex.
#setopt REMATCH_PCRE

# Correct spelling mistakes only on commands
setopt CORRECT

# pushd -> pushd $HOME
setopt PUSHD_TO_HOME

# Don't exit with ctrl + D
setopt IGNORE_EOF

# Two single quotes escape to one in single quotes
setopt RC_QUOTES

# Jobs print in long format for more info
setopt LONG_LIST_JOBS

# Enable prompt var substitution & root/user bang.
setopt PROMPT_BANG
setopt PROMPT_SUBST

# RM star commands wait before proceeding.
setopt RM_STAR_WAIT

# Use vim mode
setopt VI

# Zero index arrays, like normal people
#setopt KSH_ARRAYS

# Set compatible globbing.
#setopt KSH_GLOB
#}}}
############################################################################
# Key Bindings
############################################################################
#{{{
# When in completion, move backwards, key is shift+tab
bindkey '^[[Z' reverse-menu-complete

# History lookup bindings to usual r key
bindkey '^r' history-incremental-search-backward
bindkey '^s' history-incremental-search-forward

# Backspace deletes past start
bindkey '^?' backward-delete-char

# Scroll up or down a completion list
bindkey '^j' down-line-or-history
bindkey '^k' up-line-or-history

# Use my normal jk map to escape insert mode
bindkey 'jk' vi-cmd-mode

# vim-like undo and redo
bindkey -M vicmd 'u' undo
bindkey -M vicmd '^R' redo

# it's like, space AND completion. Allows for expansion of hist cmds,
# example: $1<space>
bindkey -M viins ' ' magic-space

# oh wow!  This is killer...  try it!
# Pushes current line onto a stack, comes off after next prompt
bindkey -M vicmd "q" push-line-or-edit
#}}}
############################################################################
# PS1 Prompt
############################################################################
#{{{
# Following section just for $vim_mode var hence here.
vim_ins_mode="%{$fg_bold[red]%}[INS]%{$reset_color%}"
vim_cmd_mode="%{$fg_bold[blue]%}[CMD]%{$reset_color%}"
vim_mode=$vim_ins_mode

function zle-keymap-select() {
    vim_mode="${${KEYMAP/vicmd/${vim_cmd_mode}}/(main|viins)/${vim_ins_mode}}"
    zle reset-prompt
}
zle -N zle-keymap-select

function zle-line-finish() {
    vim_mode=$vim_ins_mode
}
zle -N zle-line-finish

# HG prompt like bash-git-prompt
function hg_prompt() {
    local p_line="${fg_bold[magenta]}{branch}${reset_color}{ ${fg[red]}↓{incoming|count}${reset_color}}"
    p_line="${p_line}{ ${fg[green]}↑{outgoing|count}${reset_color}}|${fg[yellow]}{status}{update}${reset_color}"
    local HG=$(hg prompt "[${p_line}]" 2>/dev/null)

    # Strip everything except where status to outgoing would be.
    local T=${HG##*|}
    T=${T%%]}

    # Insert check mark only if T doesn't contain other codes like status or update, see regexp.
    if [ "x${HG}" != "x" ] && [[ ! ${T} =~ [!?^↓↑] ]]; then
        HG="${HG%%]}${fg_bold[green]}✔${reset_color}]"
    fi

    echo "$HG"
}

function prompt_precmd() {
    if [ $? -eq 0 ]; then
        LAST="%F{green}✔%f"
    else
        LAST="%F{red}✘%F{yellow}-$?%f"
    fi

    vcs_info
}

# Save hooks if arge is 1, else restore them.
# Needed for debug function above, or if I just want to disabe.
function save_hooks {
    if [ "$1" = "1" ]; then
        chpwd_functions=
        precmd_functions=
        preexec_functions=
    else
        add-zsh-hook precmd prompt_precmd
        source ~/.shell/.zsh-git-prompt/zshrc.sh
        # Shell highlighting
        source ~/.shell/.zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
    fi
}

# Just aliases for common colors used later.
PS1_DIR=%B%F{red}%~%f%b
PS1_USER=%F{cyan}%n%f
PS1_HOST=%F{green}%m%f

# If root, highlight it
if [ $UID -eq 0 ]; then
    PS1_USER=%B%F{yellow}%n%f%b
fi

# If using ssh, usually set
if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ] || [ -n "$SSH_CONNECTION" ];then
    PS1_HOST=%B%F{red}%m%f%b
fi

if [ "x" = "x$TMUX" ]; then
    PS1_STD='$LAST { ${PS1_DIR} } $(hg_prompt)$(git_super_status)${vcs_info_msg_0_}
${PS1_USER}@${PS1_HOST}%# '
    PS1_DEBUG='%B%F{red} >>DEBUG<< %f%b$LAST { ${PS1_DIR} }
${PS1_USER}@${PS1_HOST}%# '
else
    PS1_STD='$LAST { ${PS1_DIR} } $(hg_prompt)$(git_super_status)${vcs_info_msg_0_}
${PS1_USER}%# '
    PS1_DEBUG='%B%F{red} >>DEBUG<< %f%b$LAST { ${PS1_DIR} }
${PS1_USER}%# '
fi
PS1="$PS1_STD"
RPROMPT='${vim_mode}'

# Zsh will print when users log in
watch=all                # watch all logins
logcheck=30              # every 30 seconds
WATCHFMT="%n from %M has %a tty%l at %T %W"

# Activate the prompt hooks for git/hg
save_hooks 0
#}}}
# vim: set foldmethod=marker:
