#!/bin/bash

set -eu
script_dir=$(cd $(dirname $0);pwd)
tmpl_path="${script_dir}/../template.ini"

declare -A tool_repos=(
  ["terraform_version"]="hashicorp/terraform"
  ["terraform_google_provider_version"]="hashicorp/terraform-provider-google"
  ["github_actions_tfcmt_version"]="suzuki-shunsuke/tfcmt"
  ["github_actions_tfnotify_version"]="suzuki-shunsuke/tfnotify"
  ["github_actions_tfaction_version"]="lv-technology-strategy/github-actions-modules"
)

for tmpl_key in "${!tool_repos[@]}"; do
  repo_name=${tool_repos[${tmpl_key}]}  
  tag_name=$(gh release view --repo "${repo_name}" --json tagName -q ".tagName")

  if [[ $repo_name == hashicorp* ]] ; then
    tag_name=$(echo "$tag_name" | sed "s/^v//")
  fi

  perl -pi -e "s/^${tmpl_key}.*/${tmpl_key}=${tag_name}/g" ${script_dir}/../template.ini
done
