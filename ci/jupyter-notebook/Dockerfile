FROM jupyter/minimal-notebook

USER ${NB_UID}

# Install Python 3 packages
RUN mamba install --yes \
    'altair' \
    'beautifulsoup4' \
    'bokeh'

USER ${NB_UID}

WORKDIR "${HOME}"