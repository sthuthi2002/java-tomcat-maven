# Stage 1: Build the WAR file using Maven
FROM maven:3.9.9-eclipse-temurin-17 AS build
WORKDIR /app

# Copy pom.xml and source code
COPY pom.xml .
COPY src ./src

# Build WAR
RUN mvn clean package -DskipTests

# Stage 2: Run the WAR in Tomcat
FROM tomcat:9.0-jdk17
LABEL maintainer="you@example.com"

# Remove default ROOT webapp
RUN rm -rf /usr/local/tomcat/webapps/ROOT

# Copy built WAR from previous stage
COPY --from=build /app/target/java-tomcat-maven-example.war /usr/local/tomcat/webapps/ROOT.war

# Expose Tomcat port
EXPOSE 8080

# Start Tomcat
CMD ["catalina.sh", "run"]
