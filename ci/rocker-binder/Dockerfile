FROM rocker/binder:4.3

USER root
RUN usermod -d /home/jovyan rstudio
RUN mkdir /home/jovyan
RUN chown rstudio:rstudio /home/jovyan
USER rstudio

RUN pip3 install \
    'jupyter-rsession-proxy' \
    'jupyterhub==3.1.*' \
    'notebook==6.*' \
    'jupyterlab'

WORKDIR /home/jovyan

CMD ["jupyterhub-singleuser"]