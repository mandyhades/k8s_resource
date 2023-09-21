https://docs.aws.amazon.com/eks/latest/userguide/eks-networking.html

## Requirements for Entry at IAM Level

(Yêu cầu đầu vào ở cấp độ IAM)

```
eksctl create iamserviceaccount \
    --name aws-node \
    --namespace kube-system \
    --cluster my-cluster \
    --role-name AmazonEKSVPCCNIRole \
    --attach-policy-arn arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy \
    --override-existing-serviceaccounts \
    --approve
```

## Deploy the ALB ingress controller

Triển khai bộ điều khiển xâm nhập ALB

## Deploy a test application

Triển khai một ứng dụng thử nghiệm

## Add an Ingress resource to define routing rules

Thêm tài nguyên Ingress để xác định quy tắc định tuyến

## Modify Ingress rules in AWS

Sửa đổi quy tắc Ingress trong AWS

## Delete the resources you created

Xóa tài nguyên bạn đã tạo
