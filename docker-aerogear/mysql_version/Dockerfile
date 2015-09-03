FROM jboss/wildfly
MAINTAINER kevin.moreau@dynamease.com

ENV AEROGEAR_FILES /usr/local/share/aerogear
ENV JBOSS_HOME /opt/jboss/wildfly

ENV DEPLOYMENTS $JBOSS_HOME/standalone/deployments/
ENV AEROGEAR_SERVER $AEROGEAR_FILES/aerogear-server

ENV AEROGEAR_VERSION 1.1.0-beta.4

USER root

RUN curl -L -o /etc/yum.repos.d/epel-apache-maven.repo http://repos.fedorapeople.org/repos/dchen/apache-maven/epel-apache-maven.repo \
    && yum -y install apache-maven && yum clean all

RUN mkdir $AEROGEAR_FILES


#Retrieve all the needed files for the aerogear instalation
RUN curl -L -o  $AEROGEAR_FILES/aerogear-unifiedpush-server-$AEROGEAR_VERSION-dist.tar.gz https://github.com/aerogear/aerogear-unifiedpush-server/releases/download/1.1.0-beta.4/aerogear-unifiedpush-server-$AEROGEAR_VERSION-dist.tar.gz

#Extraction of the aerogear files
RUN tar -xf $AEROGEAR_FILES/aerogear-unifiedpush-server-$AEROGEAR_VERSION-dist.tar.gz -C $AEROGEAR_FILES
RUN mv $AEROGEAR_FILES/aerogear-unifiedpush-server-$AEROGEAR_VERSION $AEROGEAR_SERVER

#Copy the MySQL module to the application sever modules directory
RUN cp -r $AEROGEAR_SERVER/databases/src/main/resources/modules/com $JBOSS_HOME/modules/

#RUN mvn dependency:copy -Dartifact=mysql:mysql-connector-java:5.1.18 -DoutputDirectory=$JBOSS_HOME/modules/com/mysql/jdbc/main/

#RUN yum -y erase apache-maven && yum clean all

RUN sed -i 's/localhost/mysql/g' $AEROGEAR_SERVER/databases/mysql-database-config-wildfly.cli

RUN unzip $AEROGEAR_SERVER/migrator/unifiedpush-migrator-1.1.0-beta.4-dist.zip -d $AEROGEAR_SERVER/migrator/



RUN sed -i 's/localhost/mysql/g' $AEROGEAR_SERVER/migrator/unifiedpush-migrator-1.1.0-beta.4/liquibase-mysql-example.properties &\
	sed -i 's/unifiedpush100li/unifiedpush/g' $AEROGEAR_SERVER/migrator/unifiedpush-migrator-1.1.0-beta.4/liquibase-mysql-example.properties

RUN mv $AEROGEAR_SERVER/migrator/unifiedpush-migrator-1.1.0-beta.4/liquibase-mysql-example.properties $AEROGEAR_SERVER/migrator/unifiedpush-migrator-1.1.0-beta.4/liquibase.properties

#RUN /opt/jboss/wildfly/bin/standalone.sh &\
#	sleep 20; $JBOSS_HOME/bin/jboss-cli.sh --file=$AEROGEAR_SERVER/databases/mysql-database-config-wildfly.cli

#RUN mv $AEROGEAR_SERVER/servers/unifiedpush-auth-server.war $JBOSS_HOME/standalone/deployments/ & mv $AEROGEAR_SERVER/servers/unifiedpush-server-wildfly.war $JBOSS_HOME/standalone/deployments/


EXPOSE 8443

COPY ./start-it.sh /
RUN chmod +x /start-it.sh

CMD ["/start-it.sh"]