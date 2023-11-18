# 使用方法

1. 设置环境变量

```bash
$ export TF_VAR_secret_id=
$ export TF_VAR_secret_key=
```

# OR
terraform.tfvars/*.auto.tfvars
```
vsphere_server     = "127.0.0.1:8989"
vsphere_user       = "user"
vsphere_password   = "pass"
datacenter         = "DC0"
datastore          = "LocalDS_0"
cluster            = "DC0_C0"
network_name       = "VM Network"
ubuntu_name        = "tf-edu-ubuntu"
```


2. 初始化并应用（dev 环境）

```bash
cd dev
$ terraform init
$ terraform plan
$ terraform apply
```


## 访问 Argo CD
1. 设置 KUBECONFIG 环境变量

```bash
$ export KUBECONFIG="$(pwd)/config"
```

1. 获取密码

```bash
$ kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d
```

1. 端口转发
Listen on port 8080 locally/on all addresses, forwarding to the targetPort of the service's port 80 in a pod selected by the service(svc/argocd-server)
```bash
$ kubectl -n argocd port-forward [--address 0.0.0.0] svc/argocd-server  8080:80
Forwarding from 127.0.0.1:8080 -> 8080
Forwarding from [::1]:8080 -> 8080
```
1. 访问 Dashboard

打开浏览器访问 http://127.0.0.1:8080，用户名 admin/密码为上面获取的密码。


## 销毁

```bash
$ terraform state list
# 先删除 k3s state 和 argocd state，否则会出错
$ terraform state rm 'helm_release.argo_cd'
$ terraform state rm 'module.k3s'

# 再执行删除
$ terraform destroy -auto-approve
```