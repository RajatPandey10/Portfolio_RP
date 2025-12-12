
FROM maven:3.9.6-eclipse-temurin-17 AS builder

WORKDIR /app

# Copy Spring Boot project files
COPY personalportfolio/pom.xml .
COPY personalportfolio/src ./src

# Build the jar (skip tests for faster build)
RUN mvn clean package -DskipTests



FROM eclipse-temurin:17-jre

WORKDIR /app

# Copy built jar from builder
COPY --from=builder /app/target/*.jar app.jar

# Expose your application port
EXPOSE 9090

# Run the Spring Boot application
ENTRYPOINT ["java", "-jar", "app.jar"]



#  docker updated