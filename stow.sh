#!/bin/bash

display_help() {
   echo "Usage: [re|un]stow.sh <package1> [<package2> <package3> ...]"
   echo "    stow.sh:   creates symlinks to dotfiles for specified programs"
   echo "    unstow.sh: removes symlinks"
   echo "    restow.sh: removes and then re-creates symlinks"
   echo
   echo "    Stow determines what directories the symlinks go in"
   echo "    by parsing the file \"index\""
}

STOW_EXE=

setup() {
    STOW_EXE=$(type -p stow)
    if [ $? -eq 1 ]
    then
        echo "Missing stow executable. Trying to install."
        if ! sudo apt install stow
        then
            echo "Can't install. Exit"
            exit 1
        fi
    fi
}

main() {
   mode=s
   flag=""

   case "$1" in
      -h|--help) display_help; return 1
         ;;
      "")        display_help; return 1
         ;;
   esac
   case "$0" in
      *restow*) flag="--restow"; mode=r
         ;;
      *unstow*) flag="--delete"; mode=u
         ;;
      *stow*)   flag="";         mode=s
         ;;
      *)        echo "Error!"; return 1
         ;;
   esac

   for package in $@; do
      if [ -d "$package" ]; then
         array=( `grep "^$package:" index` )

         if [ -z "$array" ]; then
            echo "Error: \"$package\" not found in index"
            return 1
         fi

         dir=${array[1]/#\~/$HOME}

         if [ ! -x $dir  -a  "$mode" == "s" ]; then
            echo "Creating directory: $dir";
            eval "mkdir -p $dir";
         fi

         $STOW_EXE --verbose=1 -t $dir $flag $package
      else
         echo "Error: directory \"$package\" not found"
         return 1
      fi
   done
}

setup
main "$@"
