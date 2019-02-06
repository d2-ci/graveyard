#!/usr/bin/env bash

# start: shellharden
if test "$BASH" = "" || "$BASH" -uc "a=();true \"\${a[@]}\"" 2>/dev/null; then
    # Bash 4.4, Zsh
    set -euo pipefail
else
    # Bash 4.3 and older chokes on empty arrays with set -u.
    set -eo pipefail
fi
set -x # print all commands
shopt -s nullglob globstar
# end: shellharden

REPO_URL=$1
REPO_NAME=$(echo "${REPO_URL}" | sed -n "s/^.*dhis2\/\(.*\)\.git$/\1/p")

git clone "$REPO_URL" "tmp/${REPO_NAME}"
tar czfv "${REPO_NAME}.tgz" "tmp/${REPO_NAME}"
git add "${REPO_NAME}.tgz"
git commit -m "chore: archive repo ${REPO_NAME}"
