# role vs cluster role

(role: 1 namespace , cluster role: multi namesapce)
Người dùng quản trị viên có thể truy cập trực tiếp vào Cluster, tức là tại đây và có thể truy cập mọi thứ bất cứ thứ gì bên trong.Bây giờ sẽ hợp lý nếu chúng ta có một người dùng là nhà phát triển, chẳng hạn, bây giờ người dùng này cho chúng ta biết đang yêu cầu quyền truy cập vào cluster và đây là lúc RBAC xuất hiện ở đây, toàn bộ vấn đề về vai trò này, chúng ta phải làm thế nào để cho phép nhà phát triển quý ông này vào cluster.
Chà, điều đầu tiên chúng ta phải hiểu là người dùng cần những quyền gì, người dùng muốn làm gì.bên trong cluster dành cho những người cần vào cluster.Người dùng sẽ nói tốt rằng tôi cần tạo các dịch vụ CETS ,replicat, deployment , v.v.
Đó là lý do tại sao tôi cần được vào Group và điều đó hoàn toàn dễ hiểu.
Sự khác biệt giữa role và cluster Role là nếu chúng tôi áp dụng một role, chúng tôi cần xác định Namespace và các quyền sẽ bị giới hạn.Ngược lại, ở Namespace đó, nếu chúng tôi tạo nó với cluster role thì các quyền mà chúng tôi xác định ở đó sẽ được áp dụng tới toàn bộ cluster không chỉ ducla mà còn tới toàn bộ 30 người.

# rolebindings vs clusterrolebindings

(rolebindings: lien ket voi 1 user, clusterrolebindings:lien ket voi 1 user)
Đây là cách hoạt động : một role được áp dụng cho namespace và role cluster được áp dụng cho toàn bộ cluster nên việc áp dụng các role này tùy thuộc vào chúng tôi hoặc người dùng này với tư cách là Administrator hoặc role Cluster chính xác để người dùng này chỉ có thể truy cập lại những gì họ cần . Ý tưởng của ABAC là người đàn ông ở đây chỉ truy cập những gì anh ta cần vì điều đó sẽ vô nghĩa khi cấp cho ho quyền quản trị viên cluster vì điều đó đồng nghĩa với việc cấp cho nó quyền Admin bình thường đang kiểm soát
Người dùng này có thể làm gì và người dùng này không thể làm gì.

# role and rolebindings (1 namespace):

- creat user: ducla
- creat role
  -creat rolebindings : ket noi ducla voi role da tao
- truy cap k8s tu client vao server bang user : ducla

# clusterrole and clusterrolebinđings (multi namespace)

- creat user ducla
- creat clusterrole
- creat clusterrolebinđings : ket noi ducla voi clusterrole
- truy cap k8s tu client vao server bang user : ducla

# user and group Kubernetes

CA certificate:

- cert
- CSR
- Sign

```
[node1 ~]$ kubectl config
current-context  (Display the current-context)
delete-cluster   (Delete the specified cluster from the kubeconfig)
delete-context   (Delete the specified context from the kubeconfig)
delete-user      (Delete the specified user from the kubeconfig)
get-clusters     (Display clusters defined in the kubeconfig)
get-contexts     (Describe one or many contexts)
get-users        (Display users defined in the kubeconfig)
rename-context   (Rename a context from the kubeconfig file)
set              (Set an individual value in a kubeconfig file)
set-cluster      (Set a cluster entry in kubeconfig)
set-context      (Set a context entry in kubeconfig)
set-credentials  (Set a user entry in kubeconfig)
unset            (Unset an individual value in a kubeconfig file)
use-context      (Set the current-context in a kubeconfig file)
view             (Display merged kubeconfig settings or a specified kubeconfig file)
```

## Create certificates for a user in Kubernetes

**Create keys and sign**
openssl genrsa -out ricardo.key 2048
openssl req -new -key ricardo.key -out ricardo.csr -subj "/CN=ricardo/O=dev"
sudo openssl x509 -req -in ricardo.csr -CA /root/.minikube/ca.crt -CAkey /root/.minikube/ca.key -CAcreateserial -out ricardo.crt -days 500
openssl x509 -in ricardo.crt -noout -text

**Isolated env**
kubectl config view | grep server
docker run --rm -ti -v $PWD:/test -w /test -v /root/.minikube/ca.crt:/ca.crt -v /usr/bin/kubectl:/usr/bin/kubectl alpine sh

```
[node1 ~]$ kubectl config view
apiVersion: v1
clusters:
- cluster:
    certificate-authority-data: DATA+OMITTED
    server: https://192.168.0.23:6443
  name: kubernetes
contexts:
- context:
    cluster: kubernetes
    user: kubernetes-admin
  name: kubernetes-admin@kubernetes
current-context: kubernetes-admin@kubernetes
kind: Config
preferences: {}
users:
- name: kubernetes-admin
  user:
    client-certificate-data: DATA+OMITTED
    client-key-data: DATA+OMITTED
```

## Configure kubectl and create a context for the user

kubectl config set-cluster minikube --server=https://192.168.1.140:8443 --certificate-authority=/ca.crt
kubectl config set-credentials ricardo --client-certificate=ricardo.crt --client-key=ricardo.key
kubectl config set-context ricardo --cluster=minikube --user=ricardo
kubectl config use-context ricardo

## Đảm bảo RBAC được bật

minikube start --vm-driver=none --extra-config=apiserver.authorization-mode=RBAC

## Change contexts to simplify the exercises

check multi user:

```
[node1 ~]$ kubectl config get-contexts
CURRENT   NAME                          CLUSTER      AUTHINFO           NAMESPACE
*         kubernetes-admin@kubernetes   kubernetes   kubernetes-admin
[node1 ~]$
```

switch user:

```
[node1 ~]$ kubectl config use-context kubernetes-admin@kubernetes
Switched to context "kubernetes-admin@kubernetes".
```

## Tạo Role cho phép read vào Pod trong Namespace

Tạo Role cho phép đọc vào Pod trong Không gian tên

## Tạo RoleBinding để tham gia Người dùng của bạn với role bạn đã tạo

Tạo RoleBinding để liên kết user của bạn với Role bạn đã tạo

## Áp dụng thêm rule cho role để có thể list các deployment

## Tìm hiểu thêm về Verbs (Ví dụ với ConfigMaps)

In Kubernetes RBAC (Role-Based Access Control), a "verb" is a term used to define the actions or operations that a subject (like a user or a service account) can perform on a resource. Verbs are an essential part of RBAC rules and are used to grant or deny specific permissions to users or entities in a Kubernetes cluster.

Here are some common verbs used in Kubernetes RBAC:

get: Allows retrieving information about a resource or a list of resources.
list: Permits listing multiple instances of a resource.
watch: Allows continuous monitoring for changes to a resource.
create: Grants the ability to create new resources.
update: Allows modifying existing resources.
patch: Permits making specific modifications to a resource.
delete: Grants the ability to remove resources.
proxy: Enables proxying requests to the API server.
redirect: Allows requests to be redirected.
These verbs help define fine-grained access control to Kubernetes resources. When setting up RBAC, you specify the actions (verbs) a user or group of users can take on a particular type of resource (e.g., pods, services, deployments). For security and control, it's important to carefully assign verbs to roles and cluster roles based on the principle of least privilege.

## Create a ClusterRole to list Pods in all namespaces

## Learn how to create a User with administrator permissions

add user to cluster-admin

```
[node1 ~]$ kubectl get role
NAME        CREATED AT
developer   2023-09-19T02:57:12Z
[node1 ~]$ kubectl get clusterrole
NAME                                                                   CREATED AT
admin                                                                  2023-09-19T02:40:42Z
cluster-admin                                                          2023-09-19T02:40:42Z
edit                                                                   2023-09-19T02:40:42Z
```

## Assign Roles to a Group

```
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRole
metadata:
  name: svc-clusterrole
rules:
- apiGroups: [""] # "" indicates the core API group
  resources: ["services"]
  verbs: ["*"]
---
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRoleBinding
metadata:
  name: cluster-svc
subjects:
- kind: Group
  name: dev # "name" is case sensitive
  apiGroup: rbac.authorization.k8s.io
roleRef:
  kind: ClusterRole #this must be Role or ClusterRole
  name: svc-clusterrole # this must match the name of the Role or ClusterRole you wish to bind to
  apiGroup: rbac.authorization.k8s.io
```
