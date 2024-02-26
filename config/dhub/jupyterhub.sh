#!/bin/bash

helm repo add dask https://helm.dask.org
helm repo update

helm upgrade --cleanup-on-fail \
  --render-subchart-notes dhub dask/daskhub \
  --namespace dhub \
  --version=2024.1.1 \
  --values dconfig2.yaml