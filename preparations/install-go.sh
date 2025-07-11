#!/usr/bin/env bash

set -e

install_golang() {
  local go_src target version latest_version

  # purge old src
  go_src="/usr/local/go"
  if [[ -d "${go_src}" ]]; then
    sudo rm -rf "${go_src}"
  fi

  latest_version="$(curl -sSL "https://golang.org/VERSION?m=text" | head -n 1)"
  set +u
  version="${GO_VERSION:-${latest_version}}"
  set -u
  target="https://dl.google.com/go/${version}.linux-amd64.tar.gz"

  curl -sSL "${target}" | sudo tar -v -C /usr/local -xz
}

install_golang