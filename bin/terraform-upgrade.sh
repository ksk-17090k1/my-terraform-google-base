#!/bin/bash

set -eu
version=$1
script_dir=$(cd $(dirname $0);pwd)
root_dir="${script_dir}/.."

cd ${root_dir}/
find ./.github/workflows -type f | \
xargs sed -i "" "s/TF_VERSION:.*/TF_VERSION: ${version}/g"
find ./src -type f -name "backend.tf" | \
xargs sed -i "" "s/required_version =.*/required_version = \"${version}\"/g"
