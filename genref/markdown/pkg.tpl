{{ define "packages" -}}

{{ $grpname := "" -}}
{{- range $idx, $val := .packages -}}
{{- if and (ne .GroupName "") (eq $grpname "") -}}
---
title: {{ .Title }}
content_type: tool-reference
package: {{ .DisplayName }}
auto_generated: true
---
{{ .GetComment -}}
{{ $grpname = .GroupName }}
{{- end -}}
{{- end }}

## Resource Types 

{{ range .packages -}}
  {{- if ne .GroupName "" -}}
    {{- range .VisibleTypes -}}
      {{- if .IsExported }}
- [{{ .DisplayName }}]({{ .Link }})
      {{- end -}}
    {{- end -}}
  {{ end -}}
{{- end -}}

{{ range .packages }}
  {{ if ne .GroupName "" -}}
     
    {{/* For package with a group name, list all type definitions in it. */}}
    {{ range .VisibleTypes }}
{{ template "type" . }}
    {{ end }}
  {{ else }}
    {{/* For package w/o group name, list only types referenced. */}}
    {{- range .VisibleTypes -}}
      {{- if .Referenced -}}
{{ template "type" . }}
      {{- end -}}
    {{- end }}
  {{- end }}
{{- end }}
{{ end }}
