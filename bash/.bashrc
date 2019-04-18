# vim: set foldmarker={{{,}}} foldlevel=0 foldmethod=marker syn=sh :
# -----------------------------------------------------------------------------
# Filename: .bashrc
# Modified: Mon 25 Mar 2019, 10:29
# -----------------------------------------------------------------------------

# directly exit, if we are not on an interactive shell
[[ $- == *i* ]] || return

# disable Ctrl-S on the TTY which produces XOFF, after which the TTY does not
# accept keystrokes anymore until Ctrl-Q (XON) is pressed.
stty -ixon

umask 022
# HOST=$(hostname)

LC_ALL=en_US.UTF-8
LANG=en_US.UTF-8
EDITOR="vim"
GPG_TTY="tty"
LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/usr/lib:/usr/local/lib:/usr/lib/x86_64-linux-gnu"

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

if [ -d "${HOME}/.gem/ruby/*/bin" ] ; then
    PATH="${HOME}/.gem/ruby/*/bin:${PATH}"
fi

export HOST LC_ALL LANG LD_LIBRARY_PATH EDITOR GPG_TTY PATH

# LaTeX setup --------------------------------------------------------------{{{
# The trailing colon indicates the standard search
# path should be appended to the user specified
# TEXINPUT variable; Paths are ':' separated;
# double trailing slash indicates this directory is
# to be search recursively
export TEXINPUTS=".:~/texmf//:"
# }}}
# tailoring 'less' ---------------------------------------------------------{{{
# 'screen' termcap uses italics as standout (highlight). we want inverse colors.
export LESS_TERMCAP_so=$'\E[30;43m'
export LESS_TERMCAP_se=$'\E[39;49m'
export LESSCHARSET='utf-8'
# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"
export LESS=" -RSMgIsw~ "
# R - Raw color codes in output (don't remove color codes)
# S - Don't wrap lines, just cut off too long text
# M - Long prompts ("Line X of Y")
# ~ - Don't show those weird ~ symbols on lines after EOF
# g - Highlight results when searching with slash key (/)
# I - Case insensitive search
# s - Squeeze empty lines to one
# w - Highlight first line after PgDn
export PAGER=less
# }}}
# Completion --------------------------------------------------------------{{{
# if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
#  . /etc/bash_completion
# fi
# }}}
# Shell options -----------------------------------------------------------{{{
export TIMEFORMAT=$'\nreal %3R\tuser %3U\tsys %3S\tpcpu %P\n'

#set -o notify
#set -o noclobber
#set -o ignoreeof
#set -o nounset
#set -o xtrace        # Useful for debuging
#shopt -u mailwarn
#shopt -s cdspell
#shopt -s cdable_vars
#shopt -s checkhash
shopt -s checkwinsize
#shopt -s mailwarn
#shopt -s sourcepath
#shopt -s no_empty_cmd_completion  # bash>=2.04 only
#shopt -s cmdhist
shopt -s histappend histreedit histverify
shopt -s extglob      # Necessary for programmable completion
shopt -s direxpand    # expand variables containing directories
ulimit -S -c 0        # Don't want any coredumps
# Disable options:
unset MAILCHECK
# }}}
# History ----------------------------------------------------------------- {{{
# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=10000
HISTFILESIZE=20000
# don't put duplicate lines or lines starting with space in the history.
export HISTCONTROL=ignoreboth
export HISTIGNORE="&:bg:fg:ll:h"
export HISTTIMEFORMAT="%F %T  "

# function for persistent history, taken from
# http://eli.thegreenplace.net/2013/06/11/keeping-persistent-history-in-bash
# this is called in the bash prompt command. see bash_prompt file
log_bash_persistent_history()
{
    local rc=$?
    [[ $(history 1) =~ ^\ *[0-9]+\ +([^\ ]+\ [^\ ]+)\ +(.*)$ ]]
    local date_part="${BASH_REMATCH[1]}"
    local command_part="${BASH_REMATCH[2]}"
    if [ "$command_part" != "$PERSISTENT_HISTORY_LAST" ]
    then
        echo $date_part "|" "$command_part" >> ~/.persistent_history
        export PERSISTENT_HISTORY_LAST="$command_part"
    fi
}

phgrep()
{
   grep --color "$(printf ' %s' $@)" ~/.persistent_history
}

# }}}
# Functions --------------------------------------------------------------- {{{
# Find a file with a pattern in name:
function ff()
{ find . -type f -iname '*'$*'*' -ls ; }

# Find a file with pattern $1 in name and Execute $2 on it:
function fe()
{ find . -type f -iname '*'$1'*' -exec "${2:-file}" {} \;  ; }

# move filenames to lowercase
function lowercase()
{
    for file ; do
        filename=${file##*/}
        case "$filename" in
            */*) dirname==${file%/*} ;;
            *) dirname=.;;
        esac
        nf=$(echo $filename | tr A-Z a-z)
        newname="${dirname}/${nf}"
        if [ "$nf" != "$filename" ]; then
            mv "$file" "$newname"
            echo "lowercase: $file --> $newname"
        else
            echo "lowercase: $file not changed."
        fi
    done
}

# move filenames to uppercase
function uppercase()
{
    for file ; do
        filename=${file##*/}
        case "$filename" in
            */*) dirname==${file%/*} ;;
            *) dirname=.;;
        esac
        nf=$(echo $filename | tr a-z A-Z)
        newname="${dirname}/${nf}"
        if [ "$nf" != "$filename" ]; then
            mv "$file" "$newname"
            echo "uppercase: $file --> $newname"
        else
            echo "uppercase: $file not changed."
        fi
    done
}

# swap 2 filenames around
function swap()
{
    local TMPFILE=tmp.$$
    mv "$1" $TMPFILE
    mv "$2" "$1"
    mv $TMPFILE "$2"
}

function bkup()
{
    local orig="${1}.orig"
    if [ -e "$orig" ]; then
        echo "Backup file already exists: $orig"
        return 1
    fi
    if [ ! -e "$1" ]; then
        echo "No such file: $1"
        return 1
    fi
    if [ -d "$1" ]; then
        echo "Can only backup files."
        return 1
    fi
    cp "$1" "$orig"
}

# }}}
# Process/system ----------------------------------------------------------{{{
function my_ps()
{ ps $@ -u $USER -o pid,%cpu,%mem,bsdtime,command ; }

function pp()
{ my_ps f | awk '!/awk/ && $0~var' var=${1:-".*"} ; }


function ii()   # get current host related info
{
    echo -e "\nYou are logged on ${RED}$HOST"
    echo -e "\nAdditional information:$NC " ; uname -a
    echo -e "\n${RED}Users logged on:$NC " ; w -h
    echo -e "\n${RED}Current date :$NC " ; date
    echo -e "\n${RED}Machine stats :$NC " ; uptime
    echo -e "\n${RED}Memory stats :$NC " ; free
    echo
}

function xtitle ()
{
    case "$TERM" in
        *term | rxvt)
            echo -n -e "\033]0;$*\007" ;;
        *)
        ;;
    esac
}
# }}}
# Colors +  Prompt----------------------------------------------------------{{{
# BASE16_SHELL="$HOME/.config/base16-shell/base16-papercolor.dark.sh"
# [[ -s $BASE16_SHELL ]] && source $BASE16_SHELL
# gruvbox colors
if [ -f $HOME/.bash_palette.sh ]; then
    source "$HOME/.bash_palette.sh"
fi

CBlack="\e[30m"
CBlue="\e[0;34m"
CGreen="\e[0;32m"
CCyan="\e[0;36m"
CRed="\e[0;31m"
CPurple="\e[0;35m"
# COrange="\e[0;33m"
# CGray="\e[1;30m"
#
# BoldGray="\e[0;37m"
# BoldBlue="\e[1;34m"
# BoldGray="\e[1;32m"
# BoldCyan="\e[1;36m"
# BoldRed="\e[1;31m"
# BoldPurple="\e[1;35m"
# BoldOrange="\e[1;33m"
CBoldWhite="\e[1;37m"
#
# BgBlack="\e[40m"
# BgRed="\e[41m"
# BgGreen="\e[42m"
CBgOrange="\e[43m"
# BgBlue="\e[44m"
# BgPurple="\e[45m"
# BgCyan="\e[46m"
# BgWhite="\e[47m"
#
# Underscore="\e[4m"
# Blink="\e[5m"
# Invert="\e[7m"
# Hidden="\e[8m"

# reset to teminal default
CDefault="\e[0m"
# }}}
# Prompt -------------------------------------------------------------------{{{

function exitCode
{
    local rc=$?

    if [[ $rc == 0 ]]; then
        echo -e "${CGreen}$rc${CDefault}"
    else
        echo -e "${CRed}$rc${CDefault}"
    fi
}

function projectName
{
    [ -n "${_SOFTWARE_VERSION}" ] && echo -e " ${CBoldWhite}${_SOFTWARE_VERSION}${CDefault}"
}

function myprompt()
{
    local GitBranch="" HostName=""
    if declare -F __git_ps1 &> /dev/null; then
        # GIT_PS1_SHOWDIRTYSTATE=true
        # GIT_PS1_SHOWUNTRACKEDFILES=true
        GitBranch="${CCyan}\$(__git_ps1)${CDefault}"
    fi
    if [[ $SESSION_TYPE == "remote/ssh" ]]; then
        HostName="${CBgOrange}${CBlack}$(hostname)${CDefault}:"
    fi
    # PS1="\$(exitCode)${CDefault}${CPurple} ${HostName}${CDefault}\$(shortPWD)${GitBranch}${CDefault}\n> "
    PROMPT_DIRTRIM=3
    PS1="\$(exitCode)${CPurple} ${HostName}${CDefault}\w${GitBranch}\$(projectName)\n> "
    PS2=""
}

myprompt

if [[ "$PROMPT_COMMAND" != *"log_bash_persistent_history"* ]]; then
    PROMPT_COMMAND="log_bash_persistent_history; $PROMPT_COMMAND"
fi

# }}}
# Alias definitions --------------------------------------------------------{{{
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi
# }}}
# Local definitions ------------------------------------------------------{{{
if [ -f "${HOME}/.bashrc.local" ]; then
    source "${HOME}/.bashrc.local"
fi
# }}}
