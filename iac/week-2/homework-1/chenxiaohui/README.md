# 说明

## 构建镜像

```bash
make
```

## 镜像大小

```bash
docker images |grep helloworld

>dockerkeystone/helloworld                                         v1.0      ed65f226ef37   9 minutes ago   1.8MB
```

## 启动服务

```bash
docker run dockerkeystone/helloworld:v1.0
>hello world
```

