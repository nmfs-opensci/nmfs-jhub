FROM openscapes/rocker:a7596b5

# install additional package...

USER ${NB_USER}

WORKDIR ${HOME}

RUN R -e 'install.packages("gtools", repos = "http://cran.us.r-project.org")'
RUN R -e 'install.packages("gdata", repos = "http://cran.us.r-project.org")'
RUN R -e 'install.packages("reticulate", repos = "http://cran.us.r-project.org")'
RUN R -e 'install.packages("matrixcalc", repos = "http://cran.us.r-project.org")'

ENV JUPYTERHUB_HTTP_REFERER=https://dhub.opensci.live/
