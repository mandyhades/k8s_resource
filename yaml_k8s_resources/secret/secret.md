## Secret Data:

```
apiVersion: v1
kind: Secret
metadata:
  name: example-secret
data:
  username: base64encodedusername
  password: base64encodedpassword

```

## Secret String data :

```
apiVersion: v1
kind: Secret
metadata:
  name: example-secret
stringData:
  username: myusername
  password: mypassword

```

## envsubst

su dung : envsubst

```
export USER=duc
export PASSWORD=leanh
envsubst < secure.yaml > tmp.yaml
```

## Đưa bí mật vào nhóm của bạn vào folder

## Đưa bí mật vào Pod của bạn với các biến môi trường

```
kubectl create secret generic mysecret --from-file=secrets.txt
 kubectl get secrets mysecret -o yaml
uid: 67d08bde-2089-4af6-955a-5998b35562ad
❯ echo 67d08bde-2089-4af6-955a-5998b35562ad | base64 --decode
```

```
❯ cat secrets
secret1=duc
secret2=leanh
❯ echo duc | base64
ZHVjCg==
❯ echo ZHVjCg== | base64 --decode
duc
```
