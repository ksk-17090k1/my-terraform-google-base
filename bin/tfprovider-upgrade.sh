#!/bin/bash

set -eu
version=$1
script_dir=$(cd $(dirname $0);pwd)
src_dir="${script_dir}/../src"

cd ${src_dir}/
find . -type f -name "backend.tf" | \
xargs sed -i "" "s/google =.*/google = \"${version}\"/g"
