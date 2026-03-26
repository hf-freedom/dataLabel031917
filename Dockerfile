# 使用 OpenJDK 8 作为基础镜像
FROM openjdk:8-jre-slim

# 设置工作目录
WORKDIR /app

# 设置时区
ENV TZ=Asia/Shanghai
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# 复制 JAR 包到容器中
COPY test-ops-df.jar app.jar

# 暴露应用端口
EXPOSE 8080

# 配置 JVM 参数
ENV JAVA_OPTS="-Xms256m -Xmx512m -Djava.security.egd=file:/dev/./urandom"

# 启动命令
ENTRYPOINT ["sh", "-c", "java $JAVA_OPTS -jar app.jar"]
