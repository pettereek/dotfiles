# Colors

> Terminal colors

## Colors

| Name | Normal | Bright |   |
| ---- | ------ | ------ | - |
| foreground | `#fffeeb` | | ![foreground-normal](svg/foreground.normal.svg) |
| background | `#3c4c55` | | ![background-normal](svg/background.normal.svg) |
| black | `#132132` | `#8d9eb2` | ![black-normal](svg/black.normal.svg) ![black-bright](svg/black.bright.svg) |
| red | `#ff6a6f` | `#fd8489` | ![red-normal](svg/red.normal.svg) ![red-bright](svg/red.bright.svg) |
| green | `#a9dd9d` | `#c9eac3` | ![green-normal](svg/green.normal.svg) ![green-bright](svg/green.bright.svg) |
| yellow | `#f0eaaa` | `#f4f0c2` | ![yellow-normal](svg/yellow.normal.svg) ![yellow-bright](svg/yellow.bright.svg) |
| blue | `#7098e6` | `#98b8e6` | ![blue-normal](svg/blue.normal.svg) ![blue-bright](svg/blue.bright.svg) |
| magenta | `#9e88c7` | `#bd9ed7` | ![magenta-normal](svg/magenta.normal.svg) ![magenta-bright](svg/magenta.bright.svg) |
| cyan | `#84cedb` | `#aadde6` | ![cyan-normal](svg/cyan.normal.svg) ![cyan-bright](svg/cyan.bright.svg) |
| white | `#e5e9f0` | `#eceff4` | ![white-normal](svg/white.normal.svg) ![white-bright](svg/white.bright.svg) |


## Terminal configuration

### kitty

Configured in `~/.config/kitty/kitty.conf`.

```
foreground #fffeeb
background #3c4c55

#: The foreground and background colors

color0 #132132
color8 #8d9eb2

#: black

color1 #ff6a6f
color9 #fd8489

#: red

color2 #a9dd9d
color10 #c9eac3

#: green

color3 #f0eaaa
color11 #f4f0c2

#: yellow

color4 #7098e6
color12 #98b8e6

#: blue

color5 #9e88c7
color13 #bd9ed7

#: magenta

color6 #84cedb
color14 #aadde6

#: cyan

color7 #e5e9f0
color15 #eceff4

#: white

```

### Terminator

Configured in `~/.config/terminator/config`.

```
[profiles]
  [[default]]
    background_color = "#fffeeb"
    foreground_color = "#3c4c55"
    palette = "#132132:#ff6a6f:#a9dd9d:#f0eaaa:#7098e6:#9e88c7:#84cedb:#e5e9f0:#8d9eb2:#fd8489:#c9eac3:#f4f0c2:#98b8e6:#bd9ed7:#aadde6:#eceff4"
```

**This file is generated. Do not edit.**
