#! /bin/bash
#
#- %FFILE%
#- Copyright (C) Robert Bosch Car Multimedia GmbH
#- %USER% <%MAIL%>
#- Last Change: Tue 08 Mar 2016, 09:51

## 
## USAGE: %FFILE%  
##        

set -o errexit    # exit if a command fails
set -o nounset    # exit if variable is not declared
set -o pipefail   # return exit code of last failed command in pipe
#set -o xtrace     # debug traces on

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

print_err() { echo -e "\e[37;1;41m ERR \e[0m" "$1"; }
print_ok()  { echo -e "\e[37;1;42m OK  \e[0m" "$1"; }
print_inf() { echo -e "\e[37;1;43m INF \e[0m" "$1"; }

# -----------------------------------------------------------------------------


%HERE%
