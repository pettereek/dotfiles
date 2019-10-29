# Colors

> Terminal colors

## Colors

| Name | Normal | Bright |   |
| ---- | ------ | ------ | - |
| foreground | `{{ .Foreground.Hex }}` | | ![{{.Foreground.Name}}-{{.Foreground.Kind}}]({{.Foreground.Filename}}) |
| background | `{{ .Background.Hex }}` | | ![{{.Background.Name}}-{{.Background.Kind}}]({{.Background.Filename}}) |
{{ range $color := .Colors -}}
| {{ .Name }} | `{{ .Normal.Hex }}` | `{{ .Bright.Hex }}` | ![{{.Normal.Name}}-{{.Normal.Kind}}]({{.Normal.Filename}}) ![{{.Bright.Name}}-{{.Bright.Kind}}]({{.Bright.Filename}}) |
{{ end }}

## Terminal configuration

### kitty

Configured in `~/.config/kitty/kitty.conf`.

```
foreground {{ .Foreground.Hex }}
background {{ .Background.Hex }}

#: The foreground and background colors

{{ range $color := .Colors -}}
color{{ .Normal.ID }} {{ .Normal.Hex }}
color{{ .Bright.ID }} {{ .Bright.Hex }}

#: {{ .Name }}

{{ end -}}
```

### Terminator

Configured in `~/.config/terminator/config`.

```
# Terminator configuration
```

**{{.EditNotice}}**
