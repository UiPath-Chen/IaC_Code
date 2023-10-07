### 启动CVM
```bash
terraform init
terraform plan
terraform apply --auto-approve
```

### 记录config & 检测k3s
```bash
# 打开config，更新

kubectl --kubeconfig config get ns
```

### 删除CVM
```bash
terraform destroy --auto-approve
```

