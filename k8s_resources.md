## k8s_architecture

**master Node**

- APIservice (người dùng giao tiếp qua kubectl, M giao tiếp W )
- ETCD (cơ sở dữ liệu k8s )
- Scheduler (lên kế hoạch và đặt các Container,Pod dựa vào tài nguyên có sẵn worker node,master node)
- k8s Management Controller ( điều khiển và duy trì các Node)

**worker Node**

- kubelet (nhận các nhiệm vụ của APIService và quản lý Pod ,quản lý Container trong Pod)
- COntainer Runtime
- kube proxy ( nhận các nhiệm vụ của Master và chịu trách nhiệm quản lý mạng của worker Node)

**Container**
https://linuxcontainers.org/ - LXC
IPC- Inter Process Communication
Cgroup
Network
Mount
PID
User
UTS - Unix Timesharing System
**Pod**
ip adress
volume
Container App
