{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "big-brother-test.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "big-brother-test.fullname" -}}
{{- if .Values.fullnameOverride -}}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "big-brother-test.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Common labels
*/}}
{{- define "big-brother-test.labels" -}}
helm.sh/chart: {{ include "big-brother-test.chart" . }}
{{ include "big-brother-test.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}

{{/*
Selector labels
*/}}
{{- define "big-brother-test.selectorLabels" -}}
app.kubernetes.io/name: {{ include "big-brother-test.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}

{{/*
Create the name of the service account to use
*/}}
{{- define "big-brother-test.serviceAccountName" -}}
{{- if .Values.serviceAccount.create -}}
    {{ default (include "big-brother-test.fullname" .) .Values.serviceAccount.name }}
{{- else -}}
    {{ default "default" .Values.serviceAccount.name }}
{{- end -}}
{{- end -}}

{{/* Generate basic resource */}}
{{- define "bigbrotherhelm.resource" }}
{{- if .resources }}
resources:
  {{- if .resources.requests }}
  requests:
    memory: {{ .resources.requests.memory | default "500Mi" | quote }}
    cpu: {{ .resources.requests.cpu | default "300Mi" | quote }}
  {{- else}}
  requests:
    memory: "500Mi"
    cpu: "300Mi"
  {{- end }}
  {{- if .resources.limits }}
  limits:
    memory: {{ .resources.limits.memory | default "1000Mi" | quote }}
    cpu: {{ .resources.limits.cpu | default "600m" | quote }}
  {{- else}}
  limits:
    memory: "1000Mi"
    cpu: "600m"
  {{- end }}
{{- else}}
resources:
  requests:
    memory: "500Mi"
    cpu: "300m"
  limits:
    memory: "1000Mi"
    cpu: "600m"  
{{- end }}
{{- end }}
