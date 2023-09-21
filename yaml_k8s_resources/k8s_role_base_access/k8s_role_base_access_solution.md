## **step1**

Inspect the environment and identify the authorization modes configured on the cluster.
Check the kube-apiserver settings

```
controlplane ~ ➜  kubectl  get pod -n kube-system
NAME                                   READY   STATUS    RESTARTS   AGE
coredns-5d78c9869d-trgsw               1/1     Running   0          15m
coredns-5d78c9869d-zbqfm               1/1     Running   0          15m
etcd-controlplane                      1/1     Running   0          15m
kube-apiserver-controlplane            1/1     Running   0          15m
kube-controller-manager-controlplane   1/1     Running   0          15m
kube-proxy-qbpzm                       1/1     Running   0          15m
kube-scheduler-controlplane            1/1     Running   0          15m
```

```
controlplane ~ ➜  kubectl -n kube-system describe pod kube-apiserver-controlplane
    Command:
      kube-apiserver
      --advertise-address=192.5.21.9
      --allow-privileged=true
      --authorization-mode=Node,RBAC
```

## **step 2**

How many roles exist in the default namespace?
`controlplane ~ ➜  kubectl get role
No resources found in default namespace.`

## **step3**

How many roles exist in all namespaces together?

```
controlplane ~ ➜  kubectl get role --all-namespaces
NAMESPACE     NAME                                             CREATED AT
blue          developer                                        2023-09-18T03:05:25Z
kube-public   kubeadm:bootstrap-signer-clusterinfo             2023-09-18T02:56:43Z
kube-public   system:controller:bootstrap-signer               2023-09-18T02:56:42Z
kube-system   extension-apiserver-authentication-reader        2023-09-18T02:56:42Z
kube-system   kube-proxy                                       2023-09-18T02:56:45Z
kube-system   kubeadm:kubelet-config                           2023-09-18T02:56:42Z
kube-system   kubeadm:nodes-kubeadm-config                     2023-09-18T02:56:42Z
kube-system   system::leader-locking-kube-controller-manager   2023-09-18T02:56:42Z
kube-system   system::leader-locking-kube-scheduler            2023-09-18T02:56:42Z
kube-system   system:controller:bootstrap-signer               2023-09-18T02:56:42Z
kube-system   system:controller:cloud-provider                 2023-09-18T02:56:42Z
kube-system   system:controller:token-cleaner                  2023-09-18T02:56:42Z
```

## **step4**

What are the resources the kube-proxy role in the kube-system namespace is given access to?
What actions can the kube-proxy role perform on configmaps?
kube-proxy role can get details of configmap object by the name kube-proxy only
Vai trò kube-proxy chỉ có thể lấy thông tin chi tiết về đối tượng configmap theo tên kube-proxy

```
controlplane ~ ➜  kubectl describe role kube-proxy -n kube-system
Name:         kube-proxy
Labels:       <none>
Annotations:  <none>
PolicyRule:
  Resources   Non-Resource URLs  Resource Names  Verbs
  ---------   -----------------  --------------  -----
  configmaps  []                 [kube-proxy]    [get]
```

## **step5**

Which account is the kube-proxy role assigned to?

```
controlplane ~ ➜  kubectl describe rolebinding kube-proxy -n kube-system
Name:         kube-proxy
Labels:       <none>
Annotations:  <none>
Role:
  Kind:  Role
  Name:  kube-proxy
Subjects:
  Kind   Name                                             Namespace
  ----   ----                                             ---------
  Group  system:bootstrappers:kubeadm:default-node-token
```

```
Group: system:bootstrappers:kubeadm:default-node-token
```

## **step6**

A user dev-user is created. User's details have been added to the kubeconfig file. Inspect the permissions granted to the user. Check if the user can list pods in the default namespace.

Use the --as dev-user option with kubectl to run commands as the dev-user.

```

controlplane ~ ✖ kubectl get pods --as dev-user
Error from server (Forbidden): pods is forbidden: User "dev-user" cannot list resource "pods" in API group "" in the namespace "default"
```

===> dev-user does not have permissions to list pods

## **step7**

Create the necessary roles and role bindings required for the dev-user to create, list and delete pods in the default namespace.

Use the given spec:
Role: developer
Role Resources: pods
Role Actions: list
Role Actions: create
Role Actions: delete
RoleBinding: dev-user-binding
RoleBinding: Bound to dev-user

## **step 8**

A set of new roles and role-bindings are created in the blue namespace for the dev-user. However, the dev-user is unable to get details of the dark-blue-app pod in the blue namespace. Investigate and fix the issue.
`Run the command: kubectl edit role developer -n blue and correct the resourceNames field. You don't have to delete the role.`

```
#
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  creationTimestamp: "2023-09-18T03:05:25Z"
  name: developer
  namespace: blue
  resourceVersion: "1145"
  uid: 77d19fde-e33c-4776-89a1-5eba0f394ff4
rules:
- apiGroups:
  - ""
  resourceNames:
  - blue-app
  - dark-blue-app
  resources:
  - pods
  verbs:
  - get
  - watch
  - create
  - delete

```

## **step 9**

Add a new rule in the existing role **developer** to grant the **dev-user** permissions to create **deployments** in the **blue** namespace.
Remember to add api group "apps".
`kubectl edit role developer -n blue`

```
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  name: **developer**
  namespace: **blue**
rules:
- apiGroups:
  - apps
  resourceNames:
  - dark-blue-app
  resources:
  - pods
  verbs:
  - get
  - watch
  - create
  - delete
- apiGroups:
  - apps
  resources:
  - **deployments**
  verbs:
  - create
```
