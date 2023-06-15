FROM openscapes/python:f577786

# install additional package...

USER ${NB_USER}

RUN pip install zarr-eosdis-store
RUN pip install tensorflow
RUN pip install pqdm
# it can't find new.yml in home/joyvan/.kernels
# need to get that into the container somehow (git clone?)
# RUN conda env update --file new.yml

ENV JUPYTERHUB_HTTP_REFERER=https://dhub.opensci.live/
