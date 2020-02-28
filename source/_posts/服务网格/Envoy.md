```shell
yum install -y yum-utils  device-mapper-persistent-data lvm2
yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
yum install -y docker-ce docker-ce-cli containerd.io

yum install -y git
git clone https://github.com/envoyproxy/envoy.git
git checkout v1.13.0
```


./ci/run_envoy_docker.sh './ci/do_ci.sh bazel.release.server_only'