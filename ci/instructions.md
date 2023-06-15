# Requirements

Docker installed. For example, if doing on a Mac or PC, you need Docker Desktop. On VMs, docker will already be installed.

A DockerHub user account. The instructions are using EEH's.

# Add new packages

to `environment.yml`

# Rebuild and push the Docker image

1. Go to a terminal and cd to the directory with the Dockerfile. So to the `ci` directory in the `nmfs-jhub` repo.
```
cd ci
```
2. Update the docker tag to the date.
```
DOCKER_TAG="20230615"
```
2. Build the image. `.` means current directory. `eeholmes/iopython` is the name of the repo on DockerHub. See notes below.
```
docker build -t eeholmes/iopython:${DOCKER_TAG} .
```
3. Push the image up to DockerHub
```
docker push eeholmes/iopython:${DOCKER_TAG}
```

https://help.valohai.com/hc/en-us/articles/4421364087569-Build-your-own-Docker-image

# Asides

## To set docker tag to latest commit

```
SHA7="$(git rev-parse --short HEAD)"
DOCKER_TAG=$SHA7
```
I am not doing that since this repo has lots of commits unrelated to the docker image.

## To set up your own Docker repo

1. Make an account on DockerHub. Free is fine.
2. Create a repo and give it a name. For example, for this project, my account is `eeholmes` and my repo is `iopython` (Indian Ocean Python) as it is specific a particular project I am working on.

DockerHub will want to you to buy the premium account but you only need that if you are doing continuous integration, like using a GitHub Action to autobuild your image. If you are manually building, you don't need this.
