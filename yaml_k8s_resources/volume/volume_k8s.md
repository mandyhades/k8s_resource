## volume k8s

In Kubernetes, a volume is a way to store and manage data in a pod. Volumes enable data to persist beyond the life of a pod and can be shared between multiple containers within the same pod. Volumes are crucial for handling data in stateful applications, providing a mechanism to handle storage requirements such as databases, file storage, and more.

### **Volume Types**:

## a. **EmptyDir**: An EmptyDir volume is created when a pod is assigned to a node. It exists as long as the pod is running on that node. If the pod is removed or rescheduled, the data in EmptyDir is lost.

## b. **HostPath**: A HostPath volume mounts a directory or file from the host node's filesystem into the pod. This can be useful for accessing node-specific resources.

## c. **PersistentVolume (PV)**: A PersistentVolume is a cluster-wide storage resource that can be dynamically provisioned or pre-provisioned. It allows persistent storage to be used by applications independent of the pod lifecycle.

## d. **PersistentVolumeClaim (PVC)**: A PersistentVolumeClaim is a request for storage by a pod. It allows the pod to request a specific amount and type of storage.

## e. **NFS, GlusterFS, etc**.: Kubernetes supports various network-based storage systems that can be used as volumes, such as NFS, GlusterFS, Ceph, etc.

## f. **ConfigMap and Secret**: ConfigMap and Secret can be used as volumes to inject configuration data or sensitive information into a pod.

g. **CSI (Container Storage Interface)**: CSI allows the integration of different storage systems with Kubernetes, providing flexibility and abstraction.

## Volume Mounts:

Volume mounts are specified within a container's specification in a pod definition. They define where the volume is mounted inside the container.
được chỉ định trong đặc tả của vùng chứa trong định nghĩa nhóm. Chúng xác định vị trí ổ đĩa được gắn bên trong vùng chứa.

```
containers:
  - name: my-container
    image: my-image
    volumeMounts:
      - name: my-volume
        mountPath: /path/to/mount

```

## Pod-Level Volumes:

Volumes can be defined at the pod level, and any containers in that pod can access the volume.

```
apiVersion: v1
kind: Pod
metadata:
  name: mypod
spec:
  containers:
    - name: my-container
      image: my-image
      volumeMounts:
        - name: my-volume
          mountPath: /path/to/mount
  volumes:
    - name: my-volume
      hostPath:
        path: /host/path

```

### Volume Modes:

Volumes can be mounted in two modes:

#### **ReadWriteOnce (RWO)**: The volume can be mounted as read-write by a single node.

#### **ReadOnlyMany (ROX)**: The volume can be mounted as read-only by many nodes.

#### **ReadWriteMany (RWX)**: The volume can be mounted as read-write by many nodes (not supported by all volume types).

Volume trong Kubernetes cung cấp một cách linh hoạt và mạnh mẽ để xử lý dữ liệu trong các pod và đảm bảo rằng các ứng dụng có quyền truy cập vào storage và data cần thiết trong suốt vòng đời của chúng.

### Reclaim Policy :

"Reclaim Policy" trong Kubernetes đề cập đến chiến lược hoặc hành động được thực hiện khi PersistentVolume (PV) được phát hành hoặc không còn cần thiết bởi PersistentVolumeClaim (PVC). Nó ra lệnh điều gì sẽ xảy ra với bộ nhớ cơ bản liên quan đến PV.

Trong Kubernetes, có ba Chính sách Thu hồi chính cho PersistentVolumes:

#### Retain:

In this policy, when a PV is released or the associated PVC is deleted, the PV remains in a "Released" state. The data is not deleted, and it's up to the administrator to manually reclaim the storage. This often involves deleting the data or repurposing it for another use. The storage resource is not made available for a new PVC until manually reclaimed.

Giữ lại:
Trong chính sách này, khi PV được giải phóng hoặc PVC liên quan bị xóa, PV vẫn ở trạng thái "Đã phát hành". Dữ liệu không bị xóa và quản trị viên phải lấy lại bộ nhớ theo cách thủ công. Điều này thường liên quan đến việc xóa dữ liệu hoặc tái sử dụng nó cho mục đích sử dụng khác. Tài nguyên lưu trữ không có sẵn cho một PVC mới cho đến khi được thu hồi thủ công.

```
spec:
  persistentVolumeReclaimPolicy: Retain

```

#### Delete :

Với chính sách này, khi PV được phát hành hoặc PVC liên quan bị xóa, PV sẽ bị xóa ngay lập tức và bộ nhớ cơ bản sẽ bị xóa. Điều này có nghĩa là dữ liệu bị xóa vĩnh viễn và không thể khôi phục được.

```
spec:
  persistentVolumeReclaimPolicy: Delete

```

#### Recycle (Deprecated):

Chính sách này đã bị phản đối trong các phiên bản Kubernetes gần đây (v1.14 trở lên) và không còn được khuyến nghị nữa. Trong chính sách này, khi PV được giải phóng hoặc PVC liên quan bị xóa, PV được đặt lại về trạng thái ban đầu, về cơ bản là xóa dữ liệu. Tuy nhiên, chính sách này không đáng tin cậy, và do đó nó đã bị phản đối.

```
spec:
  persistentVolumeReclaimPolicy: Recycle

```

Chính sách đòi lại(Reclaim Policy) được chỉ định khi xác định một PersistentVolume. Ví dụ:

```
apiVersion: v1
kind: PersistentVolume
metadata:
  name: example-pv
spec:
  capacity:
    storage: 5Gi
  volumeMode: Filesystem
  accessModes:
    - ReadWriteOnce
  persistentVolumeReclaimPolicy: Retain
  storageClassName: standard
  hostPath:
    path: /path/on/host

```
