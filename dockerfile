
FROM openjdk:11
EXPOSE 8082
ADD target/*.jar devops.jar
ENTRYPOINT ["java","-jar","/devops.jar"]
