FROM debian:stretch
ENV VERSION 2.3.7
MAINTAINER Ahmed <ahmed@okda.space>

RUN DEBIAN_FRONTEND=noninteractive apt-get update && apt-get install -y btrfs-tools apt-utils \
	sqlite3 libcurl3 lsb-release libcurl3-gnutls apt-utils libfuse2 \
	&& apt-get clean && rm -rf /var/lib/apt/lists/*
ADD https://hndl.urbackup.org/Server/${VERSION}/urbackup-server_${VERSION}_amd64.deb /root/install.deb
RUN DEBIAN_FRONTEND=noninteractive echo /var/urbackup | dpkg -i /root/install.deb && rm /root/install.deb
RUN DEBIAN_FRONTEND=noninteractive apt install -f
EXPOSE 55413
EXPOSE 55414
EXPOSE 55415
EXPOSE 35623
COPY start /usr/bin/start
VOLUME [ "/var/urbackup", "/var/log", "/usr/share/urbackup" ]
ENTRYPOINT ["/usr/bin/start"]
CMD ["run"]
