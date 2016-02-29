FROM debian:jessie 

RUN apt-get update && \
    apt-get install -y --no-install-recommends ca-certificates iptables curl strace file && \
    rm -rf /var/lib/apt/lists/* 
RUN curl -f -L --create-dirs -o /usr/local/bin/dumb-init https://github.com/Yelp/dumb-init/releases/download/v1.0.0/dumb-init_1.0.0_amd64 && \
    chmod +x /usr/local/bin/dumb-init && \
    dumb-init -V
#RUN curl -f -s -L -o /usr/local/bin/concourse https://github.com/concourse/concourse/releases/download/v0.74.0/concourse_linux_amd64 && \
#    chmod +x /usr/local/bin/concourse
ADD build/concourse_linux_amd64 /usr/local/bin/concourse
ADD init.sh /init.sh
ENTRYPOINT ["/usr/local/bin/dumb-init", "-c", "--", "/init.sh"]
CMD ["/bin/bash"]
