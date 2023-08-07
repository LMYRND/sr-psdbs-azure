{{/*
Expand the name of the chart.
*/}}

  
{{- define "psdbs.port" -}}
{{- default 8090 .Values.port}}
{{- end }}


{{/*
Expand the name of the chart.
*/}}
{{- define "psdbs.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{- define "psdbs.image" -}}

{{- $registry := .Values.image.registry | default "srregis.azurecr.io" }}
{{- $imageName := .Values.image.imageName | default "psdbsmanager" }}
{{- $imageTag := .Values.image.imageTag | default "latest" }}
{{- default (print $registry "/" $imageName ":" $imageTag | quote) }}
{{- end }}

{{- define "psdbs.image_ms" -}}

{{- $registryMS := .Values.image_ms.registry | default "srregis.azurecr.io" }}
{{- $imageNameMS := .Values.image_ms.imageName | default "psdbsmanager_ms" }}
{{- $imageTagMS := .Values.image_ms.imageTag | default "latest" }}
{{- default (print $registryMS "/" $imageNameMS ":" $imageTagMS | quote) }}
{{- end }}


{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "psdbs.fullname" -}}
{{- if $.Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "psdbs.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "psdbs.labels" -}}
helm.sh/chart: {{ include "psdbs.chart" . }}
{{ include "psdbs.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "psdbs.selectorLabels" -}}
app.kubernetes.io/name: {{ include "psdbs.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "psdbs.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "psdbs.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}