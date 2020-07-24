###指定java8环境镜像
FROM jdk1.8
###复制文件到容器app-springboot
ADD enjoy.jar enjoy.jar
###声明启动端口号
EXPOSE 8080
###配置容器启动后执行的命令
ENTRYPOINT ["java","-jar","enjoy.jar"]