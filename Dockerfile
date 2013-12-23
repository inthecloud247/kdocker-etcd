FROM inthecloud247/kdocker-base
MAINTAINER inthecloud247 "inthecloud247@gmail.com"

ENV LAST_UPDATED 2013-12-22

# copy required conf files and folders
ADD setupfiles/ /setupfiles/

RUN \
  `# Install etcd (using cache if possible)`; \
  cd /setupfiles/cache; \
  wget -p -c --no-check-certificate https://github.com/coreos/etcd/releases/download/v0.2.0-rc3/etcd-v0.2.0-rc3-Linux-x86_64.tar.gz; \
  mkdir -vp /opt/etcd/; \
  tar --strip-components=1 -xvf /setupfiles/cache/github.com/coreos/etcd/releases/download/v0.2.0-rc3/etcd-v0.2.0-rc3-Linux-x86_64.tar.gz -C /opt/etcd/; \
  ln -s /opt/etcd/etcd /usr/sbin/etcd; \
  ln -s /opt/etcd/etcdctl /usr/sbin/etcdctl;


CMD ["etcd"]

# client port
#EXPOSE 4001
# cluster communication port
#EXPOSE 7001

#CMD ["etcd", "-peer-addr 127.0.0.1:7001", "-addr 127.0.0.1:4001", "-data-dir machines/machine1", "-name machine1"]

# [etcd] examples for launching a cluster
# etcd -peer-addr 127.0.0.1:7001 -addr 127.0.0.1:4001 -data-dir machines/machine1 -name machine1
# etcd -peer-addr 127.0.0.1:7002 -addr 127.0.0.1:4002 -peers 127.0.0.1:7001 -data-dir machines/machine2 -name machine2
# etcd -peer-addr 127.0.0.1:7003 -addr 127.0.0.1:4003 -peers 127.0.0.1:7001 -data-dir machines/machine3 -name machine3