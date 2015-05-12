# This file contains all bash modifications apart from .bashrc.

# Neat bash tricks, http://blog.sanctum.geek.nz/category/bash
# Some other tricks, http://www.tldp.org/LDP/abs/html/sample-bashrc.html
# List of BASH vals https://www.gnu.org/software/bash/manual/html_node/Bash-Variables.html

# When debugging bash, $LINENO refers to current line of script
# Also $RANDOM gives val from 0-32767, `shuf` command for ranges
# Note that `caller expr` builtin prints call stack, where expr is framenumber.
# Uses BASH_LINENO BASH_SOURCE & FUNCNAME arrays
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
export PATH=/usr/lib/ccache:$MYSCRIPTS:$SOFT/bin:$OPTDIR/bin:$JAVA_HOME/bin:$HASKELL_BIN:$PATH
export PATH=$GROOVY_HOME/bin:$GRADLE_HOME/bin:$ANDROID:$PATH
#export CPATH=$SOFT/libs/include:$CPATH
#export LIBRARY_PATH=$SOFT/libs/lib:$LIBRARY_PATH

#export PERL_MB_OPT="--install_base \"$HOME/perl5\""
#export PERL_MM_OPT="INSTALL_BASE=$HOME/perl5"

# Paths for specific tools.
export ANT_HOME=/usr/share/ant
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

# Ignore files with these suffixes for bash completion
# NB: For dirs like .bzr, bzr line will ignore anything ending in bzr.
export FIGNORE=bzr:git:hg:svn:.class:.o:.pyc

# Change grep color to bold blue
export GREP_COLORS='ms=01;34:mc=01;34:sl=:cx=:fn=35:ln=32:bn=32:se=36'

# Merge tool for hg
export HGMERGE=/usr/bin/kdiff3

# Bash history options
# Set large history file & line limit
export HISTFILESIZE=100000
export HISTSIZE=100000

# Ignore some commands
export HISTIGNORE='ls *:l *:bg:fg:history *'

# Timestamps in history file
export HISTTIMEFORMAT='%F %T '

# Ignore duplicate commands in history
export HISTCONTROL=ignoredups:erasedups

# The number of EOF to ignore before terminating shell
export IGNOREEOF=2

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

# Color code explanation, end of -> http://jamiedubs.com/ps1-collection-customize-your-bash-prompt
# Old code (might still see): \[\033[x;yy;zzm\]
# General format: \[\e[x;yy;zzm\]
# Style code x: 1 -> bold, 4 -> underline, 7 -> invert color.
# Color code, yy -> 30s for foreground, zz-> background in 40s.
count=1
for color in RED GREEN YELLOW BLUE MAGENTA CYAN WHITE; do
    eval "export T_$color='\e[0;3${count}m'"
    eval "export T_B$color='\e[1;3${count}m'"
    eval "export PS1_$color='\[\e[0;3${count}m\]'"
    eval "export PS1_B$color='\[\e[1;3${count}m\]'"
    (( count = $count + 1 ))
done
unset count

export T_RESET='\e[0m'
export PS1_R="\[\e[0m\]"
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
fi

# Default ack options, use smart case, sort output by file and follow symlinks.
# Filter by type with --type, supported types `ack --help-types`
if valid_name ack; then
    alias ack='ack --smart-case --sort-files --follow --color-match="bold blue"'
    # Alias for ack find file by name
    alias ackf='ack -g'
    # Alias for ack find file by contents
    alias ackl='ack -il'
fi

# Alias for silver search
# For type use --type, i.e. --cpp. supported types -> 'ag --list-file-types
if valid_name ag; then
    alias ag='ag --smart-case --follow --color-match="1;34"'
    # Alias for ag find file by name
    alias agf='ag -g'
    # Alias for ag find file by contents
    alias agl='ag -il'
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
    alias aptu='sudo apt-get update && sudo apt-get -y dist-upgrade && sudo apt-get autoremove'
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
#}}}
############################################################################
# Functions
############################################################################
#{{{
# Reruns the last command with sudo.
please() {
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
take() {
    local dir="$1"
    mkdir "$dir"
    cd "$dir"
}

# Toggles bash debug mode, when on:
#  * Turns on tracing of every command (xtrace).
#  * Prevents unsetting vars (nounset).
#  * Prints lines before execution (verbose).
#  * Disables bash prompt to avoid pollution with xtrace.
debug() {
    # If command is blank, turn off debug mode
    if [ "x" == "x${PROMPT_COMMAND}" ]; then
        #set +o nounset
        set +o extdebug
        set +o verbose
        set +o xtrace
        export PROMPT_COMMAND="$OLD_PROMPT_COMMAND"
        unset OLD_PROMPT_COMMAND
        export PS1="$OLD_PS1"
        unset OLD_PS1
        echo -e "Bash Debug Mode: ${T_BRED}DISABLED${T_RESET}"
    else
        OLD_PROMPT_COMMAND="$PROMPT_COMMAND"
        export PROMPT_COMMAND=""
        OLD_PS1="$PS1"
        export PS1="$PS1_BRED >>DEBUG<< $PS1_R$PS1"
        #set -o nounset
        set -o extdebug
        set -o verbose
        set -o xtrace
        echo -e "Bash Debug Mode: ${T_BGREEN}ENABLED${T_RESET}"
        echo -e "Careful with ${T_BRED}nounset${T_RESET} breaks some completion."
    fi
}

# Function to go back up when deep in directories.
# Example: .. 3 == cd ../../..
..() {
    if [ $1 -ge 0 2> /dev/null ]; then
        x=$1
    else
        x=1
    fi

    for (( i = 0; i < $x; i++ )); do
        cd ..
    done
}

# Repeat a command n times, example:
#   repeat 10 echo foo
repeat() {
    if [ "$#" -lt 3 ]; then
        echo "Repeat a command n times, example:
        repeat 10 echo foo"
        return 0
    fi

    local count="$1" i
    shift
    for i in $(seq 1 "$count"); do
        eval "$@"
    done
}

batCheck() {
    if valid_name upower; then
        upower -i /org/freedesktop/UPower/devices/battery_BAT0
    elif valid_name acpi; then
        acpi -i -b
    else
        echo 'Install acpi or upower commands.'
    fi
}

# Check if connection up at all by pinging google dns
conTest() {
    for url in "8.8.8.8" "8.8.4.4"; do
        ping -c 3 $url
    done
}

# Check if term supports 256 -> http://www.robmeerman.co.uk/unix/256colours
termColor() {
    curl http://www.robmeerman.co.uk/_media/unix/256colors2.pl > c.pl 2>/dev/null
    perl ./c.pl
    \rm c.pl
}

# Format a json file to be pretty
jsonFix() {
    for file ; do
        cat "$file" | python -m json.tool > "fix_$file"
    done
}

# Useful functions inspired by:
#http://www.tldp.org/LDP/abs/html/sample-bashrc.html
# Get info on all network interfaces
listNics() {
    local INTS=($(ifconfig -s | awk ' /^wlan.*|eth.*/ { print $1 }'))
    # Ample use of awk/sed for field extraction.
    for INT in ${INTS[@]} ; do
        local   MAC=$(ifconfig $INT | awk '/Waddr/ { print $5 } ')
        local    IP=$(ifconfig $INT | awk '/inet / { print $2 } ' | sed -e s/addr://)
        local BCAST=$(ifconfig $INT | awk '/inet / { print $3 } ' | sed -e s/Bcast://)
        local  MASK=$(ifconfig $INT | awk '/inet / { print $4 } ' | sed -e s/Mask://)
        local   IP6=$(ifconfig $INT | awk '/inet6/ { print $3 } ')

        echo -e "Interface: ${T_BGREEN}$INT${T_RESET}"
        echo -e "\tMac:   ${MAC}"
        echo -e "\tIPv4:  ${IP:-"Not connected"}"
        if [[ -n ${IP} ]]; then
            echo -e "\tBCast: ${BCAST}"
            echo -e "\tMask:  ${MASK}"
            echo -e "\tIPv6:  ${IP6:-"N/A."}"
        fi
    done
}

# Pretty print of df, like dfc.
prettyDf() {
    for fs ; do

        if [ ! -d $fs ]; then
            echo -e $fs" :No such file or directory"
            continue
        fi

        local info=( $(command df -P $fs | awk 'END{ print $2,$3,$5 }') )
        local free=( $(command df -Pkh $fs | awk 'END{ print $4 }') )
        local nbstars=$(( 20 * ${info[1]} / ${info[0]} ))
        local out="["
        for ((j=0;j<20;j++)); do
            if [ ${j} -lt ${nbstars} ]; then
               out=$out"*"
            else
               out=$out"-"
            fi
        done
        out=${info[2]}" "$out"] ("$free" free on "$fs")"
        echo -e $out
    done
}

# Get information on current system
ii() {
    local TOP=$(top -n 1 -o %CPU | sed '/^$/d' | head -n 12 | tail -n 11)
    echo
    echo -e "${T_BBLUE}$USER${T_RESET} is logged on ${T_BBLUE}$HOSTNAME${T_RESET}"
    echo -e "${T_BBLUE}Additionnal information :${T_RESET} " ; uname -a
    echo -e "${T_BBLUE}Users logged on :${T_RESET} " ;
        who | cut -d " " -f1 | sort | uniq
    echo -e "${T_BBLUE}Current date :${T_RESET} " ; date
    echo -e "${T_BBLUE}Machine stats :${T_RESET} " ; uptime
    echo -e "${T_BBLUE}Diskspace :${T_RESET} "
    if valid_name dfc; then
        dfc
    else
        local mounts=$(mount -v | awk '/\/dev\/s/ { print $3 }')
        prettyDf $mounts
    fi
    echo -e "${T_BBLUE}Memory stats :${T_RESET} " ; free -h
    echo -e "${T_BBLUE}Top 5 CPU% :${T_RESET} " ; echo -e "$TOP" | head -n 2 ; echo -e "$TOP" | tail -n 6
    echo -e "${T_BBLUE}Top 5 MEM% :${T_RESET} " ; top -n 1 -o %MEM | sed '/^$/d' | head -n 12 | tail -n 5
    echo -e "${T_BBLUE}Network Interfaces :${T_RESET}" ; listNics
    echo -e "${T_BBLUE}Open connections :${T_RESET} "; netstat -pan --inet;
    echo
}

# Highlight many terms with different colors
# Usage: find . | h term1 term2 term3
source ~/.shell/.hhighlighter/h.sh
#}}}
############################################################################
# Shell Settings
############################################################################
#{{{
# https://www.gnu.org/software/bash/manual/html_node/The-Set-Builtin.html
# Set debug flags permanently on
#set -o nounset
#set -o xtrace

# Brace expand allows: echo a{b,c}e -> abe ace
set -o braceexpand

# Bg jobs notify immediately on terminate, else only when next prompt draw
set -o notify

# http://www.gnu.org/software/bash/manual/html_node/The-Shopt-Builtin.html
# If arg to cd doesn't exist, must be var to expand
#shopt -s cdable_vars

# When making small typos with cd, go to best match
shopt -s cdspell

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# Multiline commands to be on single lines in history
shopt -s cmdhist

# Ensure extended globbing allowed
# http://www.linuxjournal.com/content/bash-extended-globbing
shopt -s extglob

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
shopt -s globstar

# Always append instead of overwriting history
shopt -s histappend

# Don't expand empty commands
shopt -s no_empty_cmd_completion

# Shell not needed for mail checking
shopt -u mailwarn
unset MAILCHECK
#}}}
############################################################################
# Misc Options
############################################################################
#{{{
# Enable the windows key on Ubuntu as F13
if valid_name xmodmap && [ -n "$DISPLAY" ]; then
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
# PS1 Bash Propmt
############################################################################
#{{{
# ALL PS1 past this point. This stuff used to modify the bash prompt to show
# the status of git and hg repos as well as move directory line up one.
# See Environment Variables for color code explanation

# I am modifying the PS1 prompt to give info for both git and hg vcs.
# This callback fetches the hg stuff to insert only if in hg repo, looks like bash-git-prompt message.
# HG Prompt: http://sjl.bitbucket.org/hg-prompt/
# Git Prompt: https://github.com/magicmonty/bash-git-prompt
prompt_callback() {
    local p_line="${PS1_BMAGENTA}{branch}${PS1_R}{ ${PS1_RED}↓{incoming|count}${PS1_R}}"
    p_line="${p_line}{${PS1_GREEN}↑{outgoing|count}${PS1_R}}|${PS1_YELLOW}{status}{update}${PS1_R}"
    local HG=$(hg prompt "[${p_line}]" 2>/dev/null)

    # Strip everything except where status to outgoing would be.
    local T=${HG##*|}
    T=${T%%]}

    # Insert check mark only if T doesn't contain other codes like status or update, see regexp.
    if [ "x${HG}" != "x" ] && [[ ! ${T} =~ [!?^↓↑] ]]; then
        HG="${HG%%]}${PS1_BGREEN}✔${PS1_R}]"
    fi

    # Print don't print extra space unless need to.
    if [ "x$HG" == "x" ]; then
        echo -e -n ""
    else
        echo -e -n " $HG"
    fi

    # Flush commands as written, helps when multiple terminals open from a user
    history -a
}

# See ~/.git-prompt-colors.sh for scheme
source ~/.shell/.bash-git-prompt/gitprompt.sh
#}}}
# vim:set ft=sh foldmethod=marker:
