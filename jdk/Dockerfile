FROM centos:7
MAINTAINER malaian

# 新建目录
RUN mkdir /usr/local/java
# 将jdk文件拷贝到容器/usr/local/java/并解压
ADD jdk-8u201-linux-x64.tar.gz /usr/local/java/

# 软连接
RUN ln -s /usr/local/java/jdk1.8.0_201 /usr/local/java/jdk

# 设置环境变量
ENV JAVA_HOME /usr/local/java/jdk
ENV JRE_HOME ${JAVA_HOME}/jre
ENV CLASSPATH .:${JAVA_HOME}/lib:${JRE_HOME}/lib
ENV PATH ${JAVA_HOME}/bin:$PATH
