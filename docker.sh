 #!/bin/bash
 # 源jar路径  即jenkins构建后存放的路径
  SOURCE_PATH=/var/jenkins_home/workspace
#docker 镜像/容器名字或者jar名字 这里都命名为这个
  SERVER_NAME=enjoy
  BASE_PATH=/data/docker2
 #容器id
 CID=$(docker ps | grep "$SERVER_NAME" | awk '{print $1}')
 #镜像id
 IID=$(docker images | grep "$SERVER_NAME" | awk '{print $3}')
 echo "最新构建代码 $SOURCE_PATH/$SERVER_NAME/target/cydl-0.0.1-SNAPSHOT.jar 迁移至 $BASE_PATH ...."
 #把项目从jenkins构建后的目录移动到我们的项目目录下同时重命名下
  mv /var/jenkins_home/workspace/enjoy/target/enjoy-1.0.jar /data/docker2/enjoy.jar
 #修改文件的权限
  chmod 777 /data/docker2/enjoy.jar
  echo "迁移完成"
 # 构建docker镜像
         if [ -n "$IID" ]; then
                 echo "存在$SERVER_NAME镜像，IID=$IID"
                  docker stop $SERVER_NAME   # 停止运行中的容器
                  docker rm $SERVER_NAME     ##删除原来的容器
                  docker rmi $IID   ## 删除原来的镜像

         else
                 echo "不存在$SERVER_NAME镜像，开始构建镜像"
                      
        fi       
  # 构建镜像 
  cd /data/docker2
  docker build -t $SERVER_NAME .   
# 运行容器
 # --name docker-test                 容器的名字为docker-test
 #   -d                                 容器后台运行
 #   -p 8090:8090 指定容器映射的端口和主机对应的端口都为8090
 #   -v /usr/local/dockerApp/blog-parent:/usr/local/dockerApp/blog-parent   将主机的/usr/local/dockerApp/blog-parent目录挂载到容器的/usr/local/dockerApp/blog-parent 目录中
 docker run --name $SERVER_NAME  -d -p 8090:8080 $SERVER_NAME
 echo "$SERVER_NAME容器创建完成"
