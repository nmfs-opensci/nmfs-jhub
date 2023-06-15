# Requirements

Docker installed. For example, if doing on a Mac or PC, you need Docker Desktop. On VMs, docker will already be installed.

A DockerHub user account. The instructions are using EEH's.

# Add new packages

to `environment.yml`

# Rebuild and push the Docker image

1. Go to a terminal and cd to the directory with the Dockerfile
2. Set docker tag to latest commit
```
SHA7="$(git rev-parse --short HEAD)"
DOCKER_TAG=$SHA7
```
2. Build the image. `.` means current directory.
```
docker build -t eeholmes/iopython:${DOCKER_TAG} .
```
3. Push the image up to DockerHub
```
docker push eeholmes/iopython:${DOCKER_TAG}
```

https://help.valohai.com/hc/en-us/articles/4421364087569-Build-your-own-Docker-image

