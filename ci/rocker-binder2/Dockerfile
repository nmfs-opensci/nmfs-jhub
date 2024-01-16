FROM rocker/binder:4.3

USER root
RUN mkdir /home/jovyan
RUN usermod -d /home/jovyan rstudio
RUN chown rstudio:rstudio /home/jovyan
RUN rm -r /home/rstudio
USER rstudio

WORKDIR /home/jovyan

CMD ["jupyterhub-singleuser"]