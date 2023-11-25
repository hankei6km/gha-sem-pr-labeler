#!/bin/bash

# ローカルでのチェック用.
# ワークフローでは使わない

set -e

echo "Linting action.yml"
source "$(dirname "${0}")/lint-action.sh"
echo "passed"

echo "Linting workfows"
actionlint
echo "passed"