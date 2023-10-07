
### 构建镜像:env
```bash
docker buildx build \
--push \
--platform=linux/amd64 \
--tag dockerkeystone/result:env -f Dockerfile .
```

### 构建镜像:remote-retry
```bash
docker buildx build \
--push \
--platform=linux/amd64 \
--tag dockerkeystone/result:remote-retry -f Dockerfile .
```