FROM maven:3.9.9-sapmachine-17 AS build
WORKDIR /app
COPY . .
RUN mvn install -DskipTests=true

# Runtime Stage (Java 17)
FROM eclipse-temurin:17-jre-alpine
WORKDIR /run
COPY --from=build /app/target/product-service-0.0.1-SNAPSHOT.jar product-service.jar

EXPOSE 8080
ENTRYPOINT ["java", "-jar", "product-service.jar"]

~                                                                           ~                                                            
