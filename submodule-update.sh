#!/bin/bash
#
# Redirects git submodules to gitee mirrors and updates these recursively.
#
# To revert the changed URLs use 'git submodule deinit .'
#

# -----------------------------------------------------------------------------
# Common bash

if [[ ! -z ${DEBUG_SHELL} ]]
then
  set -x # Activate the expand mode if DEBUG is anything but empty.
fi

set -o errexit # Exit if command failed.
set -o pipefail # Exit if pipe failed.
set -o nounset # Exit if variable not set.

die() {
    echo "${1:-"Unknown Error"}" 1>&2
    exit 1
}

# -----------------------------------------------------------------------------

ERR_CANNOT_UPDATE=13

REPO_DIR=${1:-"${PWD}"}
REPO_DIR=$(cd ${REPO_DIR} && pwd -P)

SCRIPT_SH=$(cd "$(dirname "${0}")" && pwd -P)/$(basename "${0}")

[ -d "${REPO_DIR}" ] || die "${REPO_DIR} is not directory!"
[ -f "${SCRIPT_SH}" ] || die "${SCRIPT_SH} does not exist!"

## repo group
REPOS_ARRAY=(
esp-idf        espressifsystems
esp-sr         esp-components
esp-adf-libs   esp-components
)

len=${#REPOS_ARRAY[@]}

pushd ${REPO_DIR} >/dev/null

# 0
[ -f ".gitmodules" ] || exit 0

# 1
git submodule init


# 2
# Replacing each submodule URL of the current repository
# to the mirror repos in gitee
for LINE in $(git config -f .gitmodules --list | grep "\.url=../../[^.]\|\.url=https://github.com/[^.]")
do
    SUBPATH=$(echo "${LINE}" | sed "s|^submodule\.\([^.]*\)\.url.*$|\1|")
    LOCATION=$(echo "${LINE}" | sed 's/.*\///' | sed 's/.git//g')

    for ((i=0;i<len;i+=2))
    do
        REPO=${REPOS_ARRAY[i]}
	GROUP=${REPOS_ARRAY[i+1]}

        if [ "$LOCATION" = "$REPO" ]; then
	    SUBURL="https://gitee.com/$GROUP/$LOCATION"
	    break
        else
            SUBURL="https://gitee.com/esp-submodules/$LOCATION"
	fi
    done

    git config submodule."${SUBPATH}".url "${SUBURL}"
done

# 3
# Getting submodules of the current repository from gitee mirrors
git submodule update || exit $ERR_CANNOT_UPDATE

# 4
# Replacing URLs for each sub-submodule.
# The script runs recursively
git submodule foreach "${SCRIPT_SH}" # No '--recursive'

popd >/dev/null
