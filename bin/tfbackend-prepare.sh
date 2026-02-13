#!/bin/bash

set -eu
env=$1
rsrc_name=$2
region=$3
script_dir=$(cd $(dirname $0);pwd)
root_dir="${script_dir}/.."

gcloud storage buckets create gs://${rsrc_name} \
--location $region \
--soft-delete-duration 90d \
--public-access-prevention \
--uniform-bucket-level-access

gcloud storage buckets update gs://${rsrc_name} \
--versioning \
--lifecycle-file ${root_dir}/tmpl/cloud-storage-lifecycle-tfbackend.json \
--update-labels=name=${rsrc_name},env=${env}
