#!/bin/bash
set -e

INSERT='<!-- INSERT -->'
npm_config_yes=true sed "/${INSERT}/r "<(npx action-docs --no-banner | sed 1,3d)  scripts/README_template.md \
  > README.md