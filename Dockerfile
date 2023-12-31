#
# Build stage
#
FROM maven:3.9.3-jdk-19 AS build
COPY . .
RUN mvn clean package -Pprod -DskipTests

#
# Package stage
#
FROM openjdk:19-jdk-slim
COPY --from=build /target/vehicle-0.0.1-SNAPSHOT.jar vehicle.jar
# ENV PORT=8080
EXPOSE 8080
ENTRYPOINT ["java","-jar","/vehicle.jar"]

