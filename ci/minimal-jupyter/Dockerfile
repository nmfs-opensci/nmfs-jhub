FROM openscapes/rocker:a7596b5

RUN pip3 install \
    'jupyter-rsession-proxy' \
    'jupyterhub==3.1.*' \
    'notebook==6.*' \
    'jupyterlab'

USER root
RUN mkdir /home/jovyan
RUN chown rstudio:rstudio /home/jovyan
USER rstudio

CMD ["jupyterhub-singleuser"]