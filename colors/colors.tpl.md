# Colors

> Terminal colors

## Colors

| Name | Kind | Hex |   |
| ---- | ---- | --- | - |
{{ range $color := .Colors -}}
| {{ .Name }} | {{ .Kind }} | `{{ .Hex }}` | ![{{.Name}}-{{.Kind}}]({{.Filename}}) |
{{ end }}

## Terminal configuration

### kitty

Configured in `~/.config/kitty/kitty.conf`.

```
# Kitty configuration
```

### Terminator

Configured in `~/.config/terminator/config`.

```
# Terminator configuration
```

**{{.EditNotice}}**
