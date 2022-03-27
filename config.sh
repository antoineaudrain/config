#!/bin/bash
# config.sh

p_flag=
s_flag=
w_flag=

print_usage() {
  printf "Usage: ...\n"
}

install_packages() {
  echo "Installing packages..."
  sh ./packages.sh
}

configure_shell() {
  echo "Configuring shell..."
  sh ./shell.sh
}

configure_workspace() {
  echo "Creating workspace..."
  sh ./workspace.sh
}

while getopts 'psw' flag; do
  case $flag in
    p) p_flag=1 ;;
    s) s_flag=1 ;;
    w) w_flag=1 ;;
    *) print_usage
       exit 1 ;;
  esac
done

if [ -z "$p_flag" ] && [ -z "$s_flag" ] && [ -z "$w_flag" ]
then
     ./scripts/install_packages
     ./scripts/configure_shell
     ./scripts/configure_workspace
     exit 0
fi

[ -n "$p_flag" ] && ./scripts/install_packages
[ -n "$s_flag" ] && ./scripts/configure_shell
[ -n "$w_flag" ] && ./scripts/configure_workspace

exit 0