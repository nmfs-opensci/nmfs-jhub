#FROM ghcr.io/esri/arcgis-python-api-notebook
ARG python_version="3.9"
FROM jupyter/base-notebook:python-${python_version}

RUN mamba install --yes 'jupyter-server-proxy' && \
    mamba clean --all -f -y && \
    fix-permissions "${CONDA_DIR}" && \
    fix-permissions "/home/${NB_USER}"