FROM openjdk:8-jre-alpine

WORKDIR /
ARG VER=0.0.2
ENV VER ${VER}
ADD ./target/*-${VER}-*.jar /opt/lib/devops-project.jar
EXPOSE 80
ENTRYPOINT ["java", "-Xmx512m","-Xss16m","-jar", "-Dconsole.level=INFO", "/opt/lib/devops-project.jar"]
