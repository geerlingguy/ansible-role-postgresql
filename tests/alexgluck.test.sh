#!/usr/bin/env bash

playbook="${playbook:-"test.yml"}"
role_dir="${role_dir:-$PWD}"
cleanup="${cleanup:-"false"}"

for OSTYPE in "$role_dir"/vars/* ; do
  OSLIST="$(grep -B1 -P '\s{2,}__postgresql_version' "$OSTYPE" | grep -P '\s{2,}[[:alpha:]]' | sed 's|_||g;s|redhat|centos|g' | cut -f1 -d ':' | xargs)"
  POSTGRES_VERSION_LIST="$(grep -A1000 '__default_postgres_vars' "$OSTYPE" | grep -P '\s{2,}__[[:digit:]]'  | sed 's|_||g' | cut -f1 -d ':' | xargs)"
  for OS in ${OSLIST}; do
    OS="$(grep -oP "$OS.*'" "$(dirname "$0")"/test.sh | cut -f1 -d "'")"
    if [[ "$OS" == '' ]]; then
      continue
    fi
    OS_PSQL_START_VERSION="$(grep -i "$OS" "$role_dir"/tasks/install_official_repo.yml |tail -c 5 | cut -f1 -d '+')"
    for POSTGRES_VERSION in ${POSTGRES_VERSION_LIST}; do
      if [[ "$(echo "(${POSTGRES_VERSION}*10)/1" | bc)" -lt "$(echo "(${OS_PSQL_START_VERSION}*10)/1" | bc)" ]]; then
        continue
      fi
      echo -e "- distro: $OS  postgresql_version: $POSTGRES_VERSION"
    done
  done
done
exit 0
