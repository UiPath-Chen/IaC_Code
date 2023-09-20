# 说明

## 构建镜像

```bash
make
```

## 镜像大小

```bash
#  -f, --filter value    Filter output based on conditions provided (default [])
#                         - dangling=(true|false)
#                         - label=<key> or label=<key>=<value>
#                         - before=(<image-name>[:tag]|<image-id>|<image@digest>)
#                         - since=(<image-name>[:tag]|<image-id>|<image@digest>)
#                         - reference=(pattern of an image reference)
#
# -q, --quiet            Only show image IDs
docker images --filter=label=maintainer=ysucxh@163.com

REPOSITORY                  TAG       IMAGE ID       CREATED          SIZE
dockerkeystone/helloworld   v1.0      5a9a286a501b   36 minutes ago   1.8MB
```

## 启动服务

```bash
docker run dockerkeystone/helloworld:v1.0
>hello world
```

## 跨平台发布
```bash
docker login
docker buildx create --use
make release
```