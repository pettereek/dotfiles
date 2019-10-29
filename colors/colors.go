package main

import (
	"bufio"
	"flag"
	"fmt"
	"os"
	"sort"
	"strings"
	"text/template"
)

var filename string

func main() {
	flag.StringVar(&filename, "file", "colors.data", "Colors data file")
	flag.Parse()

	fmt.Printf("Reading %s\n", filename)

	colors, err := ParseTerminalColors(filename)
	if err != nil {
		panic(err)
	}

	if err := WriteSVGs(colors); err != nil {
		panic(err)
	}

	if err := GenerateREADME(colors); err != nil {
		panic(err)
	}
}

func ParseTerminalColors(filename string) (TerminalColors, error) {
	f, err := os.Open(filename)
	if err != nil {
		return TerminalColors{}, err
	}

	defer f.Close()

	scanner := bufio.NewScanner(f)
	scanner.Split(bufio.ScanLines)

	var colors []ColorVariant

	for scanner.Scan() {
		c, err := ParseColor(scanner.Text())
		if err != nil {
			return TerminalColors{}, err
		}
		colors = append(colors, c)
	}

	return GroupColors(colors), nil
}

func GroupColors(vars []ColorVariant) TerminalColors {
	grouped := map[string][]ColorVariant{}
	for _, v := range vars {
		vv := grouped[v.Name]
		vv = append(vv, v)
		grouped[v.Name] = vv
	}
	termColors := TerminalColors{}
	colors := Colors{}
	for k, vars := range grouped {
		color := Color{Name: k}
		for _, v := range vars {
			switch v.Kind {
			case "normal":
				color.Normal = v
			case "bright":
				color.Bright = v
			}
		}

		switch k {
		case "foreground":
			termColors.Forground = color.Normal
		case "background":
			termColors.Background = color.Normal
		default:
			colors = append(colors, color)
		}
	}

	termColors.Colors = colors.Sort()

	return termColors
}

func WriteSVGs(termColors TerminalColors) error {
	if err := WriteSVG(termColors.Forground); err != nil {
		return err
	}
	if err := WriteSVG(termColors.Background); err != nil {
		return err
	}

	for i := range termColors.Colors {
		if err := WriteSVG(termColors.Colors[i].Normal); err != nil {
			return err
		}
		if err := WriteSVG(termColors.Colors[i].Bright); err != nil {
			return err
		}
	}
	return nil
}

func WriteSVG(colorVariant ColorVariant) error {
	if !colorVariant.Valid() {
		return nil
	}

	t, err := template.ParseFiles("color.tpl.svg")
	if err != nil {
		return err
	}

	svg, err := os.Create(colorVariant.Filename)
	if err != nil {
		return err
	}
	if err := t.Execute(svg, colorVariant); err != nil {
		return err
	}
	fmt.Printf("Wrote %s\n", colorVariant.Filename)

	return nil
}

func GenerateREADME(termColors TerminalColors) error {
	t, err := template.
		New("colors.tpl.md").
		Funcs(template.FuncMap{
			"JoinTerminator": JoinTerminator,
		}).
		ParseFiles("./colors.tpl.md")

	if err != nil {
		return err
	}

	data := struct {
		Foreground ColorVariant
		Background ColorVariant
		Colors     []Color
		EditNotice string
	}{
		Foreground: termColors.Forground,
		Background: termColors.Background,
		Colors:     termColors.Colors,
		EditNotice: "This file is generated. Do not edit.",
	}

	md, err := os.Create("colors.md")
	if err != nil {
		return err
	}

	if err := t.Execute(md, data); err != nil {
		return err
	}
	fmt.Printf("Wrote colors.md\n")
	return nil
}

type TerminalColors struct {
	Forground  ColorVariant
	Background ColorVariant

	Colors []Color
}

type Colors []Color

func (cs Colors) Sort() Colors {
	cp := make(Colors, len(cs))
	copy(cp, cs)

	sort.Slice(cp, func(i, j int) bool {
		return cp[i].Normal.ID < cp[j].Normal.ID
	})

	return cp
}

func JoinTerminator(cs []Color) string {
	s := []string{}
	for i := range cs {
		s = append(s, cs[i].Normal.Hex)
	}
	for i := range cs {
		s = append(s, cs[i].Bright.Hex)
	}
	return strings.Join(s, ":")
}

type Color struct {
	Name   string
	Normal ColorVariant
	Bright ColorVariant
}

type ColorVariant struct {
	Name     string
	ID       string
	Filename string
	Kind     string
	Hex      string
}

func (cv ColorVariant) Valid() bool {
	return cv.Name != ""
}

func ParseColor(s string) (ColorVariant, error) {
	ss := strings.Split(s, " ")
	var values []string
	for i := range ss {
		if ss[i] == "" {
			continue
		}
		values = append(values, ss[i])
	}

	var id, name, kind, hex string

	switch len(values) {
	case 3:
		id, name, kind, hex = values[0], values[1], "normal", values[2]
	case 4:
		id, name, kind, hex = values[0], values[1], values[2], values[3]
	default:
		return ColorVariant{}, fmt.Errorf("invalid color format: %s", s)
	}

	return ColorVariant{
		ID:       id,
		Name:     name,
		Filename: fmt.Sprintf("svg/%s.%s.svg", name, kind),
		Kind:     kind,
		Hex:      hex,
	}, nil
}
