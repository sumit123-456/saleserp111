# Stage 1: Build
FROM maven:3.9.6-eclipse-temurin-17 AS build
WORKDIR /app

# Copy pom.xml from SlaesErp folder
COPY SlaesErp/pom.xml .

# Copy backend source
COPY SlaesErp/. .

# Build jar
RUN mvn -B package -DskipTests

# Stage 2: Run
FROM eclipse-temurin:17-jre
WORKDIR /app

COPY --from=build /app/target/*.jar app.jar

EXPOSE 8080
CMD ["java", "-jar", "app.jar"]
