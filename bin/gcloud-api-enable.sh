#!/bin/bash

set -eu
google_apis=(
  "cloudbuild.googleapis.com"
  "cloudfunctions.googleapis.com"
  "cloudkms.googleapis.com"
  "cloudscheduler.googleapis.com"
  "compute.googleapis.com"
  "dns.googleapis.com"
  "iam.googleapis.com"
  "iamcredentials.googleapis.com"
  "logging.googleapis.com"
  "monitoring.googleapis.com"
  "pubsub.googleapis.com"
  "run.googleapis.com"
  "secretmanager.googleapis.com"
  "servicenetworking.googleapis.com"
  "sqladmin.googleapis.com"
  "storage.googleapis.com"
  "storage-api.googleapis.com"
  "storage-component.googleapis.com"
  "vpcaccess.googleapis.com"
)

for apis in "${google_apis[@]}" ; do
  gcloud services enable $apis
done
