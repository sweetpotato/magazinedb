#!/bin/bash
export LANG=C LC_ALL=C
set -xueo pipefail

[ -n "$1" ]
prefix="$1"
index="${2:-0}"

find data -mindepth 1 -maxdepth 1 -name "$prefix-*" | sort -r |\
  head -n "$((index+2))" | tail -n 2 |\
  xargs -n 2 bash -c 'diff -u <(sort "$1") <(sort "$0")' |\
  grep -E '^[-+]' | grep -vE '^[-+]{3}'
