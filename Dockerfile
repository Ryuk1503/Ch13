# Build stage - updated 2025-12-02
FROM maven:3.9-eclipse-temurin-17 AS build
WORKDIR /app
COPY ch13_ex1_email/pom.xml .
COPY ch13_ex1_email/src ./src
RUN mvn clean package -DskipTests

# Runtime stage
FROM tomcat:10.1-jdk17
# Remove default webapps
RUN rm -rf /usr/local/tomcat/webapps/*
# Copy WAR file
COPY --from=build /app/target/ch13_ex1_email.war /usr/local/tomcat/webapps/ROOT.war
# Copy entrypoint script
COPY docker-entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/docker-entrypoint.sh
# Expose port
EXPOSE 8080
# Start with custom entrypoint
ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]
