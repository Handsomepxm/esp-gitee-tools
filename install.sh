#!/usr/bin/env bash

set -e
set -u

die() {
    echo "${1:-"Unknown Error"}" 1>&2
    exit 1
}

IDF_PATH=${1:-"${PWD}"}
IDF_PATH=$(cd ${IDF_PATH} && pwd -P)

export IDF_PATH

[ -f "${IDF_PATH}/tools/tools.json" ] || die "${IDF_PATH}/tools/tools.json does not exist!"

cp ${IDF_PATH}/tools/tools.json ${IDF_PATH}/tools/tools_gitee.json

if [[ "$OSTYPE" == "darwin"* ]]; then
    extension="\"\""
else
    extension=
fi

sed -i ${extension} 's,"url".*/,"url": "https://dl.espressif.com/dl/,g' ${IDF_PATH}/tools/tools_gitee.json

echo "Installing ESP-IDF tools"
${IDF_PATH}/tools/idf_tools.py --tools-json ${IDF_PATH}/tools/tools_gitee.json install

echo "Installing Python environment and packages"
${IDF_PATH}/tools/idf_tools.py install-python-env

rm ${IDF_PATH}/tools/tools_gitee.json

basedir="$(dirname $0)"
echo "All done! You can now run:"
echo ""
echo "  . ${basedir}/export.sh"
echo ""
