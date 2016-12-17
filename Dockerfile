FROM ubuntu:16.04
MAINTAINER Ryan Kennedy <hello@ryankennedy.io>

RUN  apt-get update \
  && apt-get install -y wget \
  && apt-get install -y unzip \
  && apt-get install -y xvfb \
  && apt-get install -y libxtst6 \
  && apt-get install -y libxrender1 \
  && apt-get install -y libxi6 \
  && apt-get install -y socat \
  && apt-get install -y software-properties-common

# Setup IB TWS
RUN mkdir -p /opt/TWS
WORKDIR /opt/TWS
RUN wget -q http://data.quantconnect.com/interactive/ibgateway-latest-standalone-linux-x64-v960.2a.sh
RUN chmod a+x ibgateway-latest-standalone-linux-x64-v960.2a.sh

# Setup  IBController
RUN mkdir -p /opt/IBController/
WORKDIR /opt/IBController/
RUN wget -q http://data.quantconnect.com/interactive/IBController-QuantConnect-3.2.0.zip
RUN unzip ./IBController-QuantConnect-3.2.0.zip
RUN chmod -R u+x *.sh && chmod -R u+x Scripts/*.sh

# Install Java 8
RUN \
  echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | debconf-set-selections && \
  add-apt-repository -y ppa:webupd8team/java && \
  apt-get update && \
  apt-get install -y oracle-java8-installer && \
  rm -rf /var/lib/apt/lists/* && \
  rm -rf /var/cache/oracle-jdk8-installer

WORKDIR /

# Install TWS
RUN yes n | /opt/TWS/ibgateway-latest-standalone-linux-x64-v960.2a.sh

#CMD yes

# Launch a virtual screen
RUN Xvfb :1 -screen 0 1024x768x24 2>&1 >/dev/null &
RUN export DISPLAY=:1

ADD runscript.sh runscript.sh
CMD bash runscript.sh
