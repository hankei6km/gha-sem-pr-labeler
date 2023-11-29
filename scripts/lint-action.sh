#!/bin/bash

# action.yml のチェック.
# actionlint できれうようになりそうなのでとりあえず "run" の中身だけチェックする.

set -e

SAVE_IFS="${IFS}"

IFS=$'\0'
while read -r -d '' s; do
    shellcheck --shell bash - <<< "${s}"
done < <(yq .runs.steps[].run -0  < action.yml)

IFS="${SAVE_IFS}"