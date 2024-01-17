# py-rocket-base

This is based on the openscapes/py-rocket but simplified.

<https://hub.docker.com/repository/docker/eeholmes/py-rocket-base/general>

The one to use is the dated one. The `main` tag doesn't seem to always be recognized as a new tag when it changes.

# tldr;

```
cd ci/py-rocket-base
DOCKER_TAG="20230901"
docker build --platform linux/amd64 -t eeholmes/py-rocket-base:${DOCKER_TAG} -t eeholmes/py-rocket-base:main .
docker push eeholmes/py-rocket-base:${DOCKER_TAG}
docker push eeholmes/py-rocket-base:main
```

Testing
```
DOCKER_TAG="$(git rev-parse --short HEAD)"
docker build --platform linux/amd64 -t eeholmes/py-rocket-base:${DOCKER_TAG} .
docker push eeholmes/py-rocket-base:${DOCKER_TAG}
```

Log into Azure portal, go to DaskHub, Connect, Cloud Shell, and edit `dconfig2.yaml` (`nano dconfig2.yaml`) to update the image tag. Then run this command.

```
helm upgrade --cleanup-on-fail --render-subchart-notes dhub dask/daskhub --namespace dhub --version=2023.1.0 --values dconfig2.yaml
```

Tip: if things fill up use
```
docker system prune --all
```

