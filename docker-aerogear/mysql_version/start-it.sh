#!/bin/bash
#start-it.sh

cd $AEROGEAR_SERVER/migrator/unifiedpush-migrator-1.1.0-beta.4/
./bin/ups-migrator update
/bin/bash
#/opt/jboss/wildfly/bin/standalone.sh --server-config=standalone-full.xml