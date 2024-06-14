# minio-stress-test-runner

## How to run test

```sh
podman image prune && podman container prune && podman build -t localhost/minio/stress-test . -f Dockerfile
podman run -e "MINIO_ENDPOINT=http://xxx.xxx.xxx.xxx:59000" -e "MINIO_ACCESS_KEY=minioadmin" -e "MINIO_SECRET_KEY=minioadmin" <IMGAE-ID>
```

## How to copy the logs

```sh
podman container list  --all
podman cp <CONTAINER-ID>:/enterprise-stress-test/log ./logs
```
