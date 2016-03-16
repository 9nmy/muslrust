#!/bin/bash
set -ex

docker_build() {
  local -r crate="$1"crate
  docker run \
    -v "$PWD/test/${crate}:/volume" \
    -w /volume \
    -t clux/muslrust \
    cargo build --verbose
  cd "test/${crate}"
  ./target/x86_64-unknown-linux-musl/debug/"${crate}"
  [[ "$(ldd target/x86_64-unknown-linux-musl/debug/${crate})" =~ "not a dynamic" ]] && \
    echo "${crate} is a static executable"
}

docker_build "$1"
