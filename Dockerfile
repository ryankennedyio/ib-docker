FROM ubuntu:16.04
MAINTAINER Ryan Kennedy <hello@ryankennedy.io>

RUN  apt-get update \
  && apt-get install -y wget \
  && apt-get install -y unzip

# Download IB Gateway 952
RUN wget -q https://download2.interactivebrokers.com/installers/tws/latest-standalone/tws-latest-standalone-linux-x64.sh
RUN wget -q https://github.com/ib-controller/ib-controller/releases/download/3.2.0/IBController-3.2.0.zip

RUN unzip IBController-3.2.0.zip -d /opt/IBController
RUN chmod -R u+x /opt/IBController/*.sh
