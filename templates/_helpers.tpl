# templates/_helpers.tpl
{{- define "onprem-rag-pipeline.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "onprem-rag-pipeline.fullname" -}}
{{- printf "%s-%s" (include "onprem-rag-pipeline.name" .) .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "onprem-rag-pipeline.labels" -}}
helm.sh/chart: {{ .Chart.Name }}-{{ .Chart.Version }}
app.kubernetes.io/name: {{ include "onprem-rag-pipeline.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/version: {{ .Chart.AppVersion }}
app.kubernetes.io/managed-by: Helm
{{- end -}}
