FROM java:openjdk-8-jdk AS ukwaUIWebApp
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

ENV ARCHIVE_WEB_LOCATION="https://www.webarchive.org.uk/wayback/archive/"
ENV SOLR_COLLECTION_SEARCH_PATH="http://192.168.45.241:8983/solr/collections/select?"
ENV SOLR_FULL_TEXT_SEARCH_PATH="http://devsolr-proxy:8983/solr/all/select?"
ENV SOLR_READ_TIMEOUT="6000"
ENV SOLR_CONNECTION_TIMEOUT="6000"
ENV SOLR_SHOW_STUB_DATA_SERVICE_NOT_AVAILABLE="true"
ENV SOLR_USERNAME="none"
ENV SOLR_PASSWORD="none"
ENV SOLR_SHOW_STUB_DATA_SERVICE_NOT_AVAILABLE="false"

RUN cd /tmp && \
  git clone https://github.com/min2ha/ukwa-ui.git && \
  cd ukwa-ui && \
  mvn package -DskipTests

RUN cd /tmp/ukwa-ui/target/ && cp marsspiders-ukwa-1.4.2.RELEASE.war ROOT.war 
	
# INSTALL TOMCAT
# RUN wget -q https://archive.apache.org/dist/tomcat/tomcat-${TOMCAT_MAJOR_VERSION}/v${TOMCAT_MINOR_VERSION}/bin/apache-tomcat-${TOMCAT_MINOR_VERSION}.tar.gz && \
#    wget -qO- https://archive.apache.org/dist/tomcat/tomcat-${TOMCAT_MAJOR_VERSION}/v${TOMCAT_MINOR_VERSION}/bin/apache-tomcat-${TOMCAT_MINOR_VERSION}.tar.gz.md5 | md5sum -c - && \
#    tar zxf apache-tomcat-*.tar.gz && \
#    rm apache-tomcat-*.tar.gz && \
#    mv apache-tomcat* tomcat && \
#    rm -rf /tomcat/webapps/examples /tomcat/webapps/docs /tomcat/webapps/ROOT

# ADD create_tomcat_admin_user.sh /create_tomcat_admin_user.sh
# ADD run.sh /run.sh
# RUN chmod +x /*.sh	

# RUN cd /tmp/ukwa-ui/target && mv ROOT.war /tomcat/webapps
# RUN rm -rf /tmp/ukwa-ui
	
EXPOSE 8080
# VOLUME /tomcat/logs
# reset entrypoint from parent image
# ENTRYPOINT []
# CMD ["/run.sh"]	



VOLUME /tmp
ADD ukwa-ui/target/ROOT.war
ENV JAVA_OPTS=""
ENTRYPOINT [ "sh", "-c", "java $JAVA_OPTS -Djava.security.egd=file:/dev/./urandom -jar /ROOT.war" ]