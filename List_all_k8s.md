## **Architecture Master-Node**

- Kubernetes API - How does communication happen behind the scenes?
- Kube-Scheduler - Choosing nodes to host pods
- Kube-Controller - Know the types of controllers in k8s
- Etcd - Kubernetes Database
- Kubelet – The K8s Agent
- Kube-Proxy - A very powerful service
- Container Runtime - Docker again!

## 1.Pod

## 2.Replicasets

replicas in Pods

## 3.Deployment

Create yaml pod
create yaml replicasets
create yaml deployment

Rolling update
Rollback

## 4. Service and Endpoints

Pod and Endpoints
Tóm lại, Pods là các đơn vị lưu trữ các ứng dụng và Endpoints giúp ánh xạ dịch vụ đến các Pods đang chạy thực tế, tạo điều kiện giao tiếp mạng và cân bằng tải trong cụm Kubernetes.
Service and DNS
ClusterIP
NodePort
LoadBalancer

## 5. Namespaces

## 6. Limit the CPU and memory PODs

fix CPU and memory on Pods

## 7. LimitRange on Pods

range minimum and maximum values on Pod

## 8. ResourceQuota

Limit the number of pods that can be created in a Namespace
range minimum and maximum values on Namespace
fix CPU and memory

## 9. Health checks & Probes

monitor status container
monitor webapp running on container
**livenessprobe**
**readinessprobe**

## 10. configmaps and environment variables

Inject data into your Pods
Đưa dữ liệu vào Pod của bạn (folder , file ,environment variables )

- Mount a ConfigMap as a Volume without specifying Items
- Create a new ConfigMap to inject as an environment variable . Configure your Pod to consume the ConfigMap via environment variables

## 11. Secrets

Tìm hiểu cách quản lý dữ liệu nhạy cảm trong Kubernetes

## 12. Volumes: data persistence

Kubernetes Volumes - Hiểu các khái niệm đằng sau việc lưu giữ dữ liệu
Volume of type emptyDir
Volume of type hostPath
Cloud type volume
What is a PVC and a PV?
Reclaim Policy

## 13. Kubernetes Volumes - Empty Dir, HostPath, PV, PVC, StorageClasses

Create PV/PVC
Reclaim Policy: Retain
Reclaim Policy: Recycle
Reclaim Policy: Delete

## 14. Role Based Access Control: Users & Groups

Human
users & Groups en Kubernetes
Create certificates for a user in Kubernetes
Make sure RBAC is enabled
Create a Role to allow reading to Pods in a Namespace
Create a RoleBinding to join your User with the Role you created
Create a ClusterRole to list Pods in all namespaces
Assign Roles to a Group

## 15. Role Based Access Control: ServiceAccount

machine ( jenkins , k8s dashboard, grafana , prometheus...)
Understand the relationship of a Pod with a ServiceAccount
Secrets automatically mounted in Pods
Attempt to send requests without auth to the Kubernetes API
Use JWT to send authenticated requests to the k8s API
Assign a ServiceAccount to a Deployment
Apply Roles to a ServiceAccount to list Pods
Validate that permissions

## 16. Ingress

Learn to expose your applications outside of the Cluster
Tìm hiểu cách hiển thị các ứng dụng của bạn bên ngoài Cụm
What is an Ingress Controller?
Create your first **Ingress Controller**
Create a **NodePort** service to expose your Ingress Controller
Create a **simple Deployment** to expose an application through **Ingress**
Create **rules** in **Ingress** to expose your app
Apply **rules per host** and **rules per path** in Ingress ( ducla.com and ducla.com/le)
