
FROM openjdk:11
EXPOSE 8082
ADD target/classes.jar springprojet.jar
ENTRYPOINT ["java","-jar","/springprojet.jar"]
