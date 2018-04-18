#!/usr/bin/env bash

siteInfoArgs() {
  _ARGUMENTS=(
    [0]='no_recreate nr "No recreate if files exists" false'
  )
}

siteInfo() {
  wex config/load

  . .env

  echo ""
  echo -e "  Machine name : \t "${SITE_NAME}
  echo -e "  Started : \t\t "$(wex site/started)
  echo -e "  Services : \t\t "$(wex site/config -k=services)
  echo -e "  Framework : \t\t "$(wex framework/detect -d="project")
  echo -e "  Environment : \t "${SITE_ENV}
  echo -e "  Domains : \t\t "$(wex site/domains)
  echo ""

  wex framework/settings

  if [ ! -z ${SITE_DB_HOST+x} ]; then
    echo -e "  DB name : \t\t "${SITE_DB_HOST}
    echo -e "  DB host : \t\t "${SITE_DB_NAME}
    echo -e "  DB user : \t\t "${SITE_DB_USER}
    echo -e "  DB password : \t "${SITE_DB_PASSWORD}
    echo ""
  fi;

  echo "  Local hosts names :"
  echo $(cat ${WEX_WEXAMPLE_DIR_PROXY_TMP}hosts)
  echo ""

}
