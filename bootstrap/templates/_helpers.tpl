{{- define "retry" -}}
retry:
  limit: 10
  backoff:
    duration: 10s
    factor: 2
    maxDuration: 5m
{{- end -}}
