# -----------------------------------------------------------------------------
# $HOME/.bashrc
# Modified: So 25 Okt 2015, 21:32
# -----------------------------------------------------------------------------

# set the default filemask
umask 022

# LaTeX setup
# ( The trailing colon indicates the standard search
#   path should be appended to the user specified
#   TEXINPUT variable; Paths are ':' separated;
#   double trailing slash indicates this directory is
#   to be search recursively )
#   export TEXINPUTS=".:~/path/to/add//:"
export TEXINPUTS=".:~/texmf//:"

# FOAM setup
#ONCE=0
#if [ $ONCE -eq 0 ]; then
#    . $HOME/OpenFOAM/OpenFOAM-1.4.1/.OpenFOAM-1.4.1/bashrc
#fi

EDITOR="vim"
GPG_TTY="tty"
LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/usr/local/lib/"

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

if [ -d "${HOME}/.gem/ruby/1.9.1/bin" ] ; then
   PATH="${HOME}/.gem/ruby/1.9.1/bin:${PATH}"
fi

export PATH LD_LIBRARY_PATH EDITOR GPG_TTY

# ------------------------------------------------------------------ Completion
if [ -f /etc/bash_completion ]; then
 . /etc/bash_completion
fi

# --------------------------------------------------------------- Shell options
ulimit -S -c 0        # Don't want any coredumps
#set -o notify
#set -o noclobber
#set -o ignoreeof
#set -o nounset
#set -o xtrace        # Useful for debuging

# Enable options:
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

# Disable options:
#shopt -u mailwarn
# I don't want my shell to warn me of incoming mail
unset MAILCHECK

export TIMEFORMAT=$'\nreal %3R\tuser %3U\tsys %3S\tpcpu %P\n'
export HISTIGNORE="&:bg:fg:ll:h"

# ---------------------------------------------------------------- Color Prompt
function _update_ps1() {
   if [ -f ~/bin/powerline-shell.py ]; then
      PS1="$(~/bin/powerline-shell.py $? 2> /dev/null)"
   else
      echo "Powershell missing."
      PS1='\u@\h:\w\$ '
   fi
}

if [ "$TERM" != "linux" ]; then
   PROMPT_COMMAND="_update_ps1; $PROMPT_COMMAND"
elif [ -f ~/.bash_prompt ]; then
    . ~/.bash_prompt
fi

# ---------------------------------------------------------------- Base16 Shell
BASE16_SHELL="$HOME/.config/base16-shell/base16-eighties.dark.sh"
[[ -s $BASE16_SHELL ]] && source $BASE16_SHELL

# ------------------------------------------------------------Alias definitions
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# tailoring 'less'
export PAGER=less
export LESSCHARSET='utf-8'
# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"
#export LESSOPEN='|/usr/bin/lesspipe.sh %s 2>&-'
# Use this if lesspipe.sh exists.
#export LESS='-i -w  -z-4 -g -e -M -X -F -R -P%t?f%f \
#:stdin .?pb%pb\%:?lbLine %lb:?bbByte %bb:-...'

# ------------------------------------------------------------------- Functions
# Files & strings ------------------------------------------------------------

# Find a file with a pattern in name:
function ff()
{ find . -type f -iname '*'$*'*' -ls ; }

# Find a file with pattern $1 in name and Execute $2 on it:
function fe()
{ find . -type f -iname '*'$1'*' -exec "${2:-file}" {} \;  ; }

# find pattern in a set of files and highlight them:
function fstr()
{
    OPTIND=1
    local case=""
    local usage="fstr: find string in files.
Usage: fstr [-i] \"pattern\" [\"filename pattern\"] "
    while getopts :it opt
    do
        case "$opt" in
        i) case="-i " ;;
        *) echo "$usage"; return;;
        esac
    done
    shift $(( $OPTIND - 1 ))
    if [ "$#" -lt 1 ]; then
        echo "$usage"
        return;
    fi
    local SMSO=$(tput smso)
    local RMSO=$(tput rmso)
    find . -type f -name "${2:-*}" -print0 |
    xargs -0 grep -sn ${case} "$1" 2>&- | \
    sed "s/$1/${SMSO}\0${RMSO}/gI" | more
}

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


# Process/system --------------------------------------------------------------

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

