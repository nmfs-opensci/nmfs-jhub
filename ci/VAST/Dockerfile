# geospatial rocker
FROM openscapes/rocker:a7596b5

USER ${NB_USER}

WORKDIR ${HOME}

# fix security bug
# https://github.com/jupyterhub/jupyter-server-proxy/security/advisories/GHSA-w3vc-fx9p-wp4v
RUN pip install jupyter-server-proxy>=3.2.3 --no-deps

# By default, the versioned rocker image (which openscapes/rocker uses) will use 
# the Posit repository which has binaries for Unbuntu (which rocker image uses)

# VAST dependencies packages
RUN R -e 'install.packages("INLA",repos=c(getOption("repos"),INLA="https://inla.r-inla-download.org/R/stable"), dep=TRUE)'
RUN R -e 'install.packages("TMB")'
RUN R -e 'devtools::install_github("james-thorson/FishStatsUtils@main", INSTALL_opts="--no-staged-install")'
RUN R -e 'devtools::install_github("james-thorson/VAST@main", INSTALL_opts="--no-staged-install")'
