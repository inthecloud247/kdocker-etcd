FROM inthecloud247/kdocker-base
MAINTAINER inthecloud247 "inthecloud247@gmail.com"

ENV LAST_UPDATED 2013-12-26

# copy required conf files and folders
# ADD setupfiles/ /setupfiles/

# standard directory setup
RUN \
  `# Create cache directory`; \
  DIR_CACHE="/setupfiles/cache/"; \
  mkdir -vp $DIR_CACHE; \

# put custom commands here
RUN \
  `# Install etcd`; \
  mkdir -vp /opt/etcd/; \
  DL_PROTO="https://"; \
  DL_FILE="github.com/coreos/etcd/releases/download/v0.2.0-rc3/etcd-v0.2.0-rc3-Linux-x86_64.tar.gz"; \
  cd $DIR_CACHE; \
  wget -p -c --no-check-certificate $DL_PROTO$DL_FILE ; \
  tar --strip-components=1 -xvf $DIR_CACHE$DL_FILE -C /opt/etcd/; \
  ln -s /opt/etcd/etcd /usr/sbin/etcd; \
  ln -s /opt/etcd/etcdctl /usr/sbin/etcdctl;

# cleanup
RUN \
  `# CLEANUP`; \
  rm -vrf /setupfiles;

CMD ["etcd"]

# client port
EXPOSE 4001
# cluster communication port
EXPOSE 7001

## [etcd] example for launching on a 3-machine prod cluster:
# Note: set the /etc/hosts file to contain the addresses of:
# machine0, machine1, machine2

#   etcd:
#     machine0:
#       sudo docker run -d -p 127.0.0.1:4002:4001 -p 127.0.0.1:7002:7001 inthecloud247/kdocker-etcd etcd -data-dir /data/machines/machine0 -name machine0 -peer-addr 127.0.0.1:7001 -peers machine1:7002,machine2:7002
#     machine1:
#       sudo docker run -d -p 127.0.0.1:4002:4001 -p 127.0.0.1:7002:7001 inthecloud247/kdocker-etcd etcd -data-dir /data/machines/machine1 -name machine1 -peer-addr 127.0.0.1:7001 -peers=machine0:7002,machine2:7002
#     machine2:
#       sudo docker run -d -p 127.0.0.1:4002:4001 -p 127.0.0.1:7002:7001 inthecloud247/kdocker-etcd etcd -data-dir /data/machines/machine2 -name machine2 -peer-addr 127.0.0.1:7001 -peers=machine0:7002,machine1:7002


# [etcd] example for launching a 3-node dev cluster
# etcd -peer-addr 127.0.0.1:7001 -addr 127.0.0.1:4001 -data-dir machines/machine1 -name machine1
# etcd -peer-addr 127.0.0.1:7002 -addr 127.0.0.1:4002 -peers 127.0.0.1:7001 -data-dir machines/machine2 -name machine2
# etcd -peer-addr 127.0.0.1:7003 -addr 127.0.0.1:4003 -peers 127.0.0.1:7001 -data-dir machines/machine3 -name machine3
