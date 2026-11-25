{{- define "tappet.name" -}}{{ .Chart.Name }}{{- end -}}
{{- define "tappet.fullname" -}}
{{- if contains .Chart.Name .Release.Name -}}{{ .Release.Name | trunc 63 | trimSuffix "-" }}{{- else -}}{{ printf "%s-%s" .Release.Name .Chart.Name | trunc 63 | trimSuffix "-" }}{{- end -}}
{{- end -}}
{{- define "tappet.labels" -}}
app.kubernetes.io/name: {{ include "tappet.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
helm.sh/chart: {{ printf "%s-%s" .Chart.Name .Chart.Version }}
{{- end -}}
{{- define "tappet.selector" -}}
app.kubernetes.io/name: {{ include "tappet.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}
{{- define "tappet.image" -}}{{ .Values.image.repository }}:{{ .Values.image.tag | default .Chart.AppVersion }}{{- end -}}
{{- define "tappet.serviceAccountName" -}}
{{- if .Values.serviceAccount.create -}}{{ default (include "tappet.fullname" .) .Values.serviceAccount.name }}{{- else -}}{{ default "default" .Values.serviceAccount.name }}{{- end -}}
{{- end -}}
{{- define "tappet.ha" -}}{{- if or .Values.database.url .Values.database.existingSecret -}}true{{- end -}}{{- end -}}
{{- define "tappet.env" -}}
- name: TAPPET_DATA
  value: /data
- name: TAPPET_PORT
  value: {{ .Values.server.port | quote }}
{{- with .Values.publicUrl }}
- name: TAPPET_PUBLIC_URL
  value: {{ . | quote }}
{{- end }}
- name: TAPPET_ENCRYPTION_KEY
  valueFrom:
    secretKeyRef:
      name: {{ .Values.encryptionKey.existingSecret | default (printf "%s-secrets" (include "tappet.fullname" .)) }}
      key: {{ .Values.encryptionKey.existingSecretKey }}
{{- if include "tappet.ha" . }}
- name: TAPPET_DATABASE_URL
  valueFrom:
    secretKeyRef:
      name: {{ .Values.database.existingSecret | default (printf "%s-secrets" (include "tappet.fullname" .)) }}
      key: {{ .Values.database.existingSecretKey }}
{{- end }}
{{- range $k, $v := .Values.env }}
- name: {{ $k }}
  value: {{ $v | quote }}
{{- end }}
{{- end -}}
