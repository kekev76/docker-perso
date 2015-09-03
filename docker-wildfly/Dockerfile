FROM java:7
MAINTAINER kevin.moreau@dynamease.com

ENV JBOSS_HOME  /jboss
ENV JBOSS_VERSION 8.2.1.Final

RUN apt-get update -y & apt-get install -y wget
RUN wget http://download.jboss.org/wildfly/8.2.1.Final/wildfly-$JBOSS_VERSION.tar.gz

RUN tar -xvf wildfly-$JBOSS_VERSION.tar.gz
RUN mkdir $JBOSS_HOME
RUN cp -r wildfly-$JBOSS_VERSION/* $JBOSS_HOME/

EXPOSE 8080 8443

CMD ["/jboss/bin/standalone.sh","-b","0.0.0.0"]