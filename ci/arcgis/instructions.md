# Testing

This was testing. Doesn't work. Discovered that 

* jupyter-server-proxy is needed
* works in docker but not in jupyterhub I think due to the server app being different. I tried to change to old server but no luck.
* doesn't work with the juptyer/base-notebook:python-3.9. Everything I tried failed.



# tldr;

```
cd ci/arcgis
DOCKER_TAG="20240129b"
docker build --platform linux/amd64 -t eeholmes/py-rocket-gis:${DOCKER_TAG} .
docker push eeholmes/py-rocket-gis:${DOCKER_TAG}
```

Testing
```
DOCKER_TAG="$(git rev-parse --short HEAD)"
docker build --platform linux/amd64 -t eeholmes/py-rocket-gis:${DOCKER_TAG} .
docker push eeholmes/py-rocket-gis:${DOCKER_TAG}
```
