#FROM ghcr.io/esri/arcgis-python-api-notebook
FROM quay.io/jupyter/base-notebook:latest

RUN mamba install --yes 'jupyter-server-proxy' && \
    mamba clean --all -f -y && \
    fix-permissions "${CONDA_DIR}" && \
    fix-permissions "/home/${NB_USER}"
