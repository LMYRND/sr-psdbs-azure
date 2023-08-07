{{- define "psdbs.secret" -}}
{{- with .Values.configMap.pg }}
  pg_db_user: {{required "missing a valid postgress database user!" .db.user| b64enc | quote }}
  pg_db_password: {{required "missing a valid postgress database password!" .db.password | b64enc | quote }}
  {{- end}}
  {{- with .Values.configMap.graph }}
  graph_db_user: {{required "missing a valid postgress database user!" .db.user | b64enc | quote }}
  graph_db_password: {{required "missing a valid postgress database password!" .db.password | b64enc | quote }}
  {{- end}}
  {{- with .Values.configMap }}
  password: {{required "missing a valid  secret user!" .secretFile | b64enc | quote }}
  {{- end}}
{{- end }}

{{- define "psdbs.ms.secret" -}}
{{- with .Values.configMap.rabbitmq }}
    rabbitmq_user: {{required "missing a valid rabbitmq user!" .user| b64enc | quote }}
    rabbitmq_password: {{required "missing a valid postgress database password!" .password | b64enc | quote }}
  {{- end}}
{{- end }}
