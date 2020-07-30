#!/bin/bash
#
# author: Gary A. Stafford
# site: https://programmaticponderings.com
# license: MIT License
# purpose: Create 3-node GKE cluster

# Constants - CHANGE ME!
readonly PROJECT='serious-amp-280315'
readonly CLUSTER='demo-project-cluster'
readonly REGION='us-central1'
readonly MASTER_AUTH_NETS='78.84.0.0/16'
readonly GKE_VERSION='1.16.8-gke.15'
readonly MACHINE_TYPE='n1-standard-2'

# yes | gcloud components update
# gcloud init # set new project

# gcloud container get-server-config
# gcloud compute machine-types list

# Build a 3-node, single-region, multi-zone GKE cluster
gcloud container clusters create ${CLUSTER} \
  --project ${PROJECT} \
  --addons HorizontalPodAutoscaling,HttpLoadBalancing \
  --default-max-pods-per-node 110 \
  --disk-type pd-standard \
  --disk-size 200 \
  --enable-autorepair \
  --enable-autoupgrade \
  --enable-ip-alias \
  --enable-stackdriver-kubernetes \
  --image-type COS \
  --machine-type ${MACHINE_TYPE} \
  --metadata disable-legacy-endpoints=true \
  --network projects/${PROJECT}/global/networks/default \
  --subnetwork projects/${PROJECT}/regions/${REGION}/subnetworks/default \
  --num-nodes 1 \
  --enable-master-authorized-networks \
  --master-authorized-networks ${MASTER_AUTH_NETS} \
  --no-enable-basic-auth \
  --region ${REGION} \
  --scopes gke-default \
  --no-issue-client-certificate \
  --cluster-version ${GKE_VERSION}

# Get cluster credentials
gcloud container clusters get-credentials ${CLUSTER} \
  --region ${REGION} --project ${PROJECT}

kubectl create clusterrolebinding cluster-admin-binding \
    --clusterrole=cluster-admin \
    --user="$(gcloud config get-value core/account)"

kubectl config current-context
