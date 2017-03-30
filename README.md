Container to easily set up Interactive Brokers Gateway in a headless environment.

## Quick Usage
This assumes some basic working knowledge of Docker. The (getting started)[https://docs.docker.com/engine/getstarted/] tutorial is the fastest way to learn the basics.

1) Check out the repo.

2) `docker build -t <pick-a-name> .` from within the repo. You should build your own image rather than use one on dockerhub for security reasons.

3) Set your own environment variables as necessary in `docker-compose.yml`. This likely includes copying a `jts.ini` file in from a computer you have used IB on already.

4) `docker-compose up`

5) The IB API is now available from your host on `127.0.0.1:4003`

### Configuration
`IBController.ini` and `jts.ini` are mounted as volumes from the host into the docker container. You can configure them from the host, launch docker and the settings will be available in the container.

### Ports
Port 4001 is hard-coded as the IB port from *within the container*.
Port 4003 is hard-coded as the API port, accessible from host.

In order for docker to bind a port from the host into the container, the service must be running on 0.0.0.0:<port> from within the container. `socat` is used to bind 0.0.0.0:4003 onto the same process launched by `IBController`.

In future these should be set by environment variables, but running into issues where we try to use the same port for both.

### VNC
Some work has been done to set up VNC into the xvfb session, but I have not found it necessary and will likely remove it soon.
