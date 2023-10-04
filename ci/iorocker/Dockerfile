FROM openscapes/rocker:a7596b5

# install additional package...

USER ${NB_USER}

WORKDIR ${HOME}

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

# for JUPYTERHUB
RUN conda install -c conda-forge jupyterhub
RUN conda install -c conda-forge notebook


# ENV JUPYTERHUB_HTTP_REFERER=https://dhub.opensci.live/
ENV JUPYTERHUB_HTTP_REFERER=https://itcoocean.2i2c.cloud/
