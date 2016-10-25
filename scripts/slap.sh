#!/bin/bash

./bounce-ags.sh && \
  ./register-cert.sh && \
  /home/arcgis/server/tools/python -m slap.cli publish --name $HOSTNAME --username=siteadmin --password=51734dm1n --site && \
  /home/arcgis/server/tools/python -m slap.cli publish --name $HOSTNAME --username=siteadmin --password=51734dm1n
