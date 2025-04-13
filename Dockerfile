# Sử dụng image Java 17 từ Docker Hub
FROM openjdk:17-jdk-slim as builder

# Đặt thư mục làm việc trong container
WORKDIR /app

# Sao chép các file Maven (hoặc Gradle) vào container
COPY . .

# Cài đặt dependencies của ứng dụng
RUN mvn dependency:go-offline

# Sao chép mã nguồn vào container
COPY src ./src

# Build ứng dụng
RUN mvn clean package -DskipTests

# Tạo image mới từ một base image chứa JDK để chạy ứng dụng
FROM openjdk:17-jdk-slim

# Đặt thư mục làm việc
WORKDIR /app

# Sao chép file jar đã build vào container
COPY --from=builder /app/target/product-service-0.0.1-SNAPSHOT.jar /app/your-app.jar

# Mở port mà ứng dụng sẽ chạy
EXPOSE 8081

# Lệnh chạy ứng dụng
CMD ["java", "-jar", "your-app.jar"]
