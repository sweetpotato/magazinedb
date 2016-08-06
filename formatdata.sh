#!/bin/bash
export LANG=C LC_ALL=C
set -xueo pipefail

[ -n "$1" ]
prefix="$1"
index="${2:-0}"

myvars="MyVars/$prefix.pm"
master="$prefix-master.tsv"

[ -f "$myvars" ]
[ -f "$master" ]

target=$(find data -mindepth 1 -maxdepth 1 -name "$prefix-*" | sort -r |\
         head -n "$((index+1))" | tail -n 1)

./canonicalize.pl "$myvars" "$master" <"$target"
