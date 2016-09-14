# AYB: Intel Snap telemetry
# AYB: Version 0.0.1
#
# 0.0.1: initial commit (snap v0.15.0_beta)


FROM golang:latest


MAINTAINER Ayoub Boulila <ayoubboulila@gmail.com>

ENV GOPATH=$GOPATH:/app SNAP_PATH=/go/src/github.com/intelsdi-x/snap/build \
    TRUST=0 TRIBEPORT=6001 APIPORT=8181 SEEDIP=127.0.0.1 SEEDPORT=6000

WORKDIR /go/src/github.com/intelsdi-x/

RUN apt-get update && \
    apt-get -y install facter && \
    apt-get -y install nano && \
    go get github.com/tools/godep && \
    go get golang.org/x/tools/cmd/goimports && \
    go get golang.org/x/tools/cmd/cover && \
    go get github.com/smartystreets/goconvey && \
    cd /go/src/github.com/intelsdi-x/ && \
    git clone https://github.com/intelsdi-x/gomit.git && \
    git clone https://github.com/intelsdi-x/snap-plugin-collector-docker.git && \
    cd /go/src/github.com/intelsdi-x/snap-plugin-collector-docker && \
    git checkout 615d4260b824f326b273e60c6b4270d34c3445d4 && \
    make && \
    git clone https://github.com/intelsdi-x/snap.git && \
    cd /go/src/github.com/intelsdi-x/snap/ && \
    git checkout c78752606ed2d27df26ed767a1d6f0b55be0359e && \
    scripts/deps.sh && \
    make && \
    mkdir /opt/snap && \
    mv /go/src/github.com/intelsdi-x/snap/build/* /opt/snap/ && \
    mv /go/src/github.com/intelsdi-x/snap-plugin-collector-docker/build/rootfs/snap-plugin-collector-docker /opt/snap/plugin/ && \
    apt-get clean autoclean && \
    apt-get autoremove
ADD ./startup.sh /opt/snap/startup.sh
RUN chmod +x /opt/snap/startup.sh
ENV PATH $PATH:/opt/snap/bin

# Ports
EXPOSE 8181 6001 6000




# EXEC

#ENTRYPOINT ["/opt/snap/bin/snapd", "--api-port", "8181", "--log-level", "1", "-t", "0" ]
CMD ["run"]
ENTRYPOINT ["/opt/snap/startup.sh"]
