FROM openscapes/rocker:a7596b5

# install additional package...

USER ${NB_USER}

WORKDIR ${HOME}

# https://rocker-project.org/use/extending.html
RUN R -e 'install.packages("INLA",repos=c(getOption("repos"),INLA="https://inla.r-inla-download.org/R/stable"), dep=TRUE)'
RUN install2.r --error --skipinstalled --ncpus -1 --deps TRUE \
    sdmTMB \
    && rm -rf /tmp/downloaded_packages

ENV JUPYTERHUB_HTTP_REFERER=https://dhub.opensci.live/
