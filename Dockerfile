FROM openjdk:8-jdk-alpine

LABEL maintainer="test-ops"
LABEL version="1.0.0"
LABEL description="SpringBoot User Management System"

WORKDIR /app

ENV JAVA_OPTS="-Xms256m -Xmx512m"
ENV SERVER_PORT=10013
ENV TZ=Asia/Shanghai

RUN apk add --no-cache tzdata && \
    cp /usr/share/zoneinfo/${TZ} /etc/localtime && \
    echo "${TZ}" > /etc/timezone && \
    apk del tzdata

COPY test-ops-df.jar /app/test-ops-df.jar

EXPOSE ${SERVER_PORT}

ENTRYPOINT ["sh", "-c", "java ${JAVA_OPTS} -Dserver.port=${SERVER_PORT} -jar /app/test-ops-df.jar"]
