#!/bin/bash
#
# author: Gary A. Stafford
# site: https://programmaticponderings.com
# license: MIT License
# purpose: Tear down GKE cluster and associated resources

# Constants - CHANGE ME!
readonly PROJECT='serious-amp-280315'
readonly CLUSTER='demo-project-cluster'
readonly REGION='us-central1'

# Delete GKE cluster (time in foreground)
gcloud container clusters delete ${CLUSTER} --region ${REGION}

# Confirm network resources are also deleted
gcloud compute forwarding-rules list
gcloud compute target-pools list
gcloud compute firewall-rules list

# In case target-pool associated with Cluster is not deleted
gcloud compute target-pools delete  \
  "$(gcloud compute target-pools list --filter="region:($REGION)" --project ${PROJECT} | awk 'NR==2 {print $1}')"
