FROM openscapes/python:f577786

# install additional package...

USER ${NB_USER}

RUN conda install -c conda-forge nb_conda_kernels
RUN conda install -c conda-forge pillow cmocean

# RUN pip install zarr-eosdis-store
# don't think this is needed and it is downgrading xarray to 0.21 (2 years old)
# it can't find new.yml in home/joyvan/.kernels
# need to get that into the container somehow (git clone?)
# RUN conda env update --file new.yml

# ENV JUPYTERHUB_HTTP_REFERER=https://dhub.opensci.live/
ENV JUPYTERHUB_HTTP_REFERER=https://itcoocean.2i2c.cloud/