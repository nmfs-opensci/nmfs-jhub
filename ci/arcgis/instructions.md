# This is based on the openscapes/py-rocket

<https://hub.docker.com/repository/docker/eeholmes/py-rocket/general>

The one to use is the dated one. The `main` tag doesn't seem to always be recognized as a new tag when it changes.

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
