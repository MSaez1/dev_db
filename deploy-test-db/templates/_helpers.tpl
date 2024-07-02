{{/*
Expand the name of the chart.
*/}}
{{- define "deploy-test-db.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
*/}}
{{- define "deploy-test-db.fullname" -}}
{{- if .Values.fullnameOverride -}}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}

{{/*
Create chart labels.
*/}}
{{- define "deploy-test-db.labels" -}}
helm.sh/chart: {{ include "deploy-test-db.chart" . }}
{{ include "deploy-test-db.selectorLabels" . }}
{{- with .Chart.AppVersion }}
app.kubernetes.io/version: {{ . | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}

{{/*
Create chart selector labels.
*/}}
{{- define "deploy-test-db.selectorLabels" -}}
app.kubernetes.io/name: {{ include "deploy-test-db.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}

{{/*
Create chart information.
*/}}
{{- define "deploy-test-db.chart" -}}
{{- if .Chart.Name -}}
{{ .Chart.Name }}-{{ .Chart.Version }}
{{- else -}}
{{ .Chart.Version }}
{{- end -}}
{{- end -}}

{{/*
Generate the name of the service account to use
*/}}
{{- define "deploy-test-db.serviceAccountName" -}}
{{- if .Values.serviceAccount.create -}}
{{- default (include "deploy-test-db.fullname" .) .Values.serviceAccount.name -}}
{{- else -}}
{{- default "default" .Values.serviceAccount.name -}}
{{- end -}}
{{- end -}}
