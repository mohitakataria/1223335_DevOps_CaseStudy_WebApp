FROM tomcat:8.0-alpine

MAINTAINER "mohita.kataria@gmail.com"

VOLUME /tmp

EXPOSE 8800

COPY target/*.war /usr/local/tomcat/webapps/

RUN echo "Creation of your docker image is in progress"

CMD ["catalina.sh", "run"]