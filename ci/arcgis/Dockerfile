# This does not work; uses Python 3.9 and old modules
# The widget only works on the old notebook jupyter-server-proxy
# won't work in a jupyterhub
FROM ghcr.io/esri/arcgis-python-api-notebook

RUN mamba install --yes 'jupyter-server-proxy' && \
    mamba clean --all -f -y
    