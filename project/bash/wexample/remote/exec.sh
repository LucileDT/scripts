#!/usr/bin/env bash

remoteExecArgs() {
  _ARGUMENTS=(
    [0]='ssh_user_custom u "SSH User" false'
    [1]='ssh_private_key_custom k "SSH Private key" false'
    [2]='ssh_host_custom h "Host to connect to" false'
    [3]='ssh_port_custom p "SSH Port" false'
    [4]='environment e "Environment to connect to" true'
    [5]='shell_script s "Command to execute from shell, relative to site directory" true'
    [6]='dir d "Remote directory (site directory by default)" false'
    [7]='quiet q "Quiet mode" false'
  )
}

remoteExec() {
  # Prevent to set credentials globally
  local SSH_CONNEXION=$(wex remote/connexion -e=${ENVIRONMENT} ${WEX_ARGUMENTS})

  if [ "${DIR}" != "" ];then
    local SITE_PATH_ROOT=${DIR}
  else
    . .wex
    local SITE_PATH_ROOT=${WEX_WEXAMPLE_DIR_SITES_DEFAULT}${NAME}/
  fi

  # Allow quiet mode
  if [ "${QUIET}" == true ];then
    QUIET=-oLogLevel=QUIET
  fi

  ssh ${QUIET} ${SSH_CONNEXION} "cd ${SITE_PATH_ROOT} && ${SHELL_SCRIPT}"
}
