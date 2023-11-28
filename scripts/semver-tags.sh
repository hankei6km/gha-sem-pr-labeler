#!/bin/bash
set -e

# shellcheck disable=SC2046
LATEST="$(npm_config_yes=true npx semver $(git tag | grep -e '^v.*') | tail -n 1)"

MAJOR="$(semver get major "${LATEST}")"
MINOR="$(semver get major "${LATEST}").$(semver get major "${LATEST}")"

git tag -f "v${MAJOR}" -am "${LATEST}"
git tag -f "v${MINOR}" -am "${LATEST}"

echo "To update semantically versioned tags, execute the following:"
echo "git push -f origin v${MAJOR}"
echo "git push -f origin v${MINOR}"
