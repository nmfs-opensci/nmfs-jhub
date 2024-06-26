FROM openscapes/rocker:a7596b5
# tell RStudio the right path so it is in the conda environment
USER root
RUN echo "PATH=${PATH}" >> "${R_HOME}/etc/Renviron.site"

# install additional package...

USER ${NB_USER}

WORKDIR ${HOME}

# fix security bug
# https://github.com/jupyterhub/jupyter-server-proxy/security/advisories/GHSA-w3vc-fx9p-wp4v
RUN pip install jupyter-server-proxy>=3.2.3 --no-deps

# By default, the versioned rocker image (which openscapes/rocker uses) will use 
# the Posit repository which has binaries for Unbuntu (which rocker image uses)

# packages for Python to R interoperability
RUN R -e 'install.packages(c("gtools", "gdata", "reticulate"))'

# sdmTMB packages
RUN R -e 'install.packages("INLA",repos=c(getOption("repos"),INLA="https://inla.r-inla-download.org/R/stable"), dep=TRUE)'
RUN R -e 'install.packages("sdmTMB", dependencies = TRUE)'

# SDM general packages
RUN R -e 'install.packages(c("biomod2", "dismo", "usdm", "ecospat", "gam", "sdmpredictors", "robis", "zoon", "spocc"))'
RUN R -e 'devtools::install_github("BigelowLab/maxnet")'

# r-spatial packages
# many are already in rocker/geospatial
# RUN R -e 'install.packages(c("sp", "raster", "ggplot2", "maps"))'
RUN R -e 'install.packages(c("geodata", "ggspatial", "rnaturalearth"))'

# general
RUN R -e 'install.packages(c("corrplot", "here", "matrixcalc", "cmocean", "DT", "janitor"))'

# ENV JUPYTERHUB_HTTP_REFERER=https://dhub.opensci.live/
# ENV JUPYTERHUB_HTTP_REFERER=https://itcoocean.2i2c.cloud/
