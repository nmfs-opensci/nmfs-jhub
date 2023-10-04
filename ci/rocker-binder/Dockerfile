FROM rocker/binder:4.3

RUN pip3 install \
    'jupyter-rsession-proxy' \
    'jupyterhub==3.1.*' \
    'notebook==6.*' \
    'jupyterlab'

CMD ["jupyterhub-singleuser"]