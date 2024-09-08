#!/bin/bash

# Restart Application With Docker
echo ":::: BLUE/GREEN Deploy START ::::"

IMAGE_NAME="blue-green-image"
CONTAINER_NAME="blue-green-container"

echo "Delete Image"
sudo docker rim $IMAGE_NAME:latest

echo "Create Image"
sudo docker build -t $IMAGE_NAME .

echo "Check Docker Running '$CONTAINER_NAME'"

# Blue 를 기준으로 현재 떠있는 컨테이너를 체크한다.
CONTAINER_ID=$(sudo docker ps -q -f name=${CONTAINER_NAME}-blue)

if [ -n "$CONTAINER_ID" ]; then  # IF BLUE RUN -> GREEN RUN
  echo "START GREEN"
  sudo docker compose -f docker-compose.green.yml up -d
  BEFORE_COMPOSE_COLOR="blue"
  AFTER_COMPOSE_COLOR="green"
else # IF BLUE NOT RUN -> RUN BLUE
    echo "START BLUE"
    sudo docker compose -f docker-compose.blue.yml up -d
    BEFORE_COMPOSE_COLOR="green"
    AFTER_COMPOSE_COLOR="blue"
fi

# 어떤 배포가 실행 되는지 확인
echo  "$BEFORE_COMPOSE_COLOR -> $AFTER_COMPOSE_COLOR"

# 새로운 컨테이너가 제대로 떴는지 확인
# EXIST_AFTER=$(sudo docker ps -q -f name=${CONTAINER_NAME}-${AFTER_COMPOSE_COLOR})
EXIST_AFTER=$(docker ps -q -f name=${CONTAINER_NAME}-${AFTER_COMPOSE_COLOR})

if [ -n "EXIST_AFTER" ]; then
  echo "SET NginX ${AFTER_COMPOSE_COLOR}"
  sudo cp ./nginx-${AFTER_COMPOSE_COLOR}.conf /opt/homebrew/etc/nginx/nginx.conf
  sudo nginx -s reload

  echo "DOWN Container : docker-compose.${BEFORE_COMPOSE_COLOR}.yml"
  # docker compose -p ${CONTAINER_NAME}-${BEFORE_COMPOSE_COLOR} -f docker-compose.${BEFORE_COMPOSE_COLOR}.yml down
  docker compose -f docker-compose.${BEFORE_COMPOSE_COLOR}.yml down

  # 미사용 이미지 삭제
  # docker image prune -a -f
  # 미 사용 컨테이너 삭제
  docker container prune -f
  # 미 사용 네트워크 삭제
  docker network prune -f
  # 미 사용 볼륨 삭제
  docker volume prune -f

  echo "$BEFORE_COMPOSE_COLOR down"
fi

echo ":::: BLUE/GREEN Deploy END ::::"