# AYB: Intel Snap telemetry
# AYB: Version 0.0.1
#
# 0.0.1: initial commit (snap v0.15.0_beta)


FROM golang:latest


MAINTAINER Ayoub Boulila <ayoubboulila@gmail.com>

ENV GOPATH=$GOPATH:/app SNAP_PATH=/opt/snap PATH=$PATH:/opt/snap/bin

WORKDIR /home
ADD resources/bin.zip /home/resources/bin.zip
ADD resources/bin.zip /home/resources/plugin1.zip
ADD resources/bin.zip /home/resources/plugin2.zip

RUN tar -xzvf /home/resources/bin.zip && \
    mv /home/resources/snap /opt/ && \
    tar -xzvf /home/resources/plugin1.zip && \
    tar -xzvf /home/resources/plugin2.zip && \
    mv /home/resources/plugin/snap-plugin-collector-docker /opt/snap/plugin/ && \
    mv /home/resources/plugin/snap-plugin-publisher-influxdb /opt/snap/plugin/ && \

ADD startup.sh /opt/snap/starup.sh

# Ports
EXPOSE 8181 6000 6001




# EXEC
CMD ["run"]
ENTRYPOINT ["/opt/snap/startup.sh"]
