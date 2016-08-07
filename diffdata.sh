#!/bin/bash
export LANG=C LC_ALL=C
set -xueo pipefail

prefix="$1"
index="${2:-0}"

targets=( $(find data -mindepth 1 -maxdepth 1 -name "$prefix-*" |\
            sort -r | head -n "$((index+2))" | tail -n 2) )

diff -u <(sort "${targets[1]}") <(sort "${targets[0]}") |\
  grep -E '^[-+]' | grep -vE '^[-+]{3}'
