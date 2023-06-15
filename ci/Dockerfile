FROM openscapes/python:f577786

# install additional package...

USER ${NB_USER}

WORKDIR ${HOME}/.kernels

RUN chmod +x install-kernels.sh && cd /home/jovyan/.kernels && ./install-kernels.sh environments

ENV JUPYTERHUB_HTTP_REFERER=https://dhub.opensci.live/

# set the default command of the image,
# if you want to launch more complex startup than the default `juptyerhub-singleuser`.
# To launch an image's custom CMD instead of the default `jupyterhub-singleuser`
# set `singleuser.cmd: null` in your config.yaml.