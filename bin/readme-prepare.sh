#!/bin/bash

set -eu
script_dir=$(cd $(dirname $0);pwd)
root_dir="${script_dir}/.."

if [[ -f ${root_dir}/README_org.md ]]; then
  echo "README is already prepared."
  exit 0
fi

mv ${root_dir}/README.md ${root_dir}/README_org.md
cat ${root_dir}/README.md.tmpl > ${root_dir}/README.md
rm ${root_dir}/README.md.tmpl