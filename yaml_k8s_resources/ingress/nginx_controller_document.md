https://kubernetes.github.io/ingress-nginx/

Ingress - Annotations and rewrite-target
Different ingress controllers have different options that can be used to customise the way it works. NGINX Ingress controller has many options that can be seen here. I would like to explain one such option that we will use in our labs. The Rewrite target option.
Các bộ điều khiển xâm nhập khác nhau có các tùy chọn khác nhau có thể được sử dụng để tùy chỉnh cách thức hoạt động của nó. Bộ điều khiển NGINX Ingress có nhiều tùy chọn, bạn có thể xem tại đây. Tôi muốn giải thích một tùy chọn như vậy mà chúng tôi sẽ sử dụng trong phòng thí nghiệm của mình. Tùy chọn mục tiêu Viết lại.

```
https://kubernetes.github.io/ingress-nginx/examples/
https://kubernetes.github.io/ingress-nginx/examples/rewrite/
```

Our watch app displays the video streaming webpage at http://<watch-service>:<port>/
Our wear app displays the apparel webpage at http://<wear-service>:<port>/
We must configure Ingress to achieve the below. When user visits the URL on the left, his request should be forwarded internally to the URL on the right. Note that the /watch and /wear URL path are what we configure on the ingress controller so we can forwarded users to the appropriate application in the backend. The applications don't have this URL/Path configured on them:
Chúng ta phải cấu hình Ingress để đạt được những điều dưới đây. Khi người dùng truy cập URL ở bên trái, yêu cầu của anh ta sẽ được chuyển tiếp nội bộ tới URL ở bên phải. Lưu ý rằng đường dẫn URL /watch và /wear là những gì chúng tôi định cấu hình trên bộ điều khiển xâm nhập để có thể chuyển tiếp người dùng đến ứng dụng thích hợp trong phần phụ trợ. Các ứng dụng không có URL/Đường dẫn này được định cấu hình trên chúng:
http://<ingress-service>:<ingress-port>/watch --> http://<watch-service>:<port>/

http://<ingress-service>:<ingress-port>/wear --> http://<wear-service>:<port>/
Without the rewrite-target option, this is what would happen:
Nếu không có tùy chọn viết lại mục tiêu, điều này sẽ xảy ra:
http://<ingress-service>:<ingress-port>/watch --> http://<watch-service>:<port>/watch

http://<ingress-service>:<ingress-port>/wear --> http://<wear-service>:<port>/wear
Notice watch and wear at the end of the target URLs. The target applications are not configured with /watch or /wear paths. They are different applications built specifically for their purpose, so they don't expect /watch or /wear in the URLs. And as such the requests would fail and throw a 404 not found error.
Lưu ý đồng hồ và hao mòn ở cuối URL mục tiêu. Các ứng dụng mục tiêu không được định cấu hình với đường dẫn /watch hoặc /wear. Chúng là các ứng dụng khác nhau được xây dựng riêng cho mục đích của chúng, vì vậy chúng không mong đợi /watch hoặc /wear trong URL. Và như vậy, các yêu cầu sẽ không thành công và đưa ra lỗi 404 không tìm thấy.

To fix that we want to "ReWrite" the URL when the request is passed on to the watch or wear applications. We don't want to pass in the same path that user typed in. So we specify the rewrite-target option. This rewrites the URL by replacing whatever is under rules->http->paths->path which happens to be /pay in this case with the value in rewrite-target. This works just like a search and replace function.

Để khắc phục vấn đề đó, chúng tôi muốn "Viết lại" URL khi yêu cầu được chuyển đến ứng dụng đồng hồ hoặc thiết bị đeo. Chúng tôi không muốn đi vào cùng một đường dẫn mà người dùng đã nhập. Vì vậy, chúng tôi chỉ định tùy chọn đích viết lại. Điều này viết lại URL bằng cách thay thế bất kỳ nội dung nào theo quy tắc->http->paths->path xảy ra là /pay trong trường hợp này bằng giá trị trong rewrite-target. Tính năng này hoạt động giống như chức năng tìm kiếm và thay thế.
For example: replace(path, rewrite-target)
In our case: replace("/path","/")

```
apiVersion: extensions/v1beta1
kind: Ingress
metadata:
  name: test-ingress
  namespace: critical-space
  annotations:
    nginx.ingress.kubernetes.io/rewrite-target: /
spec:
  rules:
  - http:
      paths:
      - path: /pay
        backend:
          serviceName: pay-service
          servicePort: 8282
```

In another example given here, this could also be:
`https://kubernetes.github.io/ingress-nginx/examples/rewrite/`
`replace("/something(/|$)(.*)", "/$2")`

```
apiVersion: extensions/v1beta1
kind: Ingress
metadata:
  annotations:
    nginx.ingress.kubernetes.io/rewrite-target: /$2
  name: rewrite
  namespace: default
spec:
  rules:
  - host: rewrite.bar.com
    http:
      paths:
      - backend:
          serviceName: http-svc
          servicePort: 80
        path: /something(/|$)(.*)
```
