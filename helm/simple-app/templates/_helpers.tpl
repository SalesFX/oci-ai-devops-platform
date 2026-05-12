{{/*
Expand the name of the chart.
*/}}
{{- define "simple-app.name" -}}
{{- .Chart.Name }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "simple-app.labels" -}}
app: {{ include "simple-app.name" . }}
env: {{ .Values.env }}
helm.sh/chart: {{ .Chart.Name }}-{{ .Chart.Version }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "simple-app.selectorLabels" -}}
app: {{ include "simple-app.name" . }}
{{- end }}
