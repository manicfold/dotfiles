# login definitions for the bash

export LANG='en_US.utf8'
#export LANG='de_DE.utf8'
export USERNAME='Philipp Blanke'
export PATH=~/bin:$PATH
#export CVSROOT=":pserver:blanke@cvs.gdv.uni-hannover.de:/var/repos/intern"
# for openoffice with darkthemes:
#export SAL_USE_VCLPLUGIN=gen

# set up the editor for SVN
if [ -x /usr/bin/nano ]; then
  SVN_EDITOR="/usr/bin/nano";
elif [ -x /usr/bin/pico ]; then
  SVN_EDITOR="/usr/bin/pico";
else
  SVN_EDITOR="/usr/bin/vi";
fi
export SVN_EDITOR;

# Source local definitions
if [ -f $HOME/.bashrc ]; then
  . $HOME/.bashrc
fi

_byobu_sourced=1 . /usr/bin/byobu-launch
