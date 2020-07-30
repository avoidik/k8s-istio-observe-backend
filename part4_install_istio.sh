#!/bin/bash

istioctl install \
  --set addonComponents.grafana.enabled=true \
  --set addonComponents.prometheus.enabled=true \
  --set addonComponents.kiali.enabled=true \
  --set addonComponents.tracing.enabled=true
