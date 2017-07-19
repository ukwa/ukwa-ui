
FROM java:openjdk-8-jdk
# originally based on UNB Libraries Dockerfile
MAINTAINER Mindaugas Vidmantas "mindaugas.vidmantas@bl.uk"


# update packages and install maven
RUN \
  export DEBIAN_FRONTEND=noninteractive && \
  sed -i 's/# \(.*multiverse$\)/\1/g' /etc/apt/sources.list && \
  apt-get update && \
  apt-get -y upgrade && \
  apt-get install -y tar wget curl git maven

  
ENV TOMCAT_MAJOR_VERSION 8
ENV TOMCAT_MINOR_VERSION 8.5.16
ENV CATALINA_HOME /tomcat
ENV CATALINA_TMPDIR /tmp

ENV SOLR_USERNAME=none
ENV SOLR_PASSWORD=none  


RUN cd /tmp


RUN \
  git clone https://github.com/min2ha/ukwa-ui.git && \
  cd ukwa-ui && \
mvn package -DskipTests

RUN mv /tmp/ukwa-ui/target/marsspiders-ukwa-1.4.2.RELEASE.war  /tmp/ukwa-ui/target/ROOT.war

	
RUN cd /tmp	
# INSTALL TOMCAT
RUN wget -q https://archive.apache.org/dist/tomcat/tomcat-${TOMCAT_MAJOR_VERSION}/v${TOMCAT_MINOR_VERSION}/bin/apache-tomcat-${TOMCAT_MINOR_VERSION}.tar.gz && \
    wget -qO- https://archive.apache.org/dist/tomcat/tomcat-${TOMCAT_MAJOR_VERSION}/v${TOMCAT_MINOR_VERSION}/bin/apache-tomcat-${TOMCAT_MINOR_VERSION}.tar.gz.md5 | md5sum -c - && \
    tar zxf apache-tomcat-*.tar.gz && \
    rm apache-tomcat-*.tar.gz && \
    mv apache-tomcat* tomcat && \
    rm -rf /tomcat/webapps/examples /tomcat/webapps/docs /tomcat/webapps/ROOT
	
ADD create_tomcat_admin_user.sh /create_tomcat_admin_user.sh
ADD run.sh /run.sh
RUN chmod +x /*.sh	

RUN mv /tmp/ukwa-ui/target/ROOT.war /tomcat/webapps
RUN rm -rf /tmp/ukwa-ui
	
	
EXPOSE 8080
VOLUME /tomcat/logs
# reset entrypoint from parent image
ENTRYPOINT []
CMD ["/run.sh"]	
	
	
	
	
	
	
	
# make tomcat scripts executable
RUN chmod +x /opt/tomcat/bin/*.sh

# Cleanup webapps directory
RUN cd /opt/tomcat/webapps && rm -rf *

# Tweak Tomcat configuration
COPY server.xml /opt/apache-tomcat-7.0.70/conf/server.xml
COPY logging.properties /opt/apache-tomcat-7.0.70/conf/logging.properties

# Install ICU4J in the system JVM for broader language support
RUN \
  curl -O http://download.icu-project.org/files/icu4j/58.2/icu4j-58_2.jar && \
  curl -O http://download.icu-project.org/files/icu4j/58.2/icu4j-localespi-58_2.jar && \ 
  mv icu4j-* /usr/lib/jvm/java-7-openjdk-amd64/jre/lib/ext/

# Build UKWA Wayback versions inside the container...
# Need a patched OpenWayback instance:
RUN \
  git clone https://github.com/ukwa/openwayback.git && \
  cd openwayback && \
  git checkout restore-locale-switch && \
  mvn install -DskipTests
  
# Now build our overlays:
RUN \
  git clone https://github.com/ukwa/waybacks.git && \
  cd waybacks && \
  git checkout master && \
  mvn install -DskipTests

# Define runtime properties

EXPOSE 8080 8090

ENV JAVA_OPTS -Xmx1g

# Use oukwa|ldukwa|qa for Open UKWA, LD UKWA or QA UKWA versions
ENV UKWA_OWB_VERSION=qa 

VOLUME /data

#Fire up tomcat, copying desired WAR into place first
COPY start.sh /

CMD /start.sh


