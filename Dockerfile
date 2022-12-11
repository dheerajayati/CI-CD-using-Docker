FROM tomcat:latest

LABEL maintainer="Dheeraj Ayati"

ADD ./target/LoginWebApp-1.war /usr/local/tomcat/webapps/

EXPOSE 9004

CMD ["catalina.sh", "run"]
