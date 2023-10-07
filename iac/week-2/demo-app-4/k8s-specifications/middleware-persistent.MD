### daemonfulset 安装
PG持久化
[Middleware](./db-statefulset.yaml)



### Helm 安装
修改自己的pgpool名称为my-release
```bash
helm --kubeconfig config install <my-release> oci://registry-1.docker.io/bitnamicharts/postgresql-ha --set fullnameOverride=db -n db --create-namespace

helm --kubeconfig config uninstall db -n db
```






