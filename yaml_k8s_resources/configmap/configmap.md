## imperative :

kubectl create configmap <config-name> --from-literal=<key>=<value>

```
kubectl create configmap \
 webapp-config-map --from-literal=APP_COLOR=darkblue \
                   --from-literal=APP_OTHER=disregard
```

## Declarative :

kubectl create -f

```kubectl create -f configmap.yaml

```

mysql-config

```
port: 3306
max_allowed_packet: 128M
```

redis-config

```
port: 6379
rdb-compression: yes
```

## view configmaps

kubectl get configmaps
kubectl describe configmaps

## configmap in pods:

**ENV update manual any object**
1 object :

```
apiVersion: v1
kind: Pod
metadata:
  creationTimestamp: "2023-09-16T02:42:04Z"
  labels:
    name: webapp-color
  name: webapp-color
  namespace: default
  resourceVersion: "988"
  uid: 9c3ca073-af73-4747-a4b4-2ce404104178
spec:
  containers:
  - env:
    - name: APP_COLOR
      value: green
    image: kodekloud/webapp-color
```

**SINGLE ENV update multi object on file object**
single file:

```
---
apiVersion: v1
kind: Pod
metadata:
  labels:
    name: webapp-color
  name: webapp-color
  namespace: default
spec:
  containers:
  - env:
    - name: APP_COLOR
      valueFrom:
       configMapKeyRef:
         name: webapp-config-map
         key: APP_COLOR
    image: kodekloud/webapp-color
    name: webapp-color
```

**VOLUME update file to file**

Cách tiếp cận này cho phép bạn tách rời dữ liệu cấu hình khỏi ứng dụng của mình, giúp quản lý và cập nhật cấu hình dễ dàng hơn mà không cần sửa đổi mã ứng dụng của bạn.

```
    spec:
      containers:
        - name: nginx
          image: nginx:alpine
          env:
            - name: DB_HOST
              valueFrom:
                configMapKeyRef:
                  name: vars
                  key: db_host
            - name: DB_USER
              valueFrom:
                configMapKeyRef:
                  name: vars
                  key: db_user
          volumeMounts:
          - name: nginx-vol
            mountPath: /etc/nginx/conf.d
          - name: script-vol
            mountPath: /opt
      volumes:
        - name: nginx-vol
          configMap:
            name: nginx-config
            items:
            - key: nginx
              path: default.conf
        - name: script-vol
          configMap:
            name: vars
            items:
            - key: script
              path: script.sh

```
