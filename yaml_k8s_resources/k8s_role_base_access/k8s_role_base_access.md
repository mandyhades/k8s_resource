Kiểm soát truy cập dựa trên vai trò (RBAC) trong Kubernetes là một phương pháp để kiểm soát quyền truy cập vào API Kubernetes và các tài nguyên dựa trên vai trò và quyền. Nó cho phép bạn xác định các chính sách truy cập chi tiết, cấp hoặc từ chối quyền cho người dùng và tài khoản dịch vụ trong cụm Kubernetes.
Đây là hướng dẫn từng bước để thiết lập RBAC trong Kubernetes:

**Step 1: Enable RBAC**
Đảm bảo rằng RBAC được kích hoạt trong cụm Kubernetes của bạn. Theo mặc định, RBAC thường được kích hoạt trong các cụm Kubernetes hiện đại. Nếu bạn đang sử dụng dịch vụ Kubernetes được quản lý, nó có thể đã được kích hoạt.
**Step 2: Create Service Accounts**
Tạo tài khoản dịch vụ cho các ứng dụng hoặc người dùng của bạn. Tài khoản dịch vụ đại diện cho một danh tính có thể được sử dụng để xác thực và ủy quyền các yêu cầu đến máy chủ Kubernetes API.

```
apiVersion: v1
kind: ServiceAccount
metadata:
  name: my-app-service-account
```

Apply the service account configuration using kubectl apply.
Áp dụng cấu hình tài khoản dịch vụ bằng cách sử dụng kubectl apply.
**Step 3: Create Roles and RoleBindings**
Xác định vai trò (RBAC Role) chỉ định các quyền (verbs and resources) để truy cập tài nguyên trong không gian tên.

```
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  name: my-role
rules:
- apiGroups: [""]
  resources: ["pods"]
  verbs: ["get", "list", "watch"]

```

Next, bind the role to a service account using a RoleBinding.
Tiếp theo, liên kết vai trò với tài khoản dịch vụ bằng cách sử dụng RoleBinding.

```
apiVersion: rbac.authorization.k8s.io/v1
kind: RoleBinding
metadata:
  name: my-role-binding
subjects:
- kind: ServiceAccount
  name: my-app-service-account
roleRef:
  kind: Role
  name: my-role
  apiGroup: rbac.authorization.k8s.io

```

Apply the Role and RoleBinding configurations using kubectl apply.
Áp dụng cấu hình Vai trò và Liên kết vai trò bằng cách sử dụng kubectl.

**Step 4: Create ClusterRoles and ClusterRoleBindings (optional)**
Nếu bạn cần xác định vai trò và ràng buộc áp dụng trên toàn bộ cụm, bạn có thể sử dụng ClusterRoles và ClusterRoleBindings thay vì Roles và RoleBindings.

**Step 5: Test Access**
Để kiểm tra quyền truy cập, hãy triển khai Pod bằng tài khoản dịch vụ bạn đã tạo trước đó.

```
apiVersion: v1
kind: Pod
metadata:
  name: my-pod
spec:
  serviceAccountName: my-app-service-account
  containers:
  - name: my-container
    image: nginx

```

Apply the Pod configuration using kubectl apply.You can then access and interact with the resources based on the permissions defined in the roles.
Áp dụng cấu hình Pod bằng cách sử dụng kubectl apply. Sau đó, bạn có thể truy cập và tương tác với các tài nguyên dựa trên các quyền được xác định trong các vai trò.
RBAC trong Kubernetes cung cấp một cách mạnh mẽ và linh hoạt để quản lý quyền truy cập vào Kubernetes API và tài nguyên, đảm bảo rằng người dùng và ứng dụng có quyền thích hợp trong khi vẫn duy trì bảo mật trong cụm.

**chu y**
Cảnh báo: tài khoản dịch vụ tài nguyên/my-app-service-account thiếu chú thích kubectl.kubernetes.io/last-applied-configuration mà kubectl apply yêu cầu. kubectl apply chỉ nên được sử dụng trên các tài nguyên được khai báo bằng kubectl create --save-config hoặc kubectl apply. Chú thích bị thiếu sẽ được vá tự động.
