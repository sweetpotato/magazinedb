#!/bin/bash -x
export LANG=C LC_ALL=C
set -ueo pipefail

prefix="$1"
index="${2:-0}"

myvars="MyVars/$prefix.pm"
master="master/$prefix.tsv"
[ -f "$myvars" ]
[ -f "$master" ]

target=$(find data -mindepth 1 -maxdepth 1 -name "$prefix-*" | sort -r |\
         head -n "$((index+1))" | tail -n 1)

./canonicalize.pl "$myvars" "$master" <"$target"
