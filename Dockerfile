FROM ubuntu:20.04
LABEL maintainer="jeroen@magehost.pro"

ENV container docker LANG=C.UTF-8

# Don't start any optional services except for the few we need.
RUN  find /etc/systemd/system \
     /lib/systemd/system \
     -path '*.wants/*' \
     -not -name '*journald*' \
     -not -name '*systemd-tmpfiles*' \
     -not -name '*systemd-user-sessions*' \
     -exec rm \{} \;

RUN  apt-get  update  && \
     apt-get  install  --no-install-recommends  -y \
       dbus systemd systemd-cron iproute2 wget sudo bash ca-certificates  && \
     apt-get  clean  && \
     rm  -rf  /var/lib/apt/lists/*  /tmp/*  /var/tmp/*

RUN  systemctl  set-default  multi-user.target
RUN  systemctl  mask  dev-hugepages.mount  sys-fs-fuse-connections.mount

COPY setup /sbin/

STOPSIGNAL SIGRTMIN+3

CMD ["/sbin/init", "--log-target=journal"]
