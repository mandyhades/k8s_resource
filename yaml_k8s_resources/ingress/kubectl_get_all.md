```
controlplane ~ ➜  kubectl get all -A
NAMESPACE       NAME                                            READY   STATUS      RESTARTS   AGE
app-space       pod/default-backend-7845d8c4f-mkmk9             1/1     Running     0          3m6s
app-space       pod/webapp-video-55fcd88897-pf6kf               1/1     Running     0          3m6s
app-space       pod/webapp-wear-554bbffcd6-4rb29                1/1     Running     0          3m7s
ingress-nginx   pod/ingress-nginx-admission-create-tcwh6        0/1     Completed   0          3m2s
ingress-nginx   pod/ingress-nginx-admission-patch-l8rfg         0/1     Completed   0          3m2s
ingress-nginx   pod/ingress-nginx-controller-5d48d5445f-x4xn8   1/1     Running     0          3m3s
kube-flannel    pod/kube-flannel-ds-8lsp4                       1/1     Running     0          13m
kube-system     pod/coredns-5d78c9869d-lpsfq                    1/1     Running     0          13m
kube-system     pod/coredns-5d78c9869d-wd8f4                    1/1     Running     0          13m
kube-system     pod/etcd-controlplane                           1/1     Running     0          13m
kube-system     pod/kube-apiserver-controlplane                 1/1     Running     0          13m
kube-system     pod/kube-controller-manager-controlplane        1/1     Running     0          13m
kube-system     pod/kube-proxy-cjqvn                            1/1     Running     0          13m
kube-system     pod/kube-scheduler-controlplane                 1/1     Running     0          13m

NAMESPACE       NAME                                         TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)                      AGE
app-space       service/default-backend-service              ClusterIP   10.99.189.170    <none>        80/TCP                       3m6s
app-space       service/video-service                        ClusterIP   10.103.108.177   <none>        8080/TCP                     3m6s
app-space       service/wear-service                         ClusterIP   10.105.34.120    <none>        8080/TCP                     3m6s
default         service/kubernetes                           ClusterIP   10.96.0.1        <none>        443/TCP                      13m
ingress-nginx   service/ingress-nginx-controller             NodePort    10.109.64.99     <none>        80:30080/TCP,443:32103/TCP   3m3s
ingress-nginx   service/ingress-nginx-controller-admission   ClusterIP   10.102.249.7     <none>        443/TCP                      3m3s
kube-system     service/kube-dns                             ClusterIP   10.96.0.10       <none>        53/UDP,53/TCP,9153/TCP       13m

NAMESPACE      NAME                             DESIRED   CURRENT   READY   UP-TO-DATE   AVAILABLE   NODE SELECTOR            AGE
kube-flannel   daemonset.apps/kube-flannel-ds   1         1         1       1            1           <none>                   13m
kube-system    daemonset.apps/kube-proxy        1         1         1       1            1           kubernetes.io/os=linux   13m

NAMESPACE       NAME                                       READY   UP-TO-DATE   AVAILABLE   AGE
app-space       deployment.apps/default-backend            1/1     1            1           4m52s
app-space       deployment.apps/webapp-video               1/1     1            1           4m52s
app-space       deployment.apps/webapp-wear                1/1     1            1           4m53s
ingress-nginx   deployment.apps/ingress-nginx-controller   1/1     1            1           4m49s
kube-system     deployment.apps/coredns                    2/2     2            2           15m

NAMESPACE       NAME                                                  DESIRED   CURRENT   READY   AGE
app-space       replicaset.apps/default-backend-7845d8c4f             1         1         1       4m52s
app-space       replicaset.apps/webapp-video-55fcd88897               1         1         1       4m52s
app-space       replicaset.apps/webapp-wear-554bbffcd6                1         1         1       4m53s
ingress-nginx   replicaset.apps/ingress-nginx-controller-5d48d5445f   1         1         1       4m49s
kube-system     replicaset.apps/coredns-5d78c9869d                    2         2         2       15m

NAMESPACE       NAME                                       COMPLETIONS   DURATION   AGE
ingress-nginx   job.batch/ingress-nginx-admission-create   1/1           12s        4m49s
ingress-nginx   job.batch/ingress-nginx-admission-patch    1/1           12s        4m48s
```
