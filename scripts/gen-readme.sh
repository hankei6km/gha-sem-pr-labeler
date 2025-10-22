#!/bin/bash
set -e

cp scripts/README_template.md README.md
npx action-docs --no-banner  -u README.md
sed -i '/<!.\+>/d' README.md
