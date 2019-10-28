package main

import (
	"bufio"
	"errors"
	"flag"
	"fmt"
	"os"
	"strings"
	"text/template"
)

var filename string

func main() {
	flag.StringVar(&filename, "file", "colors.data", "Colors data file")
	flag.Parse()

	fmt.Printf("Reading %s\n", filename)

	colors, err := ParseColors(filename)
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

func ParseColors(filename string) ([]Color, error) {
	f, err := os.Open(filename)
	if err != nil {
		return nil, err
	}

	defer f.Close()

	scanner := bufio.NewScanner(f)
	scanner.Split(bufio.ScanLines)

	var colors []Color

	for scanner.Scan() {
		c, err := ParseColor(scanner.Text())
		if err != nil {
			return nil, err
		}
		colors = append(colors, c)
	}

	return colors, nil
}

func WriteSVGs(colors []Color) error {
	t, err := template.ParseFiles("color.tpl.svg")
	if err != nil {
		return err
	}

	for i := range colors {
		c := colors[i]
		svg, err := os.Create(c.Filename)
		if err != nil {
			return err
		}
		if err := t.Execute(svg, c); err != nil {
			return err
		}
		fmt.Printf("Wrote %s\n", c.Filename)
	}

	return nil
}

func GenerateREADME(colors []Color) error {
	t, err := template.ParseFiles("./colors.tpl.md")
	if err != nil {
		return err
	}

	data := struct {
		Colors     []Color
		EditNotice string
	}{
		Colors:     colors,
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

type Color struct {
	ID       string
	Name     string
	Filename string
	Kind     string
	Hex      string
}

func ParseColor(s string) (Color, error) {
	ss := strings.Split(s, " ")
	var compact []string
	for i := range ss {
		if ss[i] == "" {
			continue
		}
		compact = append(compact, ss[i])
	}

	var id, name, kind, hex string
	switch len(compact) {
	case 3:
		id = compact[0]
		name = compact[1]
		kind = "normal"
		hex = compact[2]
	case 4:
		id = compact[0]
		name = compact[1]
		kind = compact[2]
		hex = compact[3]
	default:
		return Color{}, errors.New("invalid color")
	}

	return Color{
		ID:       id,
		Name:     name,
		Filename: fmt.Sprintf("svg/%s.%s.svg", name, kind),
		Kind:     kind,
		Hex:      hex,
	}, nil
}
