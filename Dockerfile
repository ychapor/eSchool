FROM maven:3.5.2-jdk-8-alpine AS MAVEN
WORKDIR /tmp/
COPY pom.xml .
COPY src ./src/
RUN mvn package -DskipTests

FROM openjdk:8-jdk-alpine
WORKDIR /var/eschool/
COPY --from=MAVEN /tmp/target/eschool.jar .
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "eschool.jar"]