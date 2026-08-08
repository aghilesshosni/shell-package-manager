#!/bin/bash

#    &> is used to redirect errors and non error logs to same destination

if ! command -v dpkg-query &> /dev/bull ;then
  echo "[ERROR] dpkg-query is not installed, are you on a Debian Based distribution ?"
  exit 1
fi


#    Help menu should show all available functions
#    printf command prints multiline message
#    exit_code is used if no argument is passed

usage(){
  printf '%s\n' \
  " Usage: ${0} info|install|remove|create|help ARGS" \
  "" \
  " - info : show information of a given package" \
  " - install : install a given package" \
  " - remove : remove a given package" \
  " - crete : create a .deb package from a given directory" \
  " - help : show this help"


  local exit_code="$([ ${1} != 1] && echo 0 || echo 1)"
  exit "${exit_code}"

}   


#    controlling the number of arguments
#    number of arguments could be 1 or 2
#    only one argument (help) or action and package name thus 2

if [ $# -eq 1 ]; then
  [ "${1}" != "help" && usage 1 || usage 0
elif [ $# -ne 2 ]; then
  usage 1
fi

#    storing the passed arguments to an ACTION and a VARIABLE

ACTION= "${1}"
ARGUMENT= "${2}"

#    Function definitions for actions

do_create(){
  echo "[DEBUG] Creating a package for : ${1}"
}

do_install(){
  echo "[DEBUG] Installing package : ${1}"
}
do_remove(){
  echo "[DEBUG] Installing package : ${1}"
}
do_info(){
  echo "[DEBUG] Showing info about package : ${1}"
}


#    Mapping arguments to functions
#    We use here Bash associative array
#    do_action  calls required action
declare -A ACTIONS=(
  [info]=do_info
  [install]=do_install
  [remove]=do_remove
  [create]=do_create
)
do_action "${ACTION}" "${ARGUMENT}"


