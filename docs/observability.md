# Observabilidade

A pasta `observability/` inclui manifests iniciais para:

- Prometheus: coleta metricas.
- Grafana: dashboards.
- Loki: armazenamento de logs.
- Alloy: coleta e envio de logs.
- Alertmanager: roteamento de alertas.

Para laboratorio, aplique:

```bash
kubectl apply -k observability
```

Para producao, prefira charts oficiais, volumes persistentes, autenticacao forte, retencao definida, backup e alertas integrados a e-mail, Slack ou PagerDuty.
