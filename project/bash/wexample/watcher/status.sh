#!/usr/bin/env bash

watcherStatus() {
  . ${WEX_WEXAMPLE_SITE_CONFIG}
  docker logs ${SITE_NAME}_watcher
}
