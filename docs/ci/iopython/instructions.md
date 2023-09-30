# Indian Ocean Summer Docker Images: Openscapes + a few extras

https://hub.docker.com/repository/docker/eeholmes/iopython/general

The one to use is the dated one. The `main` tag doesn't seem to always be recognized as a new tag when it changes.

# Requirements

Docker installed. For example, if doing on a Mac or PC, you need Docker Desktop. On VMs, docker will already be installed.

A DockerHub user account. The instructions are using EEH's.

# Add new packages

Add to Dockerfile something like
```
RUN conda install -c conda-forge cmocean
RUN pip install cmocean
```
Try to use conda instead of pip so that any package conflicts are resolved.

# Rebuild and push the Docker image

1. Make sure Docker app is running, not just installed. So if you are on a local computer, start up the app (open it).
1. Go to a terminal and cd to the directory with the Dockerfile. So to the `ci` directory in the `nmfs-jhub` repo.
```
cd ci/iopython
```
2. Update the docker tag to the date.
```
DOCKER_TAG="20230901"
```
2. Build the image. `.` means current directory. `eeholmes/iopython` is the name of the repo on DockerHub. See notes below. 
```
docker build --platform linux/amd64 -t eeholmes/iopython:${DOCKER_TAG} -t eeholmes/iopython:main .
```

3. Push the image up to DockerHub. Make sure you are logged into DockerHub in the Docker app otherwise you'll get "access denied". Open the Docker app and look that it shows that you are signed in.
```
docker push eeholmes/iopython:${DOCKER_TAG}
docker push eeholmes/iopython:main
```

Notes: https://help.valohai.com/hc/en-us/articles/4421364087569-Build-your-own-Docker-image


# Stop any running the Jupyter Lab instances

Log in. File > Hub Control > Stop my server

# Run `helm upgrade`

Log into Azure portal, go to DaskHub, Connect, Cloud Shell, and run this command. Note, this assumes that `eeholmes/iopython:main` is still the image to use. If not, edit `dconfig2.yaml` (`nano dconfig2.yaml`) and then upgrade.

```
helm upgrade --cleanup-on-fail --render-subchart-notes dhub dask/daskhub --namespace dhub --version=2023.1.0 --values dconfig2.yaml
```


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

## Why is `--platform` needed in the build command

You won't see this on docker build tutorials. But if you are on a Mac with Apple chip, then you'll build arm64 images and that's not going to work on Ubuntu VMs. The vanilla images you see are amd64 so we want to make sure we are building for that platform. This only matters if you are on a Mac with Apple chip, but it won't break things for unix and PC so I added to make the instructions more robust.

## If a specific image tag is in config

The JupyterHub has a config file that specifies what images are being used. If the image is say `eeholmes/iopython:hublatest`, then whenever the a image with tag `hublatest` is pushed, the hub will use that. If on the otherhand, you config file has a specific, an unique tag that you don't overwrite, then you'll have to update the file in the config file on the cluster (log into Azure, go to cluster, connect to cloud shell, `nano dconfig2.yaml`) and upgrade the installation of the JupyterHub.

Why not `eeholmes/iopython:latest`? There is nothing special about `latest`. It is the default tag used if you don't specify `-t` and `:` in your build call. So it is a bit too easy to accidentally update "latest" and thus update the image for you hub when you didn't intend to do that. You just forgot to specify a tag.

To update if you are using a specific tag, like `20230615` rather than one you keep updating like `hublatest` or `latest`:

### Step 1

Edit the config file. Mine is called `dconfig2.yaml`. Yours is probably `config.yaml`. Name is unimportant.

```
nano dconfig2.yaml
```

Inside `dconfig2.yaml` is this info. This shows a fixed tag. So if I update, I need to change the `20230615` part.
```
  singleuser:
    image:
      name: eeholmes/iopython
      tag: 20230615
```
Save the changes. In nano, it cmd-O, return, cmd-X.

### run `helm upgrade`

```
helm upgrade --cleanup-on-fail --render-subchart-notes dhub dask/daskhub --namespace dhub --version=2023.1.0 --values dconfig2.yaml
```

### The helm upgrade command

```
helm upgrade --cleanup-on-fail --render-subchart-notes dhub dask/daskhub --namespace dhub --version=2023.1.0 --values dconfig2.yaml
```

A helm is what runs the commands to upgrade (and install in the beginning) our JupyterHub. `dask/daskhub` is point to the repo with the "helm chart" (the instructions). `--value dconfig2.yaml` is telling it where the config file is. 

* `upgrade` upgrade an existing installation with the values in `dconfig2.yaml`
* `--render-subchart-notes` the dask/daskhub helm chart has subcharts (jupyterhub) and you need to render these too. Not all helm charts have this.
* `dask/daskhub` the name of the repo that has the helm chart. The first time you reference this, you need to tell help about the repo by giving it the url. [Read how here](https://blog.dask.org/2020/08/31/helm_daskhub)
* `--version=2023.1.0` version of the helm chart. Update when the helm chart (instructions for installing the jupyterhub) changes.

## Adding packages with newpackages.yml

When the openscapes image is used, we are in a conda env called 'notebook'. We want to
update that with the packages in newpackages.yml but need to get that file into the container. For now,
I just hard code in the pip/conda install commands.

Add to Docker file
```
# it can't find new.yml in home/joyvan/.kernels
# need to get that into the container somehow (git clone?)
# RUN conda env update --file new.yml
```