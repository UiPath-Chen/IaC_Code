### 创建
默认创建Nginx的Chart
```bash
helm create demo
```

### 详解
* template: 模板， k8s manifest / 包含模板变量的manifest
* Chart.yaml: 描述chart的元数据
* values.yaml: 配置文件

### 检测语法
```bash
cd demo
helm lint
```

### 查看模板最终渲染结果
```bash
cd demo
helm template . > all.yaml
```

### 本地安装
```bash
helm install nginx .

# 约等效于，但比它多了secret等
helm template . | kubectl apply -f -
```