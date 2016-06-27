# -----------------------------------------------------------------------------
# $HOME/.bash_aliases
# Modified: Fri 10 Jun 2016, 11:27
# -----------------------------------------------------------------------------

alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

# -> Prevents accidentally clobbering files.
alias mkdir='mkdir -p'

alias h='history'
alias j='jobs -l'
alias r='rlogin'
alias which='type -all'
alias ..='cd ..'
alias path='echo -e ${PATH//:/\\n}'
alias du='du -kh'
alias df='df -kTh'

# nice process view
alias psc='ps xawf -eo pid,user,cgroup,args'

# The 'ls' family (this assumes you use the GNU ls)
if [ -x /usr/bin/dircolors ]; then
   test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
   alias ls='ls -hF --color=auto'  # add colors for filetype recognition
   alias dir='dir --color=auto'
   alias vdir='vdir --color=auto'

   alias grep='grep --color=auto'
   alias fgrep='fgrep --color=auto'
   alias egrep='egrep --color=auto'
fi
alias ll='ls -l'
alias la='ls -Al'               # show hidden files
alias lx='ls -lXB'              # sort by extension
alias lk='ls -lSr'              # sort by size
alias lc='ls -lcr'		        # sort by change time  
alias lu='ls -lur'		        # sort by access time   
alias lt='ls -ltr'              # sort by date
alias lm='ls -al |more'         # pipe through 'more'

alias more='less'

alias top='xtitle Processes on $HOST && top'
alias make='xtitle Making $(basename $PWD) ; make'

alias cls='printf "\033c"'
alias hex='printf "%X\n" '

alias tmux='tmux -2 '
alias _setenv='. ~/bin/set_env.sh'

# alert via osd-notify
# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert_helper='history | tail -n1 | sed -e "s/^\s*[0-9]\+\s*//" -e "s/;\s*alert$//"'
alias alert='notify-send -i ~/.icons/elementary-xfce/apps/48/gnome-terminal.svg "Finished $(alert_helper)" "[`[ $? == 0 ] && echo Success || echo Failed`]"'

gvim () {
   if pgrep gvim ; then 
      command gvim --remote-silent "$@"
   else
      command gvim "$@"
   fi
}
alias perl_cli="rlwrap perl -d -e 1"
