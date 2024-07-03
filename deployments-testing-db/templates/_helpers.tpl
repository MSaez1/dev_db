{{/*
Expand the name of the chart.
*/}}
{{- define "deployments-testing-db.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
*/}}
{{- define "deployments-testing-db.fullname" -}}
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
{{- define "deployments-testing-db.labels" -}}
helm.sh/chart: {{ include "deployments-testing-db.chart" . }}
{{ include "deployments-testing-db.selectorLabels" . }}
{{- with .Chart.AppVersion }}
app.kubernetes.io/version: {{ . | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
app.kubernetes.io/name: {{ include "deployments-testing-db.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/version: {{ .Chart.AppVersion }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}

{{/*
Create chart selector labels.
*/}}
{{- define "deployments-testing-db.selectorLabels" -}}
app.kubernetes.io/name: {{ include "deployments-testing-db.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}

{{/*
Create chart information.
*/}}
{{- define "deployments-testing-db.chart" -}}
{{- if .Chart.Name -}}
{{ .Chart.Name }}-{{ .Chart.Version | replace "+" "_" }}
{{- else -}}
{{ .Chart.Version }}
{{- end -}}
{{- end -}}

{{/*
Generate the name of the service account to use
*/}}
{{- define "deployments-testing-db.serviceAccountName" -}}
{{- if .Values.serviceAccount.create -}}
{{- default (include "deployments-testing-db.fullname" .) .Values.serviceAccount.name -}}
{{- else -}}
{{- default "default" .Values.serviceAccount.name -}}
{{- end -}}
{{- end -}}
