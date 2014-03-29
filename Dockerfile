FROM        ubuntu
MAINTAINER  Luis Elizondo lelizondo@gmail.com
 
# Update apt sources
RUN echo "deb http://archive.ubuntu.com/ubuntu precise main universe" > /etc/apt/sources.list

# Update the package repository
RUN apt-get -qq update

# Install base system
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y varnish vim git

# Make our custom VCLs available on the container
ADD default.vcl /etc/varnish/default.vcl

ENV VARNISH_BACKEND_PORT 80
ENV VARNISH_BACKEND_IP 172.17.42.1
ENV VARNISH_PORT 80

ENV NODE1 172.17.0.3
ENV NODE_PORT 3000
ENV NODE2 172.17.0.4

# Expose port 80
EXPOSE 80

ADD start /start
RUN chmod 0755 /start
CMD ["/start"]
