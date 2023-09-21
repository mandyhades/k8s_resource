kubectl run podtest --image=nginx:alpine
kubectl get pod
kubectl describe pod
kubectl delete pod pod1 pod2
\*\*get yaml to pod\*\*
kubectl get pod podtest -o yaml
\*\*pod and container\*\*
container : Docker manager , Pod : K8s Manager
\*\*ip port\*\*
kubectl port-forward <pod-name> 7000:<pod-port> =>> http://localhost:7000
\*\*port forwarding\*\*
kubectl port-forward services/my-service 8900:8900
\*\*kubectl exec\*\*
kubectl exec -it podtest -- sh
kubectl exec -it myapp-pod -- sh
kubectl exec -it myapp-pod -c const1 -- sh
kubectl exec -it myapp-pod -c const2 -- sh
\*\*log pod\*\*
kubectl logs podtest
\*\*apiversion k8s\*\*
kubectl api-versions
kubectl api-resources | grep pod
kubectl api-resources | grep deployment
kubectl api-resources | grep replicasets
\*\*create ,apply ,replace\*\*
kubectl create -f podtest.yaml
kubectl apply -f podtest.yaml
kubectl replace -f podtest.yaml --force
\*\*test Docker,write yaml K8s\*\*
docker run --net host -it python:3.12-rc-alpine3.17 sh

```
python -m htttp.server 8080
```

\*\*multi pod K8s\*\*
Giải pháp: Tránh sử dụng cùng một cổng trong các thùng chứa của Pod

\*\*label on Pod\*\*
kubectl get pods -l app=backend
kubectl get pods -l app=frontend
kubectl get pods -l env=dev
\*\*yaml Pod\*\*
yaml Pod de xay dung ban dau ...
\*\*Replica Sets\*\*
duy tri so luong "ban sao" container trong Pod.

## Hieu ve Replica Sets :

`kubectl get pod rs-test-8qkkw -o yaml`
uid: fb9d7cef-3674-478d-9ec4-e459e70c819f
`kubectl get pod rs-test-c7mfl -o yaml`
uid: fb9d7cef-3674-478d-9ec4-e459e70c819f
`kubectl get rs rs-test -o=yaml`
uid: fb9d7cef-3674-478d-9ec4-e459e70c819f

## apply rs:

`vi replicaset.yaml` ===> delete container const1 , update version
`kubectl apply -f replicaset.yaml ` ===> delete replicaset not support , update version not support

## Label pod:

kubectl run podtest1 --image=nginx:alpine
kubectl run podtest2 --image=nginx:alpine
kubectl label pods podtest1 app=pod-label
kubectl label pods podtest2 app=pod-label
kubectl get pod -l app=pod-label
kubectl create -f replicaset.yaml
Hóa ra hai **pod** này tuân thủ **matchLabels** mà chúng tôi đã xác định cho **replicat**.
Vì vậy, **replicat** cho biết Ồ, có hai cái mà tôi có thể sử dụng.
Vì thế tôi sẽ nhận nuôi chúng.
Bởi vì những **pod** này không có **pod** nên người ta trả lời rằng, à, chúng là trẻ mồ côi, tôi sẽ nhận chúng làm con nuôi.
Và tôi sẽ biến chúng thành của tôi, nghĩa là từ bây giờ tôi sẽ là chủ sở hữu của chúng .
Trong khi :
podtest1 ,podtest2: Image: nginx:alpine
replicaset.yaml: image: python:3.12-rc-alpine3.17
`kubectl delete -f replicaset.yaml` === `kubectl delete rs rs-test`

\*\*Deployment\*\*

## trạng thái triển khai

`kubectl create -f nginx_deployment.yaml`
`kubectl rollout status deployment deployment-test `
`$ deployment "deployment-test" successfully rolled out`

Bây giờ có một lệnh rất hay được gọi là trạng thái triển khai và điều này cho chúng ta biết nó diễn ra như thế nào trạng thái của điều này là để nói rằng Deployment đã phải gánh chịu những gì để tạo ra một đoàn lữ hành để triển khai cai gi đo mơi.
Sau đó, chúng tôi cung cấp cho nó trạng thái Triển khai và cho nó biết tên của Triển khai, trong trường hợp của chúng tôi được gọi là Kiểm tra triển khai, chúng tôi nhấn enter và nó cho chúng tôi biết rằng Giao dịch đã được thực hiện hoàn hảo một cách thỏa đáng.Đây là cách chúng tôi tạo và triển khai Diplo có sừng, nếu bạn để ý thì nó rất giống nhau .cách chúng tôi sử dụng bộ bản sao nhưng điểm khác biệt là Mr. Deployment này sẽ cung cấp cho chúng tôi tùy chọn để cập nhật pod của chúng tôi.

## label deployment

```
❯ kubectl get deployments.apps --show-labels
NAME              READY   UP-TO-DATE   AVAILABLE   AGE   LABELS
deployment-test   3/3     3            3           20m   app=nginx
❯ kubectl get rs --show-labels
NAME                         DESIRED   CURRENT   READY   AGE   LABELS
deployment-test-57d4cf5785   3         3         3       20m   app=nginx,pod-template-hash=57d4cf5785
❯ kubectl get pod --show-labels
NAME                               READY   STATUS    RESTARTS   AGE   LABELS
deployment-test-57d4cf5785-46k85   1/1     Running   0          20m   app=nginx,pod-template-hash=57d4cf5785
deployment-test-57d4cf5785-9zm2h   1/1     Running   0          20m   app=nginx,pod-template-hash=57d4cf5785
deployment-test-57d4cf5785-l844g   1/1     Running   0          20m   app=nginx,pod-template-hash=57d4cf5785
```

## check replicatSet

kubectl get rs deployment-test-57d4cf5785 -o=yaml
`kind: Deployment`
kubectl get pod deployment-test-57d4cf5785-46k85 -o=yaml
`kind: ReplicaSet`

## rolling update : Cập nhật liên tục - Cập nhật phiên bản ứng dụng của bạn

`kubectl describe deployments.apps deployment-test`
`RollingUpdateStrategy:  25% max unavailable, 25% max surge`

theo mặc định nó có giá trị là 25 phần trăm không có sẵn ở mức tối đa, nghĩa là bạn luôn có sẵn 75% PODS và bạn có 25
phần trăm của max surge, nghĩa là trong số 100 phần trăm sẽ là ba bản sao mà chúng tôi sắp tạo ra để cho phép thêm 25 phần trăm để tạo một bài đăng khác.

## Lịch sử triển khai và đánh giá

`You can set .spec.revisionHistoryLimit field in a Deployment to specify how many old ReplicaSets for this Deployment you want to retain. The rest will be garbage-collected in the background. By default, it is 10.`

`kubectl get rs -l app=nginx`
`kubectl rollout history deployment`

```
❯ kubectl get rs -l app=nginx
NAME                         DESIRED   CURRENT   READY   AGE
deployment-test-57d4cf5785   0         0         0       54m
deployment-test-5f5c64f949   3         3         3       11m
deployment-test-5f8f49fff4   0         0         0       13m
❯ kubectl rollout history deployment
deployment.apps/deployment-test
REVISION  CHANGE-CAUSE
1         <none>
2         <none>
3         <none>

❯ kubectl apply -f nginx_deployment.yaml
deployment.apps/deployment-test configured
❯ kubectl get rs
NAME                         DESIRED   CURRENT   READY   AGE
deployment-test-57d4cf5785   0         0         0       58m
deployment-test-5f5c64f949   0         0         0       14m
deployment-test-5f8f49fff4   0         0         0       16m
deployment-test-64c95874d7   3         3         3       14s
❯ kubectl rollout history deployment deployment-test
\deployment.apps/deployment-test
REVISION  CHANGE-CAUSE
1         <none>
2         <none>
3         <none>
4         <none>
```

Rula đã hoàn thành tất cả các bài đăng của bản sao CED này đã được cập nhật chính xác và các bài đăng khác ba cái trước đó ở mức 0.Bây giờ hãy nhớ rằng ý tưởng giữ bản sao của bạn ở mức 0 là phòng trường hợp tôi muốn quay lạisang phiên bản trước của bản sao của nó, v.v. Tôi có thể kiểm soát những gì ở đây, tức là ở đây tôi có phiên bản 2 phiên bản 3 và phiên bản 4.
Nói cách khác, tôi có bản sửa đổi 2, 3 và 4 ở đây và tôi có thể quay lại từng bản sửa đổi bất cứ lúc nào.

## Change-Cause - Bạn có thay đổi gì không?

` kubectl apply -f nginx_deployment.yaml --record`

```
❯ kubectl rollout history deployment deployment-test
deployment.apps/deployment-test
REVISION  CHANGE-CAUSE
1         <none>
2         kubectl apply --filename=nginx_deployment.yaml --record=true

```

```
vi nginx_deployment.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  annotations:
    kubernetes.io/change-cause: "change port to 110"
```

```
❯ kubectl rollout history deployment deployment-test
deployment.apps/deployment-test
REVISION  CHANGE-CAUSE
1         <none>
2         kubectl apply --filename=nginx_deployment.yaml --record=true
3         change port to 110

```

```
❯ kubectl rollout history deployment deployment-test --revision=2
deployment.apps/deployment-test with revision #2
Pod Template:
  Labels:	app=nginx
	pod-template-hash=9747f9c55
  Annotations:	kubernetes.io/change-cause: kubectl apply --filename=nginx_deployment.yaml --record=true
  Containers:
   nginx:
    Image:	nginx
    Ports:	100/TCP, 60/TCP
    Host Ports:	0/TCP, 0/TCP
    Environment:	<none>
    Mounts:	<none>
  Volumes:	<none>
```

## Roll back - Nếu có lỗi gì thì roll back về phiên bản trước nhé!

```
❯ kubectl rollout history deployment deployment-test
deployment.apps/deployment-test
REVISION  CHANGE-CAUSE
1         <none>
2         kubectl apply --filename=nginx_deployment.yaml --record=true
3         change port to 110
4         change nginx test fake
```

```
❯ kubectl rollout undo deployment deployment-test --to-revision=3
deployment.apps/deployment-test rolled back
```

\*\*Service\*\*

```
❯ kubectl get service -l app=front
NAME         TYPE        CLUSTER-IP     EXTERNAL-IP   PORT(S)    AGE
my-service   ClusterIP   10.97.127.22   <none>        8080/TCP   22m
❯ kubectl get deployments.apps -l app=front
NAME              READY   UP-TO-DATE   AVAILABLE   AGE
deployment-test   3/3     3            3           12m
❯ kubectl get replicasets.apps -l app=front
NAME                         DESIRED   CURRENT   READY   AGE
deployment-test-5db858dcb9   3         3         3       12m
❯ kubectl get pod -l app=front
NAME                               READY   STATUS    RESTARTS   AGE
deployment-test-5db858dcb9-c4wlg   1/1     Running   0          13m
deployment-test-5db858dcb9-dmlbt   1/1     Running   0          13m
deployment-test-5db858dcb9-q7bxr   1/1     Running   0          13m

```

## endpoint Containers:

```
❯ kubectl get endpoints
NAME         ENDPOINTS                                   AGE
kubernetes   192.168.65.4:6443                           54d
my-service   10.1.0.186:80,10.1.0.187:80,10.1.0.188:80   3m15s
```

## DNS core:

- check name service:

```
❯ kubectl get service
NAME         TYPE        CLUSTER-IP    EXTERNAL-IP   PORT(S)    AGE
kubernetes   ClusterIP   10.96.0.1     <none>        443/TCP    54d
my-service   ClusterIP   10.97.8.152   <none>        8080/TCP   16m
```

- ping name service:

```
/ # ping my-service
PING my-service (10.97.8.152): 56 data bytes
^C
--- my-service ping statistics ---
5 packets transmitted, 0 packets received, 100% packet loss
/ #
```

## Cluster IP:

kubectl port-forward services/my-service 8900:8900

## Node Port:

```
❯ kubectl get service -o=wide
NAME                 TYPE        CLUSTER-IP     EXTERNAL-IP   PORT(S)          AGE   SELECTOR
kubernetes           ClusterIP   10.96.0.1      <none>        443/TCP          54d   <none>
my-service-backend   NodePort    10.99.62.229   <none>        8080:31060/TCP   16s   app=backend
❯ ping 10.99.62.229
```

`http://localhost:8080/`

## Load Balancer:

Cloud support

\*\*Golang , javascript on kubernete\*\*

## Build backend

go build -o app ./main.go
docker build -t k8s-hands-on -f Dockerfile .
docker run -d -p 9091:9090 --name k8s_hands_on k8s-hands-on
docker container ps -l

## Build frontend

docker build -t frontend-k8s-hands-on:v1 -f Dockerfile .

\*\*Namespaces and Context\*\*
organize and isolate resources in your cluster

## Namespaces

kubectl get namespace
ku

## Default namespace

## create namespace

kubectl create namespace test-ns

## Object in a namespace

kubectl get pod -n test-ns

## DNS in a namespace

namespace khac nhau ko the ping cho nhau .
Vi namespace se thay doi thanh :
svcName + nsName + svc.cluster.local
backend-k8s-handsson.test-ns.svc.cluster.local

## learn to use context

- config minikube , not config docker-desktop , check namespace defaults :
  `kubectl config view` =>> chua co namespace
- tao namespace:
  `kubectl config set-context ci-context --namespace=ci --cluster=minikube --user=minikube` =>> namespace: ci
- chuyen sang dung namespace : ci
  kubectl config use-context ci-context

## gioi han RAM va CPU ma POD co the su dung:

```
spec:
  containers:
    - name: memory-demo-ctr
      image: polinux/stress
      resources:
        requests:
          memory: "100Mi"
        limits:
          memory: "200Mi"
      command: ["stress"]
      args: ["--vm", "1", "--vm-bytes", "250M", "--vm-hang", "1"]
```

kubectl get pod memory-demo --watch

```
❯ kubectl get pod memory-demo --watch
NAME          READY   STATUS             RESTARTS      AGE
memory-demo   0/1     CrashLoopBackOff   4 (39s ago)   2m28s
memory-demo   0/1     OOMKilled          5             3m21s
```

CrashLoopBackOff, OOMKilled thieu chip hoac ram

## QOS k8s:

```
spec:
  containers:
  - name: qos-demo-ctr
    image: nginx
    resources:
      limits:
        memory: "200Mi"
        cpu: "700m"
      requests:
        memory: "200Mi"
        cpu: "700m"
```

\*\*Limit Range control resource usage at the Object level\*\*

## Limit Range

control ram,chip Pod:

```
 kubectl get limitranges
```

\*\*resource quota kubernete\*\*
control ram,chip,so luong pod trong Namespace:

```
kubectl get resourcequotas
```

\*\*liveness probe,readiness probe\*\*
readiness probe : chay lan dau moi khi khoi tao ,de giam tai connect cho service
liveness probe : thinh thoang chay de kiem tra service

\*\* configMap,Environment Variables - inject data into your Pod\*\*

## Environment Variables

Environment Variables on container . vd : echo ${duc}

## configMap

often used to inject configuration files into a container at a specific path.

```
kubectl create configmap nginx-config --from-file=configmaps-examples/nginx.conf
```

\*\*Secrets - manage sensitive data in K8s\*\*

\*\*Kubernetes Volumes - Concept behind data persistence\*\*

\*\*Kubernetes Volumes - Empty Dir, HostPath , PV ,PVC , Storage Classes \*\*

\*\*Role Based Access Control : Users and Groups\*\*

\*\*Role Based Access Control : Service Account\*\*

\*\*Ingress : Learn to expose your applications outside of the Cluster\*\*
