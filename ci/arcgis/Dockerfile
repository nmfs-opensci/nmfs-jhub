#FROM ghcr.io/esri/arcgis-python-api-notebook
FROM jupyter/base-notebook:latest
RUN eval $(conda shell.bash hook)
RUN source activate base
#RUN conda init zsh && conda init bash

USER ${NB_USER}
WORKDIR /home/${NB_USER}

#RUN conda install -c conda-forge jupyterlab=2.2.10
#RUN conda shell.bash hook
