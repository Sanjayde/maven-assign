FROM openjdk:8-jdk-alpine
ARG JAR_FILE=/var/lib/jenkins/workspace/maven-pipeline/target/*.jar
COPY /var/lib/jenkins/workspace/maven-pipeline/target/gs-spring-boot-docker-0.1.0.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java","-jar","/app.jar"]
