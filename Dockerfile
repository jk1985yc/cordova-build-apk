FROM centos:latest

# 安裝常用命令
RUN yum install -y curl wget zip unzip tar sudo
#&& yum install -y lsof \
#&& yum install -y git

#設定工作目錄
ADD ./cordova /home
WORKDIR /home
# 拷貝JDK、android tools安裝包到容器中
COPY tools/* /tmp/

# 安裝NODEJS
RUN curl -sL https://rpm.nodesource.com/setup_10.x | sudo -E bash - && yum install -y nodejs
# 安裝CORDOVA
RUN npm install -g cordova
# 安裝GRADLE
#RUN wget https://services.gradle.org/distributions/gradle-5.2.1-bin.zip -P /tmp && unzip -d /opt/gradle /tmp/gradle-*.zip
RUN unzip -d /opt/gradle /tmp/gradle-5.6.3-all.zip

# 安裝JDK
RUN mkdir -p /usr/java \
&& tar xvf /tmp/jdk-8u221-linux-x64.tar.gz -C /usr/java

# 設定JAVA_HOME、ANDROID_HOME、GRADLE環境變量
ENV JAVA_HOME /usr/java/jdk1.8.0_221
ENV ANDROID_HOME /opt/app/android-sdk
ENV ANDROID_SDK_ROOT /opt/app/android-sdk
ENV GRADLE_HOME /opt/gradle/gradle-5.6.3
ENV PATH ${GRADLE_HOME}/bin:${PATH}

# 解壓android tools
RUN mkdir -p /opt/app/android-sdk && unzip -d /opt/app/android-sdk /tmp/sdk-tools-linux-4333796.zip

# 安裝需要的platforms和build-tools版本
RUN yes | /opt/app/android-sdk/tools/bin/sdkmanager "platforms;android-28"
#RUN yes | /opt/app/android-sdk/tools/bin/sdkmanager "platforms;android-27"
RUN yes | /opt/app/android-sdk/tools/bin/sdkmanager "platforms;android-23"
#RUN yes | /opt/app/android-sdk/tools/bin/sdkmanager "build-tools;29.0.4"
RUN yes | /opt/app/android-sdk/tools/bin/sdkmanager "build-tools;28.0.3"
#RUN yes | /opt/app/android-sdk/tools/bin/sdkmanager "build-tools;27.0.3"

#install node_modules
#RUN cd /home/src-cordova && npm install
#RUN cd /home && npm install

#BUILD APK
RUN npm run cordova-build-android
CMD npm run cordova-build-android
