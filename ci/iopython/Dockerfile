FROM openscapes/python:f577786

# install additional package...

USER ${NB_USER}

RUN pip install tensorflow pqdm motuclient imbalanced-learn
# RUN pip install zarr-eosdis-store
# don't think this is needed and it is downgrading xarray to 0.21 (2 years old)
# it can't find new.yml in home/joyvan/.kernels
# need to get that into the container somehow (git clone?)
# RUN conda env update --file new.yml

ENV JUPYTERHUB_HTTP_REFERER=https://dhub.opensci.live/
