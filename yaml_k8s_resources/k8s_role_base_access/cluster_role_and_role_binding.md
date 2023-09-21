Trong Kubernetes, các tài nguyên có thể được phân loại thành hai loại chính dựa trên phạm vi của chúng: không gian tên(namespaced) và phạm vi cụm( cluster-scoped).

# namespaced and cluster-scoped :

**namespaced** :
**roles**

```
- dev-user
can view PODs
can create PODs
can delete PODs
can create configmaps
```

**rolebindings**
**cluster-scoped** :
**clusterroles**

```
- cluster admin
can view nodes
can create nodes
can delete nodes

- can view PVs
- can create PVs
- can delete PVCs


```

**clusterrolebindings**

So the resources are categorized as either **namespaced** or \*\*cluster-scoped\*\*.

## **Namespaced Resources**

Tài nguyên không gian tên (Namespaced) được định phạm vi đến một không gian tên cụ thể trong cụm Kubernetes. Không gian tên là một cách để tổ chức và cô lập các tài nguyên trong một cụm. Mỗi tài nguyên trong một không gian tên phải có một tên duy nhất trong không gian tên đó.
Khi bạn tạo một tài nguyên có không gian tên, nó tồn tại và hoạt động trong ngữ cảnh của một không gian tên cụ thể. Điều này cho phép cô lập tài nguyên, giúp quản lý và tổ chức các ứng dụng trong cụm dễ dàng hơn.
`kubectl api-resource --namespaced=true`

```
[node1 ~]$ kubectl api-resources --namespaced=true
NAME                        SHORTNAMES   APIVERSION                     NAMESPACED   KIND
bindings                                 v1                             true         Binding
configmaps                  cm           v1                             true         ConfigMap
endpoints                   ep           v1                             true         Endpoints
events                      ev           v1                             true         Event
limitranges                 limits       v1                             true         LimitRange
persistentvolumeclaims      pvc          v1                             true         PersistentVolumeClaim
pods                        po           v1                             true         Pod
podtemplates                             v1                             true         PodTemplate
replicationcontrollers      rc           v1                             true         ReplicationController
resourcequotas              quota        v1                             true         ResourceQuota
secrets                                  v1                             true         Secret
serviceaccounts             sa           v1                             true         ServiceAccount
services                    svc          v1                             true         Service
controllerrevisions                      apps/v1                        true         ControllerRevision
daemonsets                  ds           apps/v1                        true         DaemonSet
deployments                 deploy       apps/v1                        true         Deployment
replicasets                 rs           apps/v1                        true         ReplicaSet
statefulsets                sts          apps/v1                        true         StatefulSet
localsubjectaccessreviews                authorization.k8s.io/v1        true         LocalSubjectAccessReview
horizontalpodautoscalers    hpa          autoscaling/v2                 true         HorizontalPodAutoscaler
cronjobs                    cj           batch/v1                       true         CronJob
jobs                                     batch/v1                       true         Job
leases                                   coordination.k8s.io/v1         true         Lease
endpointslices                           discovery.k8s.io/v1            true         EndpointSlice
events                      ev           events.k8s.io/v1               true         Event
ingresses                   ing          networking.k8s.io/v1           true         Ingress
networkpolicies             netpol       networking.k8s.io/v1           true         NetworkPolicy
poddisruptionbudgets        pdb          policy/v1                      true         PodDisruptionBudget
rolebindings                             rbac.authorization.k8s.io/v1   true         RoleBinding
roles                                    rbac.authorization.k8s.io/v1   true         Role
csistoragecapacities                     storage.k8s.io/v1              true         CSIStorageCapacity
```

## **Cluster-Scoped Resources**

Mặt khác, các tài nguyên có phạm vi cụm(Cluster-Scoped) không bị ràng buộc với một không gian tên cụ thể và có thể truy cập được trên toàn bộ cụm Kubernetes. Các tài nguyên này mang tên toàn cầu và áp dụng cho toàn bộ cụm, bất kể không gian tên.
Các tài nguyên có phạm vi cụm thường được sử dụng cho các cấu hình, chính sách kiểm soát truy cập và các tính năng cấp cụm cần áp dụng trên tất cả các không gian tên.
`kubectl api-resources --namespaced=false`

```
[node1 ~]$ kubectl api-resources --namespaced=false
NAME                              SHORTNAMES   APIVERSION                             NAMESPACED   KIND
componentstatuses                 cs           v1                                     false        ComponentStatus
namespaces                        ns           v1                                     false        Namespace
nodes                             no           v1                                     false        Node
persistentvolumes                 pv           v1                                     false        PersistentVolume
mutatingwebhookconfigurations                  admissionregistration.k8s.io/v1        false        MutatingWebhookConfiguration
validatingwebhookconfigurations                admissionregistration.k8s.io/v1        false        ValidatingWebhookConfiguration
customresourcedefinitions         crd,crds     apiextensions.k8s.io/v1                false        CustomResourceDefinition
apiservices                                    apiregistration.k8s.io/v1              false        APIService
tokenreviews                                   authentication.k8s.io/v1               false        TokenReview
selfsubjectaccessreviews                       authorization.k8s.io/v1                false        SelfSubjectAccessReview
selfsubjectrulesreviews                        authorization.k8s.io/v1                false        SelfSubjectRulesReview
subjectaccessreviews                           authorization.k8s.io/v1                false        SubjectAccessReview
certificatesigningrequests        csr          certificates.k8s.io/v1                 false        CertificateSigningRequest
flowschemas                                    flowcontrol.apiserver.k8s.io/v1beta3   false        FlowSchema
prioritylevelconfigurations                    flowcontrol.apiserver.k8s.io/v1beta3   false        PriorityLevelConfiguration
ingressclasses                                 networking.k8s.io/v1                   false        IngressClass
runtimeclasses                                 node.k8s.io/v1                         false        RuntimeClass
clusterrolebindings                            rbac.authorization.k8s.io/v1           false        ClusterRoleBinding
clusterroles                                   rbac.authorization.k8s.io/v1           false        ClusterRole
priorityclasses                   pc           scheduling.k8s.io/v1                   false        PriorityClass
csidrivers                                     storage.k8s.io/v1                      false        CSIDriver
csinodes                                       storage.k8s.io/v1                      false        CSINode
storageclasses                    sc           storage.k8s.io/v1                      false        StorageClass
volumeattachments                              storage.k8s.io/v1                      false        VolumeAttachment
```

## Key Differences:

Tài nguyên Namespaced:
Phạm vi đến một không gian tên cụ thể.
Tên của tài nguyên phải là duy nhất trong một không gian tên.
Tài nguyên được cô lập và tổ chức trong không gian tên.
Tài nguyên Cluster-Scoped:
Không bị ràng buộc với một không gian tên cụ thể.
Tên của các tài nguyên phải là duy nhất trên toàn bộ cụm.
Áp dụng toàn cầu trên tất cả các không gian tên.

## Choosing Between Namespaced and Cluster-Scoped Resources:

Sự lựa chọn giữa tài nguyên có tên và phạm vi cụm phụ thuộc vào trường hợp sử dụng và phạm vi của tài nguyên. Sử dụng tài nguyên không gian tên khi bạn cần cách ly tài nguyên, tổ chức và khi tài nguyên cụ thể cho một ứng dụng hoặc nhóm cụ thể.
Sử dụng các tài nguyên có phạm vi cụm cho các cấu hình và chính sách cần áp dụng trên toàn cầu trên toàn bộ cụm.

## solution 1:

A new user michelle joined the team. She will be focusing on the nodes in the cluster. Create the required ClusterRoles and ClusterRoleBindings so she gets access to the nodes.

Use the command kubectl create to create a clusterrole and clusterrolebinding for user michelle to grant access to the nodes.
After that test the access using the command kubectl auth can-i list nodes --as michelle.

## solution 2:

michelle's responsibilities are growing and now she will be responsible for storage as well. Create the required ClusterRoles and ClusterRoleBindings to allow her access to Storage.
Get the API groups and resource names from command kubectl api-resources. Use the given spec:

ClusterRole: storage-admin
Resource: persistentvolumes
Resource: storageclasses
ClusterRoleBinding: michelle-storage-admin
ClusterRoleBinding Subject: michelle
ClusterRoleBinding Role: storage-admin
**solution**
Use the command kubectl create to create a new ClusterRole and ClusterRoleBinding.
Assign it correct resources and verbs.
After that test the access using the command kubectl auth can-i list storageclasses --as michelle.
