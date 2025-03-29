ti exei to apiserver p dn exoun controller-manager k scheduler?
isws xreiastei install kubectl se controllers?

  ● kube-apiserver.service - Kubernetes API Server
     Loaded: loaded (/etc/systemd/system/kube-apiserver.service; enabled; preset: enabled)
     Active: active (running) since Sat 2025-03-29 23:13:37 UTC; 1min 42s ago
       Docs: https://github.com/kubernetes/kubernetes
   Main PID: 101065 (kube-apiserver)
      Tasks: 8 (limit: 2216)
     Memory: 220.5M (peak: 221.0M)
        CPU: 6.985s
     CGroup: /system.slice/kube-apiserver.service
             └─101065 /usr/local/bin/kube-apiserver --advertise-address=192.168.138.130 --allow-privileged=true --apiserver-count=3 --audit-log-maxage=30 --audit-log-maxbackup=3 --audit-log-maxsize=100 --audit-log-path=/var/log/audit.log --authorization-mode=Node,RBAC --bind-address=0.0.0.0 --client-ca-file=/var/lib/kubernetes/ca.pem --enable-admission-plugins=Initializers,NamespaceLifecycle,NodeRestriction,LimitRanger,ServiceAccount,DefaultStorageClass,ResourceQuota --enable-swagger-ui=true --etcd-cafile=/var/lib/kubernetes/ca.pem --etcd-certfile=/var/lib/kubernetes/kubernetes.pem --etcd-keyfile=/var/lib/kubernetes/kubernetes-key.pem --etcd-servers=https://192.168.138.134:2379,https://192.168.138.130:2379 --event-ttl=1h --experimental-encryption-provider-config=/var/lib/kubernetes/encryption-config.yaml --kubelet-certificate-authority=/var/lib/kubernetes/ca.pem --kubelet-client-certificate=/var/lib/kubernetes/kubernetes.pem kubelet-client-key=/var/lib/kubernetes/kubernetes-key.pem --kubelet-https=true --runtime-config=api/all --service-account-key-file=/var/lib/kubernetes/service-account.pem --service-cluster-ip-range=10.32.0.0/24 --service-node-port-range=30000-32767 --tls-cert-file=/var/lib/kubernetes/kubernetes.pem --tls-private-key-file=/var/lib/kubernetes/kubernetes-key.pem --v=2 --kubelet-preferred-address-types=InternalIP,InternalDNS,Hostname,ExternalIP,ExternalDNS
             leged=true --apiserver-count=3 --audit-log-maxage=30 --audit-log-maxbackup=3 --audit-log-maxsize=100 --audit-log-path=/var/log/audit.log --authorization-mode=Node,RBAC --bind-address=0.0.0.0 --client-c

Mar 29 23:15:20 kube-controller-2 kube-apiserver[101065]: I0329 23:15:20.004256  101065 wrap.go:42] ET /api/v1/replicationcontrollers?limit=500&resourceVersion=0: (105.53µs) 403 [[kube-scheduler/v1.10.2 (linux/amd64) kubernetes/81753b1/scheduler] 127.0.0.1:37778]
Mar 29 23:15:20 kube-controller-2 kube-apiserver[101065]: I0329 23:15:20.005833  101065 wrap.go:42] ET /api/v1/nodes?limit=500&resourceVersion=0: (72.72µs) 403 [[kube-scheduler/v1.10.2 (linux/amd64) kubernetes/81753b1/scheduler] 127.0.0.1:37778]
Mar 29 23:15:20 kube-controller-2 kube-apiserver[101065]: I0329 23:15:20.006875  101065 wrap.go:42] ET /apis/extensions/v1beta1/replicasets?limit=500&resourceVersion=0: (96.74µs) 403 [[kube-scheduler/v1.10.2 (linux/amd64) kubernetes/81753b1/scheduler] 127.0.0.1:37778]
Mar 29 23:15:20 kube-controller-2 kube-apiserver[101065]: I0329 23:15:20.008372  101065 wrap.go:42] ET /apis/policy/v1beta1/poddisruptionbudgets?limit=500&resourceVersion=0: (95.71µs) 403 [[kube-scheduler/v1.10.2 (linux/amd64) kubernetes/81753b1/scheduler] 127.0.0.1:37778]
Mar 29 23:15:20 kube-controller-2 kube-apiserver[101065]: I0329 23:15:20.010390  101065 wrap.go:42]ET /api/v1/persistentvolumeclaims?limit=500&resourceVersion=0: (420.154µs) 403 [[kube-scheduler/v1.10.2 (linux/amd64) kubernetes/81753b1/scheduler] 127.0.0.1:37778]
Mar 29 23:15:20 kube-controller-2 kube-apiserver[101065]: I0329 23:15:20.010913  101065 wrap.go:42] ET /api/v1/persistentvolumes?limit=500&resourceVersion=0: (94.88µs) 403 [[kube-scheduler/v1.10.2 (linux/amd64) kubernetes/81753b1/scheduler] 127.0.0.1:37778]
Mar 29 23:15:20 kube-controller-2 kube-apiserver[101065]: I0329 23:15:20.012047  101065 wrap.go:42] ET /apis/storage.k8s.io/v1/storageclasses?limit=500&resourceVersion=0: (79.419µs) 403 [[kube-scheduler/v1.10.2 (linux/amd64) kubernetes/81753b1/scheduler] 127.0.0.1:37778]

make use of handlers/

Check etcd status with
ETCDCTL_API=3 etcdctl \
  --endpoints=https://127.0.0.1:2379 \
  --cacert=/etc/etcd/ca.pem \
  --cert=/etc/etcd/kubernetes.pem \
  --key=/etc/etcd/kubernetes-key.pem \
  endpoint health

