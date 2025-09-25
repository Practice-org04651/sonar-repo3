# ======================
# Stage 1: Build
# ======================
FROM maven:3.8.7-eclipse-temurin-17 AS builder

# Set working directory
WORKDIR /app

# Copy Maven project files
COPY pom.xml .
COPY src ./src

# Package the application
RUN mvn clean package -DskipTests

# ======================
# Stage 2: Runtime
# ======================
FROM eclipse-temurin:17-jdk-alpine

# Set working directory
WORKDIR /app

# Copy only the built jar from the builder stage
COPY --from=builder /app/target/*.jar app.jar

# Expose port (change as per your Spring Boot app configuration)
EXPOSE 8080

# Run the application
ENTRYPOINT ["java", "-jar", "app.jar"]

