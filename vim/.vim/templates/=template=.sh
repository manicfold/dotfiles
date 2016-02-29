#! /bin/bash
#
#- %FFILE%
#- Copyright (C) Robert Bosch Car Multimedia GmbH
#- %USER% <%MAIL%>
#- Last Change: Thu 04 Feb 2016, 10:46

## 
## USAGE: %FFILE%  
##        

usage=$(grep "^## " "${BASH_SOURCE[0]}" | cut -c 4-)
version=$(grep "^#- "  "${BASH_SOURCE[0]}" | cut -c 4-)

usage() {  echo "$usage"; }
version() { echo "$version"; }

while (( "$#" )); do
   case $1 in
      -v|--version) version; exit 0 ;;
      -h|--help) usage; exit 0 ;;
      *) usage; exit 1 ;;
   esac
   shift
done

err="\e[37;1;41m  KO  \e[0m"
ok="\e[37;1;42m  OK  \e[0m"
inf="\e[37;1;43m INFO \e[0m"

# -----------------------------------------------------------------------------


%HERE%
