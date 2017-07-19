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
