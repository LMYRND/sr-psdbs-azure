{{- define "psdbs.configMap" -}}  
  app.env: docker
  pg.connection-limit: {{ default 20 .Values.configMap.pg.connectionLimit | quote}}
{{- with .Values.configMap.pg }}
  pg.db.host: {{required "missing a valid postgress database host address! example: 127.0.0.1 / pc-name" .db.host | quote}}
  pg.db.name: {{required "missing a valid postgress database name!" .db.name }}
  pg.db.port: {{ default 5432 .port | quote }}
  {{- end}}
 
  {{- with .Values.configMap.graph }}
  graph.host: {{required "missing a valid graph database host address! example: 127.0.0.1 / pc-name" .db.host | quote}} 
  graph.db.name: {{required "missing a valid postgress database name!" .db.name}}
  graph.db.graph-name: {{ default "graph" .graphName }}
  graph.port: {{ default 8530 .db.port | quote }}
  graph.protocol: {{ default "https" .db.protocol | quote }}
  {{- end}}


  {{- with .Values.configMap.retry }}
  retry.count: {{ default "3" .count | quote }}
  retry.wait-before-retry: {{ default 1000 .waitBeforeRetry  | quote}} 
  {{- end}}
  {{- with .Values.configMap.ps }}
  ps.service-url: {{required "missing a valid ps service url!" .serviceUrl}}
  ps.builder-port: {{required "missing a valid ps service port!" .servicePort | quote}} 
  {{- end}}
  logs.dir: {{.Values.configMap.logsDir}}
  psdbs.port: {{include "psdbs.port" . | quote}}
  psdbs.dump: {{.Values.configMap.dump}}
 
{{- end }}
  