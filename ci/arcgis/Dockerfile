#FROM ghcr.io/esri/arcgis-python-api-notebook
ARG python_version="3.9"
FROM jupyter/base-notebook:python-${python_version}

RUN mamba install --yes 'jupyter-server-proxy' && \
    mamba clean --all -f -y && \
    fix-permissions "${CONDA_DIR}" && \
    fix-permissions "/home/${NB_USER}"
    
# Name your environment and choose the Python version
ARG env_name=base
# Note: uncommenting this section makes "${env_name}" default both for Jupyter Notebook and Terminals
# More information here: https://github.com/jupyter/docker-stacks/pull/2047
USER root
RUN \
  # This changes a startup hook, which will activate the custom environment for the process
  echo conda activate "${env_name}" >> /usr/local/bin/before-notebook.d/10activate-conda-env.sh && \
  # This makes the custom environment default in Jupyter Terminals for all users which might be created later
  echo conda activate "${env_name}" >> /etc/skel/.bashrc && \
  # This makes the custom environment default in Jupyter Terminals for already existing NB_USER
  echo conda activate "${env_name}" >> "/home/${NB_USER}/.bashrc"

USER ${NB_UID}