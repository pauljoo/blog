---
title: Istio
date: 2019-11-16 20:04:09
categories:
- 架构
tags:
- 服务网格
- Service Mesh
---
kubectl apply -f https://istio.io/operator.yaml

kubectl apply -f - <<EOF
apiVersion: install.istio.io/v1alpha2
kind: IstioControlPlane
metadata:
  namespace: istio-operator
  name: example-istiocontrolplane
spec:
  profile: demo
EOF

kubectl get svc -n istio-system