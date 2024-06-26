To restart hub after changing `dconfig2.yaml`
```
helm upgrade --cleanup-on-fail --render-subchart-notes dhub dask/daskhub --namespace dhub --version=2023.1.0 --values dconfig-resource.yaml
```

`dconfig-resource.yaml` has resources

To get the pods
```
kubectl get pods -n dhub
```

