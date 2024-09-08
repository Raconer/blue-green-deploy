FROM openjdk:22-ea-19-jdk
WORKDIR /app
COPY ./build/libs/blue-green-0.0.1-SNAPSHOT.jar /app/blue-green.jar
ENV TIME_ZONE=Asia/Seoul
RUN mkdir -p ./logs
CMD ["java", "-Duser.timezone=${TIME_ZONE}", "-Ddeploy.type=${DEPLOY_TYPE}",  "-jar", "blue-green.jar"]