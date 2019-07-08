# Build image from local Dockerfile

docker  image  rm  --force  magehost/ubuntu-systemd  magehost/ubuntu-systemd:bionic
docker  build  --tag=magehost/ubuntu-systemd --tag=magehost/ubuntu-systemd:bionic .
docker  image  ls
 
# Run

docker  container rm --force mhtest
docker  run \
  --rm \
  --privileged \
  --volume /:/host  magehost/ubuntu-systemd  setup
docker  run \
  --detach \
  --name mhtest \
  --security-opt seccomp=unconfined \
  --tmpfs /run \
  --tmpfs /run/lock \
  --volume /sys/fs/cgroup:/sys/fs/cgroup:ro \
  magehost/ubuntu-systemd
docker container ls

# Check Systemctl

docker  exec  mhtest  systemctl status

# Check Journalctl

docker  exec  mhtest  journalctl

# Shell

docker  exec  --tty  --interactive  mhtest  bash

# Publish 

docker  login
docker  push  magehost/ubuntu-systemd:bionic
docker  push  magehost/ubuntu-systemd

# Cleanup

docker  container  rm  --force  mhtest
docker  container  ls  --all
docker  image  rm  --force  magehost/ubuntu-systemd  magehost/ubuntu-systemd:bionic
docker  image  ls
