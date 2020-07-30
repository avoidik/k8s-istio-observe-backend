#!/bin/bash
#
# author: Gary A. Stafford
# site: https://programmaticponderings.com
# license: MIT License
# purpose: Delete Kubernetes resources

kubectl delete namespace dev test

istioctl manifest generate \
  --set addonComponents.grafana.enabled=true \
  --set addonComponents.prometheus.enabled=true \
  --set addonComponents.kiali.enabled=true \
  --set addonComponents.tracing.enabled=true | kubectl delete -f -

# kubectl delete namespace istio-system