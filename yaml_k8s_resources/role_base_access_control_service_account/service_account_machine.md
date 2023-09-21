# service account machine:

Service Accout: danh cho kubernete dashboards , grafana ,prometheus , log stack , kibana ...

## Default ServiceAccounts

ServiceAccounts Default all namespaces
ServiceAccounts ===> secret ===> token

```
kubectl get serviceaccount
kubectl create ns hola
kubectl get serviceaccount -n hola
kubectl get sa -n kube-system

```

chosen token 2020,2021 (secret: token):

```
kubectl get sa default -o yaml

```

## Explore the secret that is related to the ServiceAccount

Khám phá Secret liên quan đến ServiceAccount

## Create your own ServiceAccount

```
apiVersion: v1
kind: ServiceAccount
metadata:
  name: my-sa
```

## Understand the relationship of a Pod with a ServiceAccount

Hiểu mối quan hệ của Pod với ServiceAccount
Pod co ServiceAccount Default

## Secrets automatically mounted in Pods

secret gan vao folder trong pod :
kubectl exec -it test --sh
cd /var/run/secret ...

## Attempt to send requests without auth to the Kubernetes API

gửi yêu cầu mà không cần xác thực tới API Kubernetes
kubectl exec -it test --sh
curl https://10.96.0.1/api/v1/namespaces/default/pods --insecure

```
https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.26/

Read Operations
Read
read the specified CronJob

HTTP Request
GET /apis/batch/v1/namespaces/{namespace}/cronjobs/{name}
```

## Use JWT to send authenticated requests to the k8s API

Sử dụng JWT để gửi yêu cầu đã xác thực tới API k8s

```
https://nieldw.medium.com/using-curl-to-authenticate-with-jwt-bearer-tokens-55b7fac506bd
```

```
curl -H "Authorization: Bearer ${TOKEN}" https://kubernetes/api/v1 --inscure
```

## Assign a ServiceAccount to a Deployment

ArgoCD use token deployment

## Apply Roles to a ServiceAccount to list Pods

kube dashboards use token check all pod on k8s

## Validate that permissions have been applied correctly

Xác thực rằng các quyền đã được áp dụng chính xác
