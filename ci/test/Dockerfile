
FROM rocker/geospatial 
ENV NB_USER jovyan
ENV VIRTUAL_ENV /opt/venv
ENV PATH $VIRTUAL_ENV/bin:$PATH
ENV SHELL=/bin/bash

RUN usermod -l ${NB_USER} -d /home/${NB_USER} ${DEFAULT_USER}
RUN /rocker_scripts/install_jupyter.sh
RUN chown -R root:staff ${VIRTUAL_ENV} && chmod -R ug+rw ${VIRTUAL_ENV}

USER ${NB_USER}
WORKDIR /home/${NB_USER}

EXPOSE 8888

CMD ["jupyter", "lab", "--ip=0.0.0.0", "--port=8888", "--allow-root", "--no-browser"]
