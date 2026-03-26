#!/bin/bash
cd /opt/apps/test-hf-ops

echo '=== 1. 停止并删除旧容器 ==='
OLD_CONTAINER=$(docker ps -a -q -f name=test-ops-df)
if [ -n "$OLD_CONTAINER" ]; then
    docker stop $OLD_CONTAINER
    docker rm $OLD_CONTAINER
fi

echo '=== 2. 删除旧镜像 ==='
OLD_IMAGE=$(docker images -q test-ops-df:latest)
if [ -n "$OLD_IMAGE" ]; then
    docker rmi $OLD_IMAGE
fi

echo '=== 3. 清理端口占用 ==='
PORT_PID=$(lsof -t -i:10013 2>/dev/null || echo '')
if [ -n "$PORT_PID" ]; then
    kill -9 $PORT_PID
fi

echo '=== 4. 构建新Docker镜像 ==='
docker build -t test-ops-df:latest .

echo '=== 5. 启动新容器 ==='
docker run -d --name test-ops-df -p 10013:10013 --restart=always test-ops-df:latest

echo '=== 部署完成 ==='
