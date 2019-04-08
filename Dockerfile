FROM phusion/baseimage:0.9.22

MAINTAINER Giulio Giraldi <dongiulio@gmail.com>

# from https://github.com/QuantConnect/Lean/blob/master/DockerfileLeanFoundation

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]

# Have to add env TZ=UTC. See https://github.com/dotnet/coreclr/issues/602
RUN env TZ=UTC

# Install OS Packages:
# Misc tools for running Python.NET and IB inside a headless container.
RUN apt-get update && \
    apt-get install -y git bzip2 unzip wget python3-pip python-opengl  socat netcat && \
    apt-get install -y clang cmake curl xvfb libxrender1 libxtst6 libxi6 libglib2.0-dev && \
# Install R
    apt-get install -y r-base pandoc libcurl4-openssl-dev

# Java for running IB inside container:
# https://github.com/dockerfile/java/blob/master/oracle-java8/Dockerfile
RUN echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | debconf-set-selections && \
    add-apt-repository -y ppa:webupd8team/java && \
    apt-get update && apt-get install -y oracle-java8-installer && \
    rm -rf /var/lib/apt/lists/* && rm -rf /var/cache/oracle-jdk8-installer

# Install IB Gateway: Installs to ~/Jts
RUN wget http://cdn.quantconnect.com/interactive/ibgateway-latest-standalone-linux-x64-v974.4g.sh && \
    chmod 777 ibgateway-latest-standalone-linux-x64-v974.4g.sh && \
    ./ibgateway-latest-standalone-linux-x64-v974.4g.sh -q && \
    wget -O ~/Jts/jts.ini http://cdn.quantconnect.com/interactive/ibgateway-latest-standalone-linux-x64-v974.4g.jts.ini && \
    rm ibgateway-latest-standalone-linux-x64-v974.4g.sh

# Install IB Controller: Installs to ~/IBController
RUN wget http://cdn.quantconnect.com/interactive/IBController-QuantConnect-3.2.0.5.zip && \
    unzip IBController-QuantConnect-3.2.0.5.zip -d ~/IBController && \
    chmod -R 777 ~/IBController && \
    rm IBController-QuantConnect-3.2.0.5.zip

WORKDIR /

#CMD yes

# Launch a virtual screen
RUN Xvfb :1 -screen 0 1024x768x24 2>&1 >/dev/null &
RUN export DISPLAY=:1

ADD runscript.sh runscript.sh
CMD bash runscript.sh
