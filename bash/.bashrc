# vim: set foldmarker={{{1,}}} foldlevel=0 foldmethod=marker syn=sh :
# -----------------------------------------------------------------------------
# Filename: .bashrc
# Modified: Tue 12 Jun 2018, 20:10
# -----------------------------------------------------------------------------

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# Globals -----------------------------------------------------------------{{{1
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
LANGUAGE=en_US.UTF-8

EDITOR="vim"
GPG_TTY="tty"
LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/usr/local/lib/"

AddPath() {
   found=false
   for i in $(echo $PATH | tr ':' ' '); do
      if [ "$1" == "$i" ]; then
         found=true
         break
      fi
   done

   if ! $found; then
      export PATH="$1:$PATH"
   fi
}

# set PATH so it includes user's private bin if it exists
[ -d "$HOME/bin" ] && AddPath "$HOME/bin"

for d in ${HOME}/.gem/ruby/*/bin; do
   AddPath "$d"
done

export LC_ALL LANG PATH LD_LIBRARY_PATH EDITOR GPG_TTY

# Completion --------------------------------------------------------------{{{1
[ -r /usr/share/bash-completion/bash_completion   ] && . /usr/share/bash-completion/bash_completion
# if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
#  . /etc/bash_completion
# fi

# Shell options -----------------------------------------------------------{{{1
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
shopt -s extglob      # Necessary for programmable completion
shopt -s direxpand    # expand variables containing directories
unset MAILCHECK

export TIMEFORMAT=$'\nreal %3R\tuser %3U\tsys %3S\tpcpu %P\n'
ulimit -S -c 0        # Don't want any coredumps

# History -----------------------------------------------------------------{{{1
shopt -s histappend histreedit histverify
# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=10000
HISTFILESIZE=20000
# don't put duplicate lines or lines starting with space in the history.
export HISTCONTROL=ignoreboth
export HISTIGNORE="&:bg:fg:ll:h"

# tailoring 'less' ---------------------------------------------------------{{{1
export LESSCHARSET='utf-8'
# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"
export XMLLINT_INDENT='   '
export PAGER=less
export LESS=" -RSMgIsw "
    # R - Raw color codes in output (don't remove color codes)
    # S - Don't wrap lines, just cut off too long text
    # M - Long prompts ("Line X of Y")
    # ~ - Don't show those weird ~ symbols on lines after EOF
    # g - Highlight results when searching with slash key (/)
    # I - Case insensitive search
    # s - Squeeze empty lines to one
    # w - Highlight first line after PgDn

# Python local environment setup (pyenv) -----------------------------------{{{1
export PATH="/home/philipp/.pyenv/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

# source other files -------------------------------------------------------{{{1
[ -f "$HOME/.config/nvim/bundle/gruvbox/gruvbox_256palette.sh" ] && source "$HOME/.config/nvim/bundle/gruvbox/gruvbox_256palette.sh"

[ -f ~/.bash_prompt ] && source ~/.bash_prompt

[ -f ~/.bash_aliases ] && source ~/.bash_aliases

[ -f "${HOME}/.bashrc.local" ] && source "${HOME}/.bashrc.local"

set -a # automatically export all sourced variables
[ -f $HOME/.config/user-dirs.dirs ] && source $HOME/.config/user-dirs.dirs
set +a

