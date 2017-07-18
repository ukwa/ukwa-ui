FROM frolvlad/alpine-oraclejdk8:slim
MAINTAINER Mindaugas Vidmantas "mindaugas.vidmantas@bl.uk"
VOLUME /tmp
ADD marsspiders-ukwa-1.4.2.RELEASE.war app.war
RUN sh -c 'touch /app.war'
ENV JAVA_OPTS=""
ENV SOLR_USERNAME="none"
ENV SOLR_PASSWORD="none"
ENTRYPOINT [ "sh", "-c", "java $JAVA_OPTS -Djava.security.egd=file:/dev/./urandom -jar /app.jar" ]
