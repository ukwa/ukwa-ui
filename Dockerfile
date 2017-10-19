FROM openjdk:8

# originally based on UNB Libraries Dockerfile
MAINTAINER Mindaugas Vidmantas "mindaugas.vidmantas@bl.uk"

# Add cerificates that ensure download of dependencies works:
RUN         apt-get install -y ca-certificates-java && \
            update-ca-certificates
# update packages and install maven
RUN \
  export DEBIAN_FRONTEND=noninteractive && \
  sed -i 's/# \(.*multiverse$\)/\1/g' /etc/apt/sources.list && \
  apt-get update && \
  apt-get -y upgrade && \
  apt-get install -y tar wget git maven

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
  git clone https://github.com/ukwa/ukwa-ui.git && \
  cd ukwa-ui && \
  mvn package -DskipTests

VOLUME /tmp
WORKDIR /tmp/ukwa-ui/target/

ENTRYPOINT ["java","-Djava.security.egd=file:/dev/./urandom","-jar","marsspiders-ukwa-1.4.2.RELEASE.war"]
EXPOSE 8080
