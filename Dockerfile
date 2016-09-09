# AYB: Intel Snap telemetry 
# AYB: Version 0.0.1
#
# 0.0.1: initial commit (snap v0.15.0_beta)


FROM golang:latest


MAINTAINER Ayoub Boulila <ayoubboulila@gmail.com>

ENV GOPATH=$GOPATH:/app
ENV SNAP_PATH=/go/src/github.com/intelsdi-x/snap/build
RUN apt-get update && \
    apt-get -y install facter && \
    apt-get -y install nano && \
    apt-get clean
RUN go get github.com/tools/godep && \
    go get golang.org/x/tools/cmd/goimports && \
    go get golang.org/x/tools/cmd/cover && \
    go get github.com/smartystreets/goconvey

WORKDIR /go/src/github.com/intelsdi-x/
RUN git clone https://github.com/intelsdi-x/gomit.git \
    && git clone https://github.com/intelsdi-x/snap-plugin-collector-docker.git
WORKDIR /go/src/github.com/intelsdi-x/snap-plugin-collector-docker
RUN git checkout 615d4260b824f326b273e60c6b4270d34c3445d4 \
    && make \
    && git clone https://github.com/intelsdi-x/snap.git
WORKDIR /go/src/github.com/intelsdi-x/snap/
RUN git checkout c78752606ed2d27df26ed767a1d6f0b55be0359e

#RUN scripts/deps.sh
#RUN make
#WORKDIR /go/src/github.com/intelsdi-x/snap/
RUN scripts/deps.sh \
    && make \
    && mkdir /opt/snap \ 
    && mv /go/src/github.com/intelsdi-x/snap/build/* /opt/snap/ \
    && mv /go/src/github.com/intelsdi-x/snap-plugin-collector-docker/build/rootfs/snap-plugin-collector-docker /opt/snap/plugin/ 

#WORKDIR /go/src/github.com/intelsdi-x/snap-plugin-collector-docker/build/
#RUN cp rootfs/snap-plugin-collector-docker /opt/snap/plugin/

ENV PATH $PATH:/opt/snap/bin

# Ports
EXPOSE 8181




# EXEC

ENTRYPOINT ["/opt/snap/bin/snapd", "--api-port", "8181", "--log-level", "1", "-t", "0" ]
