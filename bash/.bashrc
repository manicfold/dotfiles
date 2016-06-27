# vim: set foldmarker={{{,}}} foldlevel=0 foldmethod=marker syn=sh :
# -----------------------------------------------------------------------------
# Filename: .bashrc
# Modified: Fri 10 Jun 2016, 15:27
# -----------------------------------------------------------------------------

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# Globals -----------------------------------------------------------------{{{
# set the default filemask
umask 022

# disable Ctrl-S on the TTY which produces XOFF, after which the TTY does not
# accept keystrokes anymore until Ctrl-Q (XON) is pressed.
stty -ixon

# LaTeX setup
# ( The trailing colon indicates the standard search
#   path should be appended to the user specified
#   TEXINPUT variable; Paths are ':' separated;
#   double trailing slash indicates this directory is
#   to be search recursively )
export TEXINPUTS=".:~/texmf//:"

LC_ALL=en_US.UTF-8
LANG=en_US.UTF-8

EDITOR="vim"
GPG_TTY="tty"
LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/usr/local/lib/"

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

if [ -d "${HOME}/.gem/ruby/*/bin" ] ; then
   PATH="${HOME}/.gem/ruby/*/bin:${PATH}"
fi

PATH="${HOME}/cov-analysis-linux-8.0.0/bin:${PATH}"

export LC_ALL LANG PATH LD_LIBRARY_PATH EDITOR GPG_TTY
# }}}
# Completion --------------------------------------------------------------{{{
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
 . /etc/bash_completion
fi
# }}}
# Shell options -----------------------------------------------------------{{{
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

export TIMEFORMAT=$'\nreal %3R\tuser %3U\tsys %3S\tpcpu %P\n'

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=10000
HISTFILESIZE=20000
# don't put duplicate lines or lines starting with space in the history.
export HISTCONTROL=ignoreboth

export HISTIGNORE="&:bg:fg:ll:h"
# }}}
# tailoring 'less' ---------------------------------------------------------{{{
export PAGER=less
export LESSCHARSET='utf-8'
# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"
export LESSOPEN="| /usr/share/source-highlight/src-hilite-lesspipe.sh %s"
export LESS=' -R '
export XMLLINT_INDENT='   '

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
BASE16_SHELL="$HOME/.config/base16-shell/base16-papercolor.dark.sh"
[[ -s $BASE16_SHELL ]] && source $BASE16_SHELL

#if [ "$TERM" != "linux" ]; then
#   GIT_PROMPT_FETCH_REMOTE_STATUS=0
#   GIT_PROMPT_STATUS_COMMAND=gitstatus.sh
#   GIT_PROMPT_THEME_NAME="Custom"
#   source ~/.bash-git-prompt/gitprompt.sh
if [ -f ~/.bash_prompt ]; then
    source ~/.bash_prompt
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
