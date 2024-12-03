# Prometheus-tmp-cdsl

このリポジトリは監視ソフトウェアであるPrometheusを使用するためのものになります．

### コンポーネント
- Prometheus(Server)
- AlertManager
- Exporter
  - NodeExporter
  - cAdvisor
  - Metrics Server

### 使い方(Prometheus+Exporter)

 

kustomizationの確認
```
$ vi kustomization.yaml 
```

以下のように使用するコンポーネントだけを選択．
```yaml
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization
resources:
  - ./kubernetes/monitoring-namespace.yml
  - ./kubernetes/prometheus-roles.yml
  - ./kubernetes/prometheus-config2.yaml
  - ./kubernetes/prometheus-deployment.yaml
  - ./kubernetes/prometheus-nodeservice.yaml
  - ./kubernetes/exporter/node-exporter-daemonset.yml
  - ./kubernetes/exporter/components.yaml
  - ./kubernetes/exporter/cadvisor.yaml
```

PrometheusとExporterの配置
```
$ kubectl apply -k .
```

### 使い方(AlertManager)

```
cd Prometheus-tmp-cdsl/alert-manager
```

配置
```
$ kubectl apply -k .
```




 
     
