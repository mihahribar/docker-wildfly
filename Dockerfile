FROM ubuntu

#
# oracle jdk 7
#

# add java 7 repository
RUN apt-get update
RUN apt-get -y install software-properties-common
RUN add-apt-repository -y ppa:webupd8team/java
RUN apt-get update
RUN apt-get -y upgrade

# auto accept licence & install
RUN echo oracle-java7-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections
RUN apt-get -y install oracle-java7-installer
RUN apt-get clean

ENV JAVA_HOME /usr/lib/jvm/java-7-oracle

#
# wildfly
#

ENV WILDFLY_VERSION 8.1.0.Final

# Create the wildfly user and group
RUN groupadd -r wildfly -g 433 && useradd -u 431 -r -g wildfly -d /opt/wildfly -s /sbin/nologin -c "WildFly user" wildfly

# Create directory to extract tar file to
RUN mkdir /opt/wildfly-$WILDFLY_VERSION

# download wildfly
RUN apt-get -y install curl
RUN cd /opt && curl http://download.jboss.org/wildfly/$WILDFLY_VERSION/wildfly-$WILDFLY_VERSION.tar.gz | tar zx && chown -R wildfly:wildfly /opt/wildfly-$WILDFLY_VERSION

# Make sure the distribution is available from a well-known place
RUN ln -s /opt/wildfly-$WILDFLY_VERSION /opt/wildfly && chown -R wildfly:wildfly /opt/wildfly

# Set the JBOSS_HOME env variable
ENV JBOSS_HOME /opt/wildfly

# Expose the ports we're interested in
EXPOSE 8080 9990

# Run everything below as the wildfly user
USER wildfly

# command to run at boot
CMD ["/opt/wildfly/bin/standalone.sh", "-b", "0.0.0.0", "-bmanagement", "0.0.0.0"]
