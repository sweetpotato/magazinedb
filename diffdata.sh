#!/bin/bash
export LANG=C LC_ALL=C
set -xue
set -o pipefail

[ -n "$1" ]

find data -name "$1-*" | sort -r | head -n 2 |\
  xargs -n 2 bash -c 'diff -u <(sort "$1") <(sort "$0")' |\
  grep -E '^[-+]' | grep -vE '^[-+]{3}'
