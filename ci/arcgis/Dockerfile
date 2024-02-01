FROM ghcr.io/esri/arcgis-python-api-notebook

RUN mamba install --yes 'jupyter-server-proxy' && \
    mamba clean --all -f -y
    
# Clone base
ARG env_name=arcgis
RUN conda create --name "${env_name}" --clone base

# Create Python kernel and link it to jupyter
RUN "${CONDA_DIR}/envs/${env_name}/bin/python" -m ipykernel install --user --name="${env_name}" && \
    fix-permissions "${CONDA_DIR}" && \
    fix-permissions "/home/${NB_USER}"
    
USER root
# Create dirs for startup hooks
RUN mkdir /usr/local/bin/before-notebook.d && \
    fix-permissions "/usr/local/bin/before-notebook.d"
RUN echo 'eval "$(conda shell.bash hook)"' > /usr/local/bin/before-notebook.d/10activate-conda-env.sh
USER ${NB_UID}

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