FROM openscapes/python:f577786

# install additional package...

USER ${NB_USER}

WORKDIR ${HOME}/.kernels

RUN chmod +x install-kernels.sh && cd /home/jovyan/.kernels && ./install-kernels.sh environments

ENV JUPYTERHUB_HTTP_REFERER=https://dhub.opensci.live/
