### 配置cloudflare的prefix
* 在terraform 的variables.tf的变量prefix中修改为个性化的prefix，每个人都不一样


# self-hosted VS tencent-hosted
自托管 VS 腾讯云存储
Harbor的存储在哪里是要绝对需要关注的：
自托管 - 存储在本地硬盘；
腾讯云存储 - 存储在远端的云仓库中；




### 创建CVM后，需要验证harbor的push证书是否可用
```bash
echo 'Harbor12345' | docker login "harbor.canzhi.gkdevopscamp.com" --username admin --password-stdin
```

> Notes
> 清理Edge的缓存 - ALL