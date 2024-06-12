# minio-stress-test-runner

## How to run test

```sh
docker run --rm \
        --name "minio-enterprise-stress-test" \
        -e MINIO_ENDPOINT="http://64.71.151.78:59000" \
        -e MINIO_ACCESS_KEY="minioadmin" \
        -e MINIO_SECRET_KEY="minioadmin" \
        docker.io/minio/enterprise-stress-test:latest
```
