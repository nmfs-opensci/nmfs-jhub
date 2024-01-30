# This is a base geospatial R and Python image
FROM openscapes/python:6ee57a9

USER root
RUN apt-get update
RUN apt-get install -y libkrb5-dev
USER ${NB_USER}
RUN conda install -c esri arcgis
#RUN pip install arcgis
