#FROM ghcr.io/esri/arcgis-python-api-notebook
FROM jupyter/base-notebook:latest
RUN conda init zsh && conda init bash

#RUN eval $(conda shell.bash hook)


USER ${NB_USER}
WORKDIR /home/${NB_USER}
RUN source activate base


#RUN conda install -c conda-forge jupyterlab=2.2.10
#RUN conda shell.bash hook
