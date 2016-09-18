FROM ubuntu:16.04
MAINTAINER Ryan Kennedy <hello@ryankennedy.io>

RUN  apt-get update \
  && apt-get install -y wget \
  && apt-get install -y unzip \
  && apt-get install -y xvfb

# Setup IB TWS/Gateway
RUN mkdir -p /opt/IB/tws
WORKDIR /opt/IB/tws
RUN wget -q https://download2.interactivebrokers.com/installers/tws/latest-standalone/tws-latest-standalone-linux-x64.sh
RUN chmod a+x tws-latest-standalone-linux-x64.sh

#Set up  IBController
RUN mkdir -p /opt/IB/ibcontroller
WORKDIR /opt/IB/ibcontroller

RUN wget -q https://github.com/ib-controller/ib-controller/releases/download/3.2.0/IBController-3.2.0.zip
RUN unzip ./IBController-3.2.0.zip

WORKDIR /

# Install TWS
RUN yes n | /opt/IB/tws/tws-latest-standalone-linux-x64.sh
