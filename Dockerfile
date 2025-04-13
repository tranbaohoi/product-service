FROM maven:3.5.3-jdk-8-alpine AS build

WORKDIR /app
COPY . .
RUN mvn install -DskipTests=true

FROM alpine:3.19

RUN apk add openjdk8

WORKDIR /run
COPY --from=build /app/target/ product-service-0.0.1-SNAPSHOT.jar  /run/product-service-0.0.1-SNAPSHOT.jar

EXPOSE 8080

ENTRYPOINT ["java", "-jar", "product-service-0.0.1-SNAPSHOT.jar"]  
