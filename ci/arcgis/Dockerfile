#FROM ghcr.io/esri/arcgis-python-api-notebook
FROM jupyter/base-notebook:latest
RUN conda init zsh && conda init bash

#RUN eval $(conda shell.bash hook)

USER ${NB_USER}
WORKDIR /home/${NB_USER}

ENV CONDA_ENV=base
RUN source activate ${CONDA_ENV}
RUN python -m ipykernel install --prefix /srv/conda/envs/${CONDA_ENV} --name ${CONDA_ENV} --display-name ${CONDA_ENV}


#RUN conda install -c conda-forge jupyterlab=2.2.10
#RUN conda shell.bash hook
