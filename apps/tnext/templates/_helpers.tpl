{{- define "tnext.name" -}}
{{- default .Chart.Name .Values.nameOverride -}}
{{- end -}}

{{- define "tnext.fullname" -}}
{{- printf "%s-%s" .Release.Name .Chart.Name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "tnext.labels" -}}
app.kubernetes.io/name: {{ include "tnext.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/version: {{ .Chart.AppVersion }}
app.kubernetes.io/managed-by: Helm
{{- end -}}
