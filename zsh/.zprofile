# login definitions for the bash

export LANG='en_US.utf8'
# this sets the default paper size to A4
export LC_PAPER="de_DE.UTF-8"

export USERNAME='Philipp Blanke'


# set up the editor for SVN
if [ -x /usr/bin/vim ]; then
  SVN_EDITOR="/usr/bin/vim";
elif [ -x /usr/bin/nano ]; then
  SVN_EDITOR="/usr/bin/nano";
fi
export SVN_EDITOR;

# set the default filemask
umask 022
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:~/workspace/lib
export QT_PLUGIN_PATH=$QT_PLUGIN_PATH:~/workspace/libQGLViewer

# LaTeX setup
# ( The trailing colon indicates the standard search
#   path should be appended to the user specified
#   TEXINPUT variable; Paths are ':' separated;
#   double trailing slash indicates this directory is
#   to be search recursively )
#   export TEXINPUTS=".:~/path/to/add//:"
export TEXINPUTS=".:~/texmf//:"

# OpenFOAM
#export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$HOME/OpenFOAM/lib
#if [ -z $ONCE ]; then
#    . $HOME/OpenFOAM/OpenFOAM-1.4.1/.OpenFOAM-1.4.1/bashrc
#    export ONCE=1
#fi

