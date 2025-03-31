apostoliseq@kube-controller-1:~$ curl -H "Host: kubernetes.default.svc.cluster.local" -i http://127.0.0.1/healthz
HTTP/1.1 404 Not Found
Server: nginx/1.24.0 (Ubuntu)
Date: Mon, 31 Mar 2025 21:09:29 GMT
Content-Type: text/html
Content-Length: 162
Connection: keep-alive

<html>
<head><title>404 Not Found</title></head>
<body>
<center><h1>404 Not Found</h1></center>
<hr><center>nginx/1.24.0 (Ubuntu)</center>
</body>
</html>

kube-apiserver
--enable-swagger-ui=true \
--kubelet-https=true \