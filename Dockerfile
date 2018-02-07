FROM ubuntu:16.04

USER root

RUN apt-get update && \
 apt-get install -y wget unzip git npm  nodejs-legacy python-webtest python-pip default-jdk && \
 wget https://storage.googleapis.com/appengine-sdks/featured/google_appengine_1.9.38.zip && \
 unzip google_appengine_1.9.38.zip && \
 echo "export PATH=$PATH:$PWD/google_appengine" >> ~/.bash_profile && \
 . ~/.bash_profile && \
 export PATH=$PATH:/path/to/google_appengine/ && \
 npm -g install grunt-cli && \
 mkdir -p WebRTC && \
 cd  WebRTC && \
 git clone https://github.com/webrtc/apprtc.git && \
 cd apprtc && \
 pip install requests && \
 npm install && \
 grunt build

ADD run.sh /run.sh 
RUN chmod 755 /run.sh 

RUN apt-get install -y curl && \
    curl -O https://storage.googleapis.com/golang/go1.6.linux-amd64.tar.gz && \
    tar -xvf go1.6.linux-amd64.tar.gz && \
    mv go /usr/local && \
    echo "export PATH=$PATH:/usr/local/go/bin" >> ~/.bash_profile && \
    cd WebRTC && \
    mkdir -p /WebRTC/collider_root && \
    mkdir -p /WebRTC/collider_root/src && \
    echo "export GOPATH=/WebRTC/collider_root" >> ~/.bash_profile && \
    echo "export GOROOT=/usr/local/go" >> ~/.bash_profile && \
    . ~/.bash_profile && \
    ln -s /WebRTC/apprtc/src/collider/collider $GOPATH/src/ && \
    ln -s /WebRTC/apprtc/src/collider/collidermain $GOPATH/src/ && \
    ln -s /WebRTC/apprtc/src/collider/collidertest $GOPATH/src/ && \
    go get collidermain && \
    go install collidermain

EXPOSE 8080

ENTRYPOINT ["/bin/bash","-c","/run.sh"]
