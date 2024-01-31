#FROM ghcr.io/esri/arcgis-python-api-notebook
FROM quay.io/jupyter/base-notebook:latest

ENV CONDA_ENV=base \
    # Tell apt-get to not block installs by asking for interactive human input
    DEBIAN_FRONTEND=noninteractive \
    # Set username, uid and gid (same as uid) of non-root user the container will be run as
    NB_USER=jovyan \
    NB_UID=1000 \
    # Use /bin/bash as shell, not the default /bin/sh (arrow keys, etc don't work then)
    SHELL=/bin/bash \
    # Setup locale to be UTF-8, avoiding gnarly hard to debug encoding errors
    LANG=C.UTF-8  \
    LC_ALL=C.UTF-8

# All env vars that reference other env vars need to be in their own ENV block
# Path to the python environment where the jupyter notebook packages are installed
ENV NB_PYTHON_PREFIX=${CONDA_DIR}/envs/${CONDA_ENV} \
    # Home directory of our non-root user
    HOME=/home/${NB_USER}

# Add both our notebook env as well as default conda installation to $PATH
# Thus, when we start a `python` process (for kernels, or notebooks, etc),
# it loads the python in the notebook conda environment, as that comes
# first here.
ENV PATH=${NB_PYTHON_PREFIX}/bin:${CONDA_DIR}/bin:${PATH}

USER root
RUN echo ". ${CONDA_DIR}/etc/profile.d/conda.sh ; conda activate ${CONDA_ENV}" > /etc/profile.d/init_conda.sh
USER ${NB_UID}

#FROM pangeo/base-image:2023.01.13

#RUN conda init zsh && conda init bash
#CONDA_DIR=/srv/conda

#RUN eval $(conda shell.bash hook)
#USER ${NB_USER}
#WORKDIR /home/${NB_USER}

#ENV CONDA_ENV=base
#RUN conda activate ${CONDA_ENV}
#RUN python -m ipykernel install --prefix /opt/conda/envs/${CONDA_ENV} --name ${CONDA_ENV} --display-name ${CONDA_ENV}


#RUN conda install -c conda-forge jupyterlab=2.2.10
#RUN conda shell.bash hook
