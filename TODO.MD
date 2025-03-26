make use of handlers/

# From either node:
ETCDCTL_API=3 etcdctl \
  --endpoints=https://127.0.0.1:2379 \
  --cacert=/etc/etcd/ca.pem \
  --cert=/etc/etcd/kube-apiserver.pem \
  --key=/etc/etcd/kube-apiserver-key.pem \
  endpoint health