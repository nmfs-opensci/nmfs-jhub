# This is a base geospatial R and Python image
FROM rocker/rstudio:4.3

# Conda set up see https://github.com/pangeo-data/pangeo-docker-images/blob/master/base-image/Dockerfile
ENV CONDA_ENV=notebook \
    DEBIAN_FRONTEND=noninteractive \
    DEFAULT_USER=jovyan \
    NB_USER=jovyan \
    # uid=1000 is rstudio I think
    NB_UID=1000 \ 
    SHELL=/bin/bash \
    # Setup locale to be UTF-8, avoiding gnarly hard to debug encoding errors
    LANG=C.UTF-8  \
    LC_ALL=C.UTF-8 \
    CONDA_DIR=/srv/conda

# All env vars that reference other env vars need to be in their own ENV block
# Path to the python environment where the jupyter notebook packages are installed
ENV NB_PYTHON_PREFIX=${CONDA_DIR}/envs/${CONDA_ENV} \
    # Home directory of our non-root user
    HOME=/home/${NB_USER}
    
# Add both our notebook env as well as default conda installation to $PATH
# Thus, when we start a `python` process (for kernels, or notebooks, etc),
# it loads the python in the notebook conda environment, as that comes
# first here.
ENV PATH=${NB_PYTHON_PREFIX}/bin:${CONDA_DIR}/bin:${PATH}
# Tell R and RStudio about the PATH
RUN echo "PATH=${PATH}" >>"${R_HOME}/etc/Renviron.site"

# Ask dask to read config from ${CONDA_DIR}/etc rather than
# the default of /etc, since the non-root jovyan user can write
# to ${CONDA_DIR}/etc but not to /etc
ENV DASK_ROOT_CONFIG=${CONDA_DIR}/etc

RUN echo "Create ${NB_USER} user..." \
    # Create a group for the user to be part of, with gid same as uid
#    && groupadd --gid ${NB_UID} ${NB_USER}  \
    # Create non-root user, with given gid, uid and create $HOME
#    && useradd --create-home --gid ${NB_UID} --no-log-init --uid ${NB_UID} ${NB_USER} \
    # Make sure that /srv is owned by non-root user, so we can install things there
    && chown -R ${NB_USER}:${NB_USER} /srv

# This is to make home/jovyan the home dir for user rstudio
#RUN usermod -d /home/jovyan rstudio

# Run conda activate each time a bash shell starts, so users don't have to manually type conda activate
# Note this is only read by shell, but not by the jupyter notebook - that relies
# on us starting the correct `python` process, which we do by adding the notebook conda environment's
# bin to PATH earlier ($NB_PYTHON_PREFIX/bin)
RUN echo ". ${CONDA_DIR}/etc/profile.d/conda.sh ; conda activate ${CONDA_ENV}" > /etc/profile.d/init_conda.sh

# Install basic apt packages
RUN echo "Installing Apt-get packages..." \
    && apt-get update --fix-missing > /dev/null \
    && apt-get install -y apt-utils wget zip tzdata > /dev/null \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

USER ${NB_USER}

#COPY --chown=rstudio:rstudio . /tmp/build
COPY --chown=jovyan:jovyan . /tmp/build

WORKDIR /tmp/build

# Install latest mambaforge in ${CONDA_DIR}
RUN echo "Installing Mambaforge..." \
    && URL="https://github.com/conda-forge/miniforge/releases/latest/download/Mambaforge-Linux-x86_64.sh" \
    && wget --quiet ${URL} -O installer.sh \
    && /bin/bash installer.sh -u -b -p ${CONDA_DIR} \
    && rm installer.sh \
    && mamba clean -afy \
    # After installing the packages, we cleanup some unnecessary files
    # to try reduce image size - see https://jcristharif.com/conda-docker-tips.html
    && find ${CONDA_DIR} -follow -type f -name '*.a' -delete \
    && find ${CONDA_DIR} -follow -type f -name '*.pyc' -delete

RUN echo "Creating conda environment ..." \
    && URL="https://github.com/conda-forge/miniforge/releases/latest/download/Mambaforge-Linux-x86_64.sh" \
    && wget --quiet ${URL} -O installer.sh \
    && mamba env create --name ${CONDA_ENV} -f environment.yml  \
    && mamba clean -yaf \
    && find ${CONDA_DIR} -follow -type f -name '*.a' -delete \
    && find ${CONDA_DIR} -follow -type f -name '*.pyc' -delete \
    && find ${CONDA_DIR} -follow -type f -name '*.js.map' -delete \
    ; if [ -d ${NB_PYTHON_PREFIX}/lib/python*/site-packages/bokeh/server/static ]; then \
    find ${NB_PYTHON_PREFIX}/lib/python*/site-packages/bokeh/server/static -follow -type f -name '*.js' ! -name '*.min.js' -delete \
    ; fi

WORKDIR ${HOME}

EXPOSE 8888

CMD ["jupyter", "lab", "--ip=0.0.0.0", "--port=8888", "--allow-root", "--no-browser"]
