
FROM alpine:3.19.1

RUN apk add openjdk8

WORKDIR /run
COPY --from=build /app/target/ product-service-0.0.1-SNAPSHOT.jar  /run/product-service-0.0.1-SNAPSHOT.jar

EXPOSE 8080

ENTRYPOINT ["java", "-jar", "product-service-0.0.1-SNAPSHOT.jar"]  
