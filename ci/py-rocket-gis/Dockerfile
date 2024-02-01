# This is a base geospatial R and Python image
FROM openscapes/python:6ee57a9

USER root
RUN apt-get update
RUN apt-get install -y libkrb5-dev
RUN conda install -c esri arcgis
USER ${NB_USER}

