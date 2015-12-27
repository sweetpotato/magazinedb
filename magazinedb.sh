#!/bin/bash
export LANG=C LC_ALL=C
set -xue
set -o pipefail

source "$1"
[ -n "$URL" ]
[ -n "$PREFIX" ]
[ -x "${SCRIPT1[0]}" ]
[ -x "${SCRIPT2[0]}" ]

unset TMPFILE
TMPFILE=$(mktemp "/tmp/${0##*/}.tmp.XXXXXX")
function atexit() {
  [ -n "${TMPFILE}"  ] && rm -f "$TMPFILE"
}
trap atexit EXIT
trap 'trap - EXIT; atexit; exit -1' INT PIPE TERM

unset TIMESTAMP
TIMESTAMP=$(date '+%Y%m%dT%H%M%S')
function fetchpage() {
  mkdir -p raw
  ### 1) fetch page to save
  curl --fail "$URL" >"$TMPFILE"
  ### 2) extract main content then calculate checksum to check update
  local checksum=$("${SCRIPT1[@]}" <"$TMPFILE" | md5sum | cut -c 1-7)
  if [ 0 -eq $(find raw -name "$PREFIX-*-$checksum.html" | wc -l) ] ; then
    cp "$TMPFILE" "raw/$PREFIX-$TIMESTAMP-$checksum.html"
    echo "raw/$PREFIX-$TIMESTAMP-$checksum.html"
  else
    find raw -name "$PREFIX-*-$checksum.html" -print
  fi
}

htmlfile=$(fetchpage)

mkdir -p data
datafile="${htmlfile##*/}" # drop directories
datafile="data/${datafile%-*}.txt" # drop checksum and extension
if [ ! -f "$datafile" ] ; then
  "${SCRIPT2[@]}" <"$htmlfile" >"$datafile"
  [ 10 -lt $(wc -l <"$datafile") ]
fi
