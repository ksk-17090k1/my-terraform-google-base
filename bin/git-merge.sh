#!/bin/bash

set -eux
head_ref=$1
base_ref=$2

git config --local user.name "GitHub Action"
git config --local user.email "action@github.com"

git fetch
git checkout -b $base_ref origin/$base_ref
git branch $head_ref origin/$head_ref
git merge $head_ref --allow-unrelated-histories