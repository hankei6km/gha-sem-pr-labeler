#!/bin/bash

set -e

echo  '- add "sem-pr: test" label to the PR by "test" type'
RES="$(\
  LABELS="test,sem-pr: fix" \
  REPO="rest-repo" \
  PR_NUM=1 \
  TYPE="test" \
  IS_BREAKING_CHANGE="false" \
  ./scripts/test_run.sh \
)"
diff <(echo "${RES}") \
<(echo -n '
pr view --json labels --jq .labels[].name -R rest-repo 1
pr edit --remove-label sem-pr: fix -R rest-repo 1
pr edit --add-label sem-pr: test -R rest-repo 1
')
echo '  passed'

echo  '- add "sem-pr: test" label to the PR by "test" type("sem-pr: test" label already exists)'
RES="$(\
  LABELS="test,sem-pr: test" \
  REPO="rest-repo" \
  PR_NUM=1 \
  TYPE="test" \
  IS_BREAKING_CHANGE="false" \
  ./scripts/test_run.sh \
)"
diff <(echo "${RES}") \
<(echo -n '
pr view --json labels --jq .labels[].name -R rest-repo 1
')
echo '  passed'

echo  '- add "sem-pr: feat" label to the PR by "feat" type(is breaking change is true)'
RES="$(\
  LABELS="test,sem-pr: fix" \
  REPO="rest-repo" \
  PR_NUM=1 \
  TYPE="test" \
  IS_BREAKING_CHANGE="true" \
  ./scripts/test_run.sh \
)"
diff <(echo "${RES}") \
<(echo -n '
pr view --json labels --jq .labels[].name -R rest-repo 1
pr edit --remove-label sem-pr: fix -R rest-repo 1
pr edit --add-label sem-pr: test -R rest-repo 1
pr edit --add-label sem-pr: breaking change -R rest-repo 1
')
echo '  passed'

echo  '- add "sem-pr: feat" label to the PR by "feat" type(is breaking change is true, breaking change label already exists)'
RES="$(\
  LABELS="test,sem-pr: fix,sem-pr: breaking change" \
  REPO="rest-repo" \
  PR_NUM=1 \
  TYPE="test" \
  IS_BREAKING_CHANGE="true" \
  ./scripts/test_run.sh \
)"
diff <(echo "${RES}") \
<(echo -n '
pr view --json labels --jq .labels[].name -R rest-repo 1
pr edit --remove-label sem-pr: fix -R rest-repo 1
pr edit --add-label sem-pr: test -R rest-repo 1
')
echo '  passed'

echo  '- add "sem-pr: feat" label to the PR by "feat" type(remove breaking change label)'
RES="$(\
  LABELS="test,sem-pr: fix,sem-pr: breaking change" \
  REPO="rest-repo" \
  PR_NUM=1 \
  TYPE="test" \
  IS_BREAKING_CHANGE="false" \
  ./scripts/test_run.sh \
)"
diff <(echo "${RES}") \
<(echo -n '
pr view --json labels --jq .labels[].name -R rest-repo 1
pr edit --remove-label sem-pr: fix -R rest-repo 1
pr edit --remove-label sem-pr: breaking change -R rest-repo 1
pr edit --add-label sem-pr: test -R rest-repo 1
')
echo '  passed'

echo  '- fail to add "sem-pr: foo" label to the PR by "foo" type'
RES="$(\
  LABELS="test,sem-pr: fix" \
  REPO="rest-repo" \
  PR_NUM=1 \
  TYPE="foo" \
  IS_BREAKING_CHANGE="true" \
  ./scripts/test_run.sh \
)"
# The breaking change label is not added, so add the "sem-pr: foo" label failed.
diff <(echo "${RES}") \
<(echo -n '
pr view --json labels --jq .labels[].name -R rest-repo 1
pr edit --remove-label sem-pr: fix -R rest-repo 1
pr edit --add-label sem-pr: foo -R rest-repo 1
')
echo '  passed'
