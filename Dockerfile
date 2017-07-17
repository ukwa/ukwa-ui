FROM frolvlad/alpine-oraclejdk8:slim
MAINTAINER Mindaugas Vidmantas "mindaugas.vidmantas@bl.uk"
VOLUME /tmp
ADD marsspiders-ukwa-1.4.2.RELEASE.jar app.jar
RUN sh -c 'touch /app.jar'
ENV JAVA_OPTS=""
ENTRYPOINT [ "sh", "-c", "java $JAVA_OPTS -Djava.security.egd=file:/dev/./urandom -jar /app.jar" ]
