{{- define "psdbs.msConfigMap" -}}  
{{- with .Values.configMap.rabbitmq}}
  rabbitmq.port: {{ .port | quote}}
  rabbitmq.host: {{ .host}}
  rabbitmq.rpcxchange: {{ .rpcExchange}}
 {{- end }}
{{- end }}
  