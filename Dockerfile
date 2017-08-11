FROM ags10.5

MAINTAINER @imf <ian.firkin@gmail.com>

USER arcgis

ENV services=/home/arcgis/services
RUN mkdir -p $services

# Everything needs to run as the arcgis user
USER root
RUN chmod -R 775 /etc/pki
RUN yum -y --nogpg install openssl
RUN usermod -aG root arcgis
USER arcgis

# Copy over our scripts
COPY data/ $services/
COPY scripts/* $services/

# Tell ESRI where our certs live for HTTPS calls
ENV CA_ROOT_CERTIFICATE_DIR=/etc/pki/tls/certs

# We need to use ESRI's WINE version of python.
# Because of this, the current working directory will be something weird,
# so make sure that the paths in the SLAP config are absolute!
RUN /home/arcgis/server/tools/python -m pip install --ignore-installed --no-cache-dir slap

# Publish our services.  We do this in the build step, then they'll all be in place when we run a container
# from this image.
RUN cd $services && ./slap.sh

# When we run this, by default start the server up and start up a shell
ENTRYPOINT /home/arcgis/server/startserver.sh && /bin/bash

