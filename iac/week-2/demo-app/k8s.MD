# 实验方案
启动顺序控制：
redis -> postgres -> worker -> vote -> result

result启动依赖于PG, 当PG启动缓慢（在initContainers中模拟sleep）,result会不断的CrashBackoff，从而导致不断重启
当PG总算启动完毕后，result容器，才能启动；

--- 完全依赖于K8S的重启机制， 如果由1000容器，那么如果平均需要3次重启才能重启成功，那么就需要3000次重启，崩溃
--- 且K8s重启时间采用指数退避策略，即下一次启动时间是上一次的2倍，导致应用整体启动时间变成
--- 所以，如果，业务直接由依赖关系，那么，必须解决；而不能完全交给K8s来不断重启

### 查看result是如何根据db的状态而不断变化的
```bash
kubectl --kubeconfig config delete -f ./
kubectl --kubeconfig config apply -f ./
kubectl --kubeconfig config get po -o=wide -w
kubectl --kubeconfig config exec -i -t -n default result-75dbbb8cbb-gbqm6 -c result -- sh -c "clear; (bash || ash || sh)"
```


### 解决方法
1. 人工控制启动顺序：将manifest根据依赖关系分组，数据层的先启动，然后是中间件，最后启动应用层

2. 业务代码：开发人员要始终意识到，所开发的微服务是不稳定的
```nodejs
async.retry (
    // 不断重试访问PG-DB
);
```

3. initContainers：控制Pod的启动顺序
  initContainers阻塞业务Containers的执行，initContainers不执行完毕，那么业务containers也就无法开始执行

  **k8s-wait-for**:  A simple script that allows waiting for a k8s service, job or pods to enter the desired state.

  其实，本质，就是将K8s的重启机制，作用于initContainers而不是业务Containers，使得重启的代价比较低；initContainers执行脚本*.sh，去检查Pod是否Ready,如果没有，则initConatainer就CrashBackoff，然后k8s重启这个initContainer
```yml
spec:
  initContainers:
  - name: wait-for-onezone
    image: ghcr.io/groundnuty/k8s-wait-for:v1.6
    imagePullPolicy: Always                    # sidecar - 边车
    args:
      - "job"                                  # 数据库初始化、导入表结构
      - "develop-onezone-ready-check"
  - name: wait-for-volume-ceph
    image: ghcr.io/groundnuty/k8s-wait-for:v1.6
    imagePullPolicy: Always
    args:
      - "pod"    # 此init 容器在等待pod的启动完成后，才结束，否则一直阻塞
      - "-lapp=develop-volume-ceph-krakow"        # Pod的Label是什么；也就是说在等待哪些Pod启动完成
  - name: wait-for-volume-gluster
    image: ghcr.io/groundnuty/k8s-wait-for:v1.6
    imagePullPolicy: Always
    args:
      - "pod"
      - "-lapp=develop-volume-gluster-krakow"
```
> args 配置参数
```bash
/ > wait_for.sh -h
This script waits until a job, pod or service enter a ready state.

wait_for.sh job [<job name> | -l<kubectl selector>]
wait_for.sh pod [<pod name> | -l<kubectl selector>]
wait_for.sh service [<service name> | -l<kubectl selector>]

Examples:
Wait for all pods with a following label to enter 'Ready' state:
wait_for.sh pod -lapp=develop-volume-gluster-krakow

Wait for all selected pods to enter the 'Ready' state:
wait_for.sh pod -l"release in (develop), chart notin (cross-support-job-3p)"

Wait for all pods with a following label to enter 'Ready' or 'Error' state:
wait_for.sh pod-we -lapp=develop-volume-gluster-krakow

Wait for at least one pod to enter the 'Ready' state, even when the other ones are in 'Error' state:
wait_for.sh pod-wr -lapp=develop-volume-gluster-krakow

Wait for all the pods in that job to have a 'Succeeded' state:
wait_for.sh job develop-volume-s3-krakow-init

Wait for all the pods in that job to have a 'Succeeded' or 'Failed' state:
wait_for.sh job-we develop-volume-s3-krakow-init

Wait for at least one pod in that job to have 'Succeeded' state, does not mind some 'Failed' ones:
wait_for.sh job-wr develop-volume-s3-krakow-init
```

> 授权
>pg Pod启动报错：
FalseError from server(Forbidden): pods is forbidden: User "system:serviceaccount:default:default" cannot list resource "pods" in API group "" in the namespace "default"
> result Pod启动报错：
> Failed to load logs: container "result" in pod "result-77d86578b4-kk57w" is waiting to start: PodInitializing
Reason: BadRequest (400)

```bash
kubectl --kubeconfig config create role pod-reader --verb=get --verb=list --verb=watch --resource=pods,services,deployments

kubectl --kubeconfig config create rolebinding default-pod-reader --role=pod-reader --serviceaccount=default:default --namespace=default
```

4. Tekton
原理：两个containers之间通过，一个文件作为标志位，预先定义好，后启动的container等待第一个启动后，创建一个标志文件，当后面一个发现了这个文件，后开始启动