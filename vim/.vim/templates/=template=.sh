#! /bin/bash
#
#- %FFILE%
#- Copyright (C) Robert Bosch Car Multimedia GmbH
#- %USER% <%MAIL%>
#- Last Change: Wed 13 Apr 2016, 11:13

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
print_err() { echo "|ERR|" "$@"; }
print_ok()  { echo "|OK |" "$@"; }
print_inf() { echo "|INF|" "$@"; }

# -----------------------------------------------------------------------------

while (( "$#" )); do
   case $1 in
      -v|--version) version; exit 0 ;;
      -h|--help) usage; exit 0 ;;
      *) usage; exit 1 ;;
   esac
   shift
done


%HERE%
