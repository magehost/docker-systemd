# Build image from local Dockerfile

docker  image  rm  --force  docker-systemd
docker  build  --tag=docker-systemd  .
docker  image  ls
 
# Run

docker  container rm --force systemd
docker  run \
  --detach \
  --name systemd \
  --security-opt seccomp=unconfined \
  --tmpfs /run \
  --tmpfs /run/lock \
  --volume /sys/fs/cgroup:/sys/fs/cgroup:ro \
  docker-systemd
docker container ls

# Check Journalctl

docker  exec  systemd  journalctl

# Shell

docker  exec  --tty  --interactive  systemd  bash

# Cleanup

docker  image  rm  --force  docker-systemd
docker  container rm  --force  systemd
