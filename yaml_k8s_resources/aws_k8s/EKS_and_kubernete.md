`https://docs.aws.amazon.com/eks/latest/userguide/install-kubectl.html`

## Notes:

\*\*design pattern\*\*
`https://github.com/eksctl-io/eksctl/tree/main/examples`
`https://eksctl.io/`
`https://docs.aws.amazon.com/eks/latest/userguide/eksctl.html`
`https://eksctl.io/introduction/`
\*\*setup kubernete,EKS\*\*

## Cài đặt AWS CLI :

**configure** :
web: - AIM - token
cli: aws configure
check cli : aws sts get-caller-identity

## eksctl :

**Create a cluster with aws eksctl**
Tạo một cụm với aws eksctl
`eksctl create cluster --name my-cluster --region region-code`
`eksctl delete cluster --name my-cluster --region region-code`

**Add nodes to your cluster**

```
eksctl create nodegroup \
  --cluster my-cluster \
  --region region-code \
  --name my-mng \
  --node-ami-family ami-family \
  --node-type m5.large \
  --nodes 3 \
  --nodes-min 2 \
  --nodes-max 4 \
  --ssh-access \
  --ssh-public-key my-key

```

**Check the status of your pod once you add new nodes**

## kubectl on AWS:

`aws eks update-kubeconfig --region region-code --name my-cluster
`
`kubectl cluster info`
`kubectl get svc`
**check kubectl get nodes AWS**
`kubectl get nodes -o wide`
`kubectl get pods -A -o wide`
`kubectl get svc`
**Create a test pod in your cluster**
