#FROM openjdk:17-jdk-slim
# 使用阿里云公共仓库代理拉取 Temurin
FROM registry.cn-hangzhou.aliyuncs.com/library/eclipse-temurin:17-jdk-slim
WORKDIR /app
COPY target/*.jar app.jar
ENV TZ=Asia/Shanghai
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
EXPOSE 8080
ENTRYPOINT ["java", "-Xms256m", "-Xmx512m", "-jar", "app.jar"]
