#!/bin/bash
set -e

# exmaple:
# scripts/ver-tag.sh patch
# scripts/ver-tag.sh prelease pre

# shellcheck disable=SC2046
LATEST="$(npm_config_yes=true npx semver $(git tag | grep -e '^v.*') | tail -n 1)"

VERSION=$(npm_config_yes=true npx semver -i "${1}" --preid "${2}" "$LATEST")

git commit --allow-empty -m "${VERSION}"
git tag "v${VERSION}" -am "${VERSION}"

echo "Operations for release:"
echo "- git push --follow-tags origin"
echo "- Create a release in any desired way"
echo "- Execute scripts/semver-tags.sh"
