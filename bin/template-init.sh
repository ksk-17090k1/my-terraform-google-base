#!/bin/bash

set -eu
script_dir=$(cd $(dirname $0);pwd)
root_dir="${script_dir}/.."
ini_file="${root_dir}/template.ini"

# Resolve the error "sed: RE error: illegal byte sequence".
export LC_ALL=C

cd ${root_dir}/
for ini_key in `cat $ini_file | grep "=" | sed -e "s/=.*//g"` ; do
  ini_value=`cat $ini_file | grep $ini_key | sed -e "s/.*=\(.*\)/\1/g"`
  
  echo ""
  echo "######## Replace <${ini_key}> with ${ini_value}: start. ########"

  # 1. Check if <${ini_key}> exists in the repository.
  grep_result=`find . -type f | grep -v ".git/" | \
  xargs grep "<${ini_key}>" | wc -l | sed -e "s/ //g"`

  if [ $grep_result -eq 0 ]; then
    echo "<${ini_key}> not found in the repository. Skip replacing."

  # 2. Replace <${ini_key}> with ${ini_value}.
  else
    find . -type f | grep -v ".git/" | \
    xargs sed -i "" "s/<${ini_key}>/${ini_value}/g"

    echo "The replacment process scceeded!"
  fi

  echo "######## Replace <${ini_key}> with ${ini_value}: end. ########"
done