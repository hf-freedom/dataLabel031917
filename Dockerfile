FROM openjdk:8-jre-alpine

LABEL maintainer="dev@example.com"
LABEL description="SpringBoot Application - User Management System"

WORKDIR /app

EXPOSE 10013

ENV JAVA_OPTS="-Xms256m -Xmx512m"
ENV SERVER_PORT=10013

COPY test-ops-df.jar /app/test-ops-df.jar

RUN ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && echo 'Asia/Shanghai' > /etc/timezone

ENTRYPOINT ["sh", "-c", "java $JAVA_OPTS -Djava.security.egd=file:/dev/./urandom -jar /app/test-ops-df.jar"]
