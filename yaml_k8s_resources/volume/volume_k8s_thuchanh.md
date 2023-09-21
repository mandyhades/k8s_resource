# Kubernetes volume :

## Empty Dir:

### How to create an EmptyDir for cache?

Để tạo một khối lượng EmptyDir trong Kubernetes cho mục đích lưu trữ, bạn có thể xác định một nhóm sử dụng một khối lượng EmptyDir và gắn nó tại một đường dẫn được chỉ định nơi ứng dụng của bạn có thể lưu trữ dữ liệu. Ổ đĩa EmptyDir là một bộ nhớ tạm thời được tạo và xóa cùng với nhóm.
Đây là hướng dẫn từng bước để tạo một nhóm với âm lượng EmptyDir để lưu vào bộ nhớ đệm:

1. Create a YAML file (e.g., pod_emptydir_cache.yaml) and define the pod configuration:

```
apiVersion: v1
kind: Pod
metadata:
  name: cache-pod
spec:
  containers:
    - name: cache-container
      image: your-cache-image:tag
      volumeMounts:
        - name: cache-volume
          mountPath: /cache
  volumes:
    - name: cache-volume
      emptyDir: {}

```

Replace **your-cache-image:tag** with the actual image and tag for your caching application. In this example, we're mounting the EmptyDir volume at /cache within the container.

Apply the configuration to create the pod:

```
kubectl apply -f pod_emptydir_cache.yaml
```

Điều này sẽ tạo ra nhóm với cấu hình được chỉ định.

Khối lượng EmptyDir được tạo ra trong suốt vòng đời của vỏ và ban đầu trống rỗng. Nó được chia sẻ giữa tất cả các vùng chứa trong nhóm, cho phép chúng đọc và ghi dữ liệu vào cùng một vị trí.

Bạn có thể sử dụng thư mục /cache này trong ứng dụng của mình để lưu trữ và truy xuất dữ liệu cache. Hãy nhớ rằng bất kỳ dữ liệu nào được lưu trữ trong ổ đĩa EmptyDir đều là phù du và sẽ bị mất nếu nhóm bị xóa hoặc lên lịch lại. Nếu bạn cần dữ liệu liên tục, hãy cân nhắc sử dụng các loại âm lượng khác như PersistentVolume (PV) được hỗ trợ bởi PersistentVolumeClaim (PVC).

## HostPath:

## StorageClasses:

## Static Provisioning - Create PV/PVC manually:

Static Provisioning - Create PV/PVC manually

Việc cung cấp tĩnh trong Kubernetes bao gồm việc tạo và quản lý PersistentVolumes (PV) và PersistentVolumeClaims (PVC) theo cách thủ công mà không cần dựa vào việc cung cấp động từ các lớp lưu trữ. Cách tiếp cận này hữu ích khi bạn có sẵn tài nguyên lưu trữ mà bạn muốn quản lý một cách rõ ràng.

Dưới đây là hướng dẫn từng bước để tạo PersistentVolume (PV) và PersistentVolumeClaim (PVC) theo cách thủ công bằng cách sử dụng tính năng cung cấp tĩnh:

### **Step 1**: Create a PersistentVolume (PV)

Create a YAML file (e.g., pv.yaml) defining the PersistentVolume.

```
apiVersion: v1
kind: PersistentVolume
metadata:
  name: my-static-pv
spec:
  capacity:
    storage: 10Gi
  volumeMode: Filesystem
  accessModes:
    - ReadWriteOnce
  hostPath:
    path: /path/on/host # Replace with the actual host path

```

**metadata.name**: Name of the PersistentVolume (my-static-pv in this example).
**spec.capacity**: Capacity of the volume (e.g., 10Gi).
**spec.volumeMode**: Volume mode (Filesystem for file system access).
**spec.accessModes**: Access mode(s) (ReadWriteOnce in this example).
**spec.hostPath.path**: Path on the host machine to use for the volume.
Apply the PersistentVolume configuration:

```
kubectl apply -f pv.yaml
```

### **Step 2**: Create a PersistentVolumeClaim (PVC)

Create a YAML file (e.g., pvc.yaml) defining the PersistentVolumeClaim.

```
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: my-pvc
spec:
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 5Gi

```

**metadata.name**: Name of the PersistentVolumeClaim (my-pvc in this example).
**spec.accessModes**: Access mode(s) (ReadWriteOnce in this example).
**spec.resources.requests.storage**: Requested storage (e.g., 5Gi).
Apply the PersistentVolumeClaim configuration:

```
kubectl apply -f pvc.yaml

```

Bây giờ, PVC được tạo ra và sẽ cố gắng liên kết với một PV có sẵn với các chế độ truy cập và dung lượng lưu trữ phù hợp.

### **Step 3**: Bind the PVC to the PV

Nếu PV được tạo ở Bước 1 phù hợp với yêu cầu của PVC, PVC sẽ tự động liên kết với nó. Để xác minh ràng buộc, bạn có thể kiểm tra trạng thái PVC:

```
kubectl get pvc my-pvc

```

### **Step 4**: Use the PVC in a Pod

Tạo một Pod sử dụng PVC bằng cách tham chiếu nó trong phần âm lượng của YAML của Pod.

```
apiVersion: v1
kind: Pod
metadata:
  name: my-pod
spec:
  containers:
    - name: my-container
      image: nginx
      volumeMounts:
        - name: my-volume
          mountPath: /usr/share/nginx/html
  volumes:
    - name: my-volume
      persistentVolumeClaim:
        claimName: my-pvc

```

volumeMounts: Mount the volume to a specific path in the container.
volumes.persistentVolumeClaim.claimName: Reference the PVC (my-pvc in this example).
Apply the Pod configuration:

```
kubectl apply -f pod.yaml

```

Now, the Pod is using the PVC, which is backed by the specified PV.
Hãy nhớ rằng khi sử dụng **static provisioning**, bạn cần quản lý việc cung cấp, vòng đời và xóa PV và PVC theo cách thủ công. Mặt khác, **Dynamic provisioning** sẽ tự động tạo và quản lý tài nguyên lưu trữ dựa trên các storage classes và PVC được xác định.

## Create a Persistent Volume Claim without selectors

Trong Kubernetes, PersistentVolumeClaims (PVCs) có thể được tạo có hoặc không có bộ chọn. Khi PVC được tạo mà không có bộ chọn, đó là cách để yêu cầu lưu trữ dựa trên các thuộc tính cụ thể như chế độ truy cập và dung lượng lưu trữ, nhưng nó sẽ không tự động liên kết với một PersistentVolume (PV) cụ thể. Sau đó, bạn có thể liên kết PVC theo cách thủ công với PV phù hợp nếu cần.
Step 1: Create a PVC YAML file
Create a YAML file (e.g., pvc_without_selectors.yaml) defining the PersistentVolumeClaim without selectors.

```
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: my-pvc
spec:
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 5Gi

```

**metadata.name**: Name of the PersistentVolumeClaim (my-pvc in this example).
**spec.accessModes**: Access mode(s) (ReadWriteOnce in this example).
**spec.resources.requests.storage**: Requested storage (e.g., 5Gi).

Step 2: Apply the PVC configuration
Apply the PersistentVolumeClaim configuration using kubectl apply.

```
kubectl apply -f pvc_without_selectors.yaml

```

Bây giờ, PVC đã được tạo và đang ở trạng thái chờ xử lý vì nó không bị ràng buộc với bất kỳ PV nào.
Step 3: Manually bind the PVC to a PV
Để liên kết PVC với một PV cụ thể, bạn cần chọn thủ công một PV phù hợp dựa trên yêu cầu của bạn (dung lượng, chế độ truy cập, v.v.) và chỉ định tên của PV trong YAML của PVC. Đây là một ví dụ sửa đổi cho PVC YAML:

```
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: my-pvc
spec:
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 5Gi
  volumeName: my-pv

```

Thay thế my-pv bằng tên của PV mà bạn muốn liên kết.
Step 4: Apply the updated PVC configuration
Apply the updated PersistentVolumeClaim configuration.

```
kubectl apply -f pvc_without_selectors.yaml

```

Bây giờ, PVC được liên kết với PV được chỉ định và bạn có thể sử dụng nó trong các node khi cần thiết.
Hãy nhớ rằng khi sử dụng PVC mà không có bộ chọn, bạn cần quản lý thủ công việc ràng buộc với các PV thích hợp dựa trên yêu cầu của mình. Điều này cho phép bạn kiểm soát nhiều hơn đối với quá trình phân công và cung cấp lưu trữ

## Create a Persistent Volume Claim with selectors

## Understand the importance of a PV/PVC

## Assign a PVC to a Pod to persist data

## Storage Classes k8s (cloud, nfs, iscsi)

```
kubectl get sc
```

Trong Kubernetes, StorageClasses là một cách để xác định các lớp lưu trữ khác nhau với các khả năng khác nhau. Chúng cho phép bạn mô tả loại lưu trữ cần thiết bởi PersistentVolumeClaims (PVCs) theo cách trừu tượng và linh hoạt hơn. StorageClasses rất cần thiết cho việc cung cấp động PersistentVolumes (PVs) dựa trên các chính sách và cấu hình được xác định trước.

Đây là bảng phân tích của StorageClasses trong Kubernetes:

**Definition**
Một StorageClass được xác định bằng cách sử dụng bản kê khai YAML, chỉ định các tham số, trình cung cấp, chính sách thu hồi và các thuộc tính khác được liên kết với lớp lưu trữ.

```
apiVersion: storage.k8s.io/v1
kind: StorageClass
metadata:
  name: standard
provisioner: kubernetes.io/aws-ebs  # Storage provisioner
parameters:
  type: gp2  # Parameters specific to the provisioner
reclaimPolicy: Delete  # Reclaim policy for PVs created by this StorageClass

```

**Provisioners**
Các nhà cung cấp chịu trách nhiệm tạo PV một cách linh hoạt. Các nhà cung cấp khác nhau hỗ trợ các phụ trợ lưu trữ khác nhau, chẳng hạn như các nhà cung cấp đám mây (ví dụ: AWS, GCP) hoặc các hệ thống lưu trữ tại chỗ (ví dụ: NFS, iSCSI).
**Parameters**
Các thông số dành riêng cho người cung cấp và xác định các đặc điểm của bộ lưu trữ được cung cấp, chẳng hạn như loại lưu trữ, loại đĩa, IOPS, v.v.
**Reclaim Policy**
Chính sách thu hồi xác định điều gì sẽ xảy ra với PV liên quan khi PVC bị xóa. Các chính sách phổ biến bao gồm Delete (xóa bộ nhớ liên quan) và Retain (giữ lại bộ nhớ).
**Dynamic Provisioning**
Khi PVC được tạo mà không chỉ định PV và với một StorageClass cụ thể, Kubernetes sử dụng StorageClass được chỉ định để tự động cung cấp PV phù hợp với các yêu cầu được xác định trong StorageClass.
**Manual Provisioning**
Nếu PVC chỉ định một PV cụ thể (sử dụng volumeName), nó được coi là cung cấp thủ công. PV phải đã tồn tại và phải phù hợp với các yêu cầu của PVC.
**Example Usage**
Xác định một PVC tham chiếu đến một StorageClass:

```
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: my-pvc
spec:
  storageClassName: standard
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 5Gi

```

Trong ví dụ này, PVC sử dụng StorageClass có tên tiêu chuẩn để yêu cầu 5Gi lưu trữ với chế độ truy cập ReadWriteOnce.
StorageClasses rất quan trọng để cung cấp lưu trữ động dựa trên nhu cầu ứng dụng và cho phép sử dụng tài nguyên tốt hơn và tự động hóa trong các cụm Kubernetes. Chúng cung cấp một mức độ trừu tượng, cho phép các quản trị viên và nhà phát triển xác định các yêu cầu lưu trữ theo cách linh hoạt và hiệu quả hơn.

## PV, PVC Dynamic Provisioning (cloud, nfs, iscsi)

Cung cấp động trong Kubernetes đề cập đến việc tự động tạo tài nguyên lưu trữ (PersistentVolumes hoặc PVs) khi cần thiết bởi PersistentVolumeClaims (PVCs). Đây là một tính năng mạnh mẽ giúp loại bỏ nhu cầu tạo tài nguyên lưu trữ thủ công, giúp quản lý lưu trữ trong Kubernetes hiệu quả và tự động hơn.
Đây là các bước và thành phần chính liên quan đến việc cung cấp động:
**Storage Classes**
Các lớp lưu trữ được sử dụng để xác định các lớp lưu trữ khác nhau và các trình cung cấp và cấu hình liên quan của chúng. Chúng hoạt động như các mẫu để cung cấp động và giúp Kubernetes xác định cách cung cấp lưu trữ dựa trên các yêu cầu của PVC.

Đây là một ví dụ về định nghĩa YAML của StorageClass:

```
apiVersion: storage.k8s.io/v1
kind: StorageClass
metadata:
  name: standard
provisioner: kubernetes.io/aws-ebs
parameters:
  type: gp2

```

**Provisioner**:
Trình cung cấp được chỉ định trong StorageClass xác định loại phụ trợ lưu trữ sẽ được cung cấp động. Các nhà cung cấp có thể dành riêng cho các nhà cung cấp đám mây khác nhau (ví dụ: AWS, GCP, Azure) hoặc các hệ thống lưu trữ (ví dụ: NFS, iSCSI).
Trong ví dụ trên, trình cung cấp kubernetes.io/aws-ebs được sử dụng để cung cấp khối lượng AWS Elastic Block Store (EBS).
**Parameters**:
Các thông số trong StorageClass cho phép bạn tùy chỉnh việc cung cấp lưu trữ dựa trên trình cung cấp. Ví dụ, chỉ định loại lưu trữ (ví dụ: gp2 cho AWS EBS) hoặc các cài đặt cấu hình khác.
**PersistentVolumeClaim (PVC)**

```
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: my-pvc
spec:
  storageClassName: standard
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 5Gi

```

Trong ví dụ này, PVC sử dụng StorageClass có tên tiêu chuẩn để yêu cầu 5Gi lưu trữ với chế độ truy cập ReadWriteOnce.
**Automatic Provisioning**:
Khi PVC được tạo, Kubernetes sẽ kiểm tra Lớp lưu trữ được chỉ định để cung cấp động. Nếu tính năng cung cấp động được bật cho StorageClass đó, Kubernetes sẽ sử dụng trình cung cấp được xác định trong StorageClass để tự động tạo PV phù hợp với yêu cầu của PVC.
PV sau đó được liên kết với PVC và ứng dụng có thể sử dụng nó để lưu trữ.
Dynamic provisioning đơn giản hóa quy trình cung cấp lưu trữ, cho phép quản trị viên và nhà phát triển xác định các yêu cầu lưu trữ theo cách trừu tượng hơn trong khi đảm bảo tài nguyên lưu trữ phù hợp có sẵn khi cần. Nó đặc biệt hữu ích trong môi trường đám mây nơi nhu cầu lưu trữ có thể dao động và quản lý tài nguyên hiệu quả là rất quan trọng.

## Reclaim Policy

Reclaim Policy: Retain
Hoàn hảo đây là một hành vi rất tốt vì vậy về cơ bản đây là cách Reclaim hoạt động Reclaim và bạn sẽ thấy k8s loại bỏ nó và không loại bỏ nó nhưng cũng không cung cấp nó cho khách hàng mới.
Vì vậy, tại thời điểm này, rất nhiều điều phụ thuộc vào quản trị viên k8s.Bạn sẽ làm gì với thông tin này mà không lưu nó và xóa nó và xóa PVC, v.v.
Reclaim Policy: Recycle
sẽ bị xoá khi loại bỏ
Reclaim Policy: Delete
sẽ bị xoá khi loại bỏ
