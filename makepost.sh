#!/bin/bash -x
export LANG=C LC_ALL=C
set -ueo pipefail

"${0%/*}"/formatdata.sh "$@" |\
  grep -E '(ゲスト連載|休載|FIXME)$' |\
  sort --stable --field-separator=$'\t' --key=4,4 |\
  awk -F $'\t' '{print "* " $4 "\n  * " $3 "『" $2 "』";}'
