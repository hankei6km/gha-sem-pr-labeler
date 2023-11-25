#!/bin/bash

# action.yml のチェック.
# actionlint できれうようになりそうなのでとりあえず "run" の中身だけチェックする.

set -e

YQ_BIN="${YQ_BIN:-yq}"

SAVE_IFS="${IFS}"

IFS=$'\0'
while read -r -d '' s; do
    shellcheck --shell bash - <<< "${s}"
done < <("${YQ_BIN}" .runs.steps[].run -0  < action.yml)

IFS="${SAVE_IFS}"