# ingress

## **note**

`https://devopscube.com/setup-ingress-kubernetes-nginx-controller/`
web app imgage: kodekloud/ecommerce:apparel , containerPort: 8080 ==> tcp
web video imgae: kodekloud/ecommerce:video ,containerPort: 8080 ==> tcp
backend image: kodekloud/ecommerce:404 , containerPort: 8080 ==> tcp

## **step1**

Which namespace is the Ingress Controller deployed in?
**solution**
Use the command kubectl get all -A and identify the namespace of Ingress Controller.

## **step2**

all pod:

```
controlplane ~ ➜  kubectl get pod -A
NAMESPACE       NAME                                        READY   STATUS      RESTARTS   AGE
app-space       default-backend-7845d8c4f-mkmk9             1/1     Running     0          31m
app-space       webapp-video-55fcd88897-pf6kf               1/1     Running     0          31m
app-space       webapp-wear-554bbffcd6-4rb29                1/1     Running     0          31m
ingress-nginx   ingress-nginx-admission-create-tcwh6        0/1     Completed   0          31m
ingress-nginx   ingress-nginx-admission-patch-l8rfg         0/1     Completed   0          31m
ingress-nginx   ingress-nginx-controller-5d48d5445f-x4xn8   1/1     Running     0          31m
kube-flannel    kube-flannel-ds-8lsp4                       1/1     Running     0          42m
kube-system     coredns-5d78c9869d-lpsfq                    1/1     Running     0          42m
kube-system     coredns-5d78c9869d-wd8f4                    1/1     Running     0          42m
kube-system     etcd-controlplane                           1/1     Running     0          42m
kube-system     kube-apiserver-controlplane                 1/1     Running     0          42m
kube-system     kube-controller-manager-controlplane        1/1     Running     0          42m
kube-system     kube-proxy-cjqvn                            1/1     Running     0          42m
kube-system     kube-scheduler-controlplane                 1/1     Running     0          42m

```

Which namespace is the Ingress Resource deployed in?
Run the command: kubectl get ingress --all-namespaces and identify the namespace.

```
controlplane ~ ➜  kubectl get ingress -A
NAMESPACE   NAME                 CLASS    HOSTS   ADDRESS        PORTS   AGE
app-space   ingress-wear-watch   <none>   *       10.109.64.99   80      31m
```

## **step3**

What is the name of the Ingress Resource?
Run the command: kubectl get ingress --all-namespaces and identify the name of Ingress Resource.

## **step4**

What is the Host configured on the Ingress Resource?
All host

## **step5**

What backend is the /wear path on the Ingress configured with?
Run the command: kubectl describe ingress --namespace app-space and look under the Rules section.

```
controlplane ~ ➜  kubectl -n app-space describe ingress ingress-wear-watch
Name:             ingress-wear-watch
Labels:           <none>
Namespace:        app-space
Address:          10.109.64.99
Ingress Class:    <none>
Default backend:  <default>
Rules:
  Host        Path  Backends
  ----        ----  --------
  *
              /wear    wear-service:8080 (10.244.0.4:8080)
              /watch   video-service:8080 (10.244.0.5:8080)
Annotations:  nginx.ingress.kubernetes.io/rewrite-target: /
              nginx.ingress.kubernetes.io/ssl-redirect: false
Events:
  Type    Reason  Age                From                      Message
  ----    ------  ----               ----                      -------
  Normal  Sync    33m (x2 over 33m)  nginx-ingress-controller  Scheduled for sync
```

## **step6**

If the requirement does not match any of the configured paths what service are the requests forwarded to?
Run the command: kubectl describe ingress --namespace app-space and look at the Default backend field.

## **step7**

You are requested to add a new path to your ingress to make the food delivery application available to your customers.
Make the new application available at /eat.
Ingress: ingress-wear-watch
Path: /eat
Backend Service: food-service
Backend Service Port: 8080
Run the command: kubectl edit ingress --namespace app-space and add a new Path entry for the new service.

## **step8**

You are requested to make the new application available at /pay.
Create a new Ingress for the new pay application in the critical-space namespace.
Use the command kubectl get svc -n critical-space to know the service and port details.

```
controlplane ~ ➜  kubectl get svc -n critical-space
NAME          TYPE        CLUSTER-IP     EXTERNAL-IP   PORT(S)    AGE
pay-service   ClusterIP   10.110.96.85   <none>        8282/TCP   112s
```
