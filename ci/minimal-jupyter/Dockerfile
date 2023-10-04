#FROM openscapes/rocker:a7596b5
FROM eeholmes/py-rocket:20231004

RUN pip3 install \
    'jupyter-rsession-proxy' \
    'jupyterhub==3.1.*' \
    'notebook==6.*' \
    'jupyterlab'

#RUN R --quiet -e 'remotes::install_github("IRkernel/IRkernel@*release")'
#RUN R --quiet -e 'IRkernel::installspec(user = FALSE)'

CMD ["jupyterhub-singleuser"]