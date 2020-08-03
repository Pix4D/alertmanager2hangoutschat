# alertmanager2hangoutschat

alertmanager2hangoutschat takes a alertmanager webhook and sends the alert to hangouts chat.

Example alertmanager webhook config:
```
  webhook_configs:
  - url: http://alertmanager2hangoutschat.domain.com/alertmanager?url=https%3A%2F%2Fchat.googleapis.com%2Fv1%2Fspaces%2Fasdfasdf%2Fmessages%3Fkey%3DKEY%26token%3DTOKEN

```
The endpoints takes the google webhook api as urlencoded GET parameter named "url". 

If you don't want to mention all folks in the room, add `mention=false` in URL parameter:
```
  webhook_configs:
  - url: http://alertmanager2hangoutschat.domain.com/alertmanager?mention=false&url=https%3A%2F%2Fchat.googleapis.com%2Fv1%2Fspaces%2Fasdfasdf%2Fmessages%3Fkey%3DKEY%26token%3DTOKEN
```


### build binary

```
go mod download
CGO_ENABLED=0 go build
```

### build Docker image

```
docker build . -t alertmanager2hangoutschat
```

### Usage
```
Usage of alertmanager2hangoutschat:
  -log-format string
        Can be empty string or json
  -log-level string
        Can be one of:panic,fatal,error,warning,info,debug (default "info")
  -path string
        What path to listen to for POST requests (default "/alertmanager")
  -port string
        Port to listen to (default "8080")
  -template-string string
        Template for the messages sent to hangouts chat (default "{{ define \"print_annotations\" }}{{ range . }}\n*{{ .Labels.alertname }}*\n{{ range .Annotations.SortedPairs -}}\n{{ .Name }}: {{ .Value}}\n{{ end -}}\nSource: <{{ .GeneratorURL }}|Show in prometheus>\n{{ end -}}{{ end -}}\n<users/all>\n[{{ .Status | toUpper }}{{ if eq .Status \"firing\" }}:{{ .Alerts.Firing | len }}{{ end }}]\n{{ if gt (len .Alerts.Firing) 0 -}}\n{{ template \"print_annotations\" .Alerts.Firing -}}\n{{ end -}}\n{{ if gt (len .Alerts.Resolved) 0 -}}\n{{ template \"print_annotations\" .Alerts.Resolved -}}\n{{ end -}}\n")
```
