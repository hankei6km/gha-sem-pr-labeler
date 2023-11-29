#!/bin/bash

set -e

TEMP_DIR=$(mktemp -d)
trap 'rm -rf "${TEMP_DIR}"' EXIT

SCRIPT_SOURCE_FILE="${TEMP_DIR}/script.sh"
export SAVE_CALLED="${TEMP_DIR}/called"
echo "" > "${SAVE_CALLED}"

function gh {
    echo "${@}" >> "${SAVE_CALLED}"
    if test "${2}" = "view"; then
        echo "${LABELS}" | sed -e 's/,/\n/g'
    elif test "${2}" = "edit" && test "${3}" = "--add-label" ; then
        if test "${4}" = "sem-pr: foo"; then
            return 1
        fi
    fi
}
command -V gh | tail -n+2 > "${SCRIPT_SOURCE_FILE}"

echo "set -e" >> "${SCRIPT_SOURCE_FILE}"

yq '.runs.steps[0].run' < action.yml >> "${SCRIPT_SOURCE_FILE}"

export LABEL_PREFIX="${LABEL_PREFIX:-sem-pr: }"

bash "${SCRIPT_SOURCE_FILE}" || true

echo "" >> "${SAVE_CALLED}"

cat "${SAVE_CALLED}"