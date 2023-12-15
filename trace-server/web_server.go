package main

import (
	"fmt"
	"html/template"
	"log"
	"net/http"
	"os"

	"github.com/goccy/go-graphviz"
)

func rootHandler(w http.ResponseWriter, _ *http.Request) {
	tmp := `
	<!DOCTYPE html>
	<html>
	<head>
		<meta charset="UTF-8">
		<title>trace-server</title>
		</head>
	<body>
		<h2>This server serves the following endpoints.</h2>
		{{ range . }}
			<p><a href="{{- . }}">{{- . }}</a></p>
		{{ end }}
	</body>
	</html>`
	t := template.Must(template.New("a").Parse(tmp))
	sliceData := []string{
		"/get-all-mergelogs",
		"/get-all-mergelogs-image",
		"/get-relevant-mergelogs",
		"/get-relevant-mergelogs-image",
	}
	t.Execute(w, sliceData)
}

func getAllMergelogsHandler(w http.ResponseWriter, _ *http.Request) {
	tmp := `
	<!DOCTYPE html>
	<html>
	<head>
		<meta charset="UTF-8">
		<title>trace-server</title>
		</head>
	<body>
		<h2>All Mergelogs</h2>
		<ul>
		{{ range . }}
			<li>{{ .}}</li>
		{{ end }}
		</ul>
	</body>
	</html>`
	t := template.Must(template.New("a").Parse(tmp))
	t.Execute(w, mergelogList.getAll())
}

// TODO: implement
// getAllMergelogsImageHandler generates a graph image and returns it
func getAllMergelogsImageHandler(w http.ResponseWriter, _ *http.Request) {
	// generate graph image from mergelogList
	imagePath, err := generateGraphImage()
	if err != nil {
		log.Fatal(err)
	}

	// return the image
	tmp := `
	<!DOCTYPE html>
	<html>
	<head>
		<meta charset="UTF-8">
		<title>trace-server</title>
		</head>
	<body>
		<h2>All Mergelogs Image</h2>
		<img src="{{ . }}" alt="graph image">
		<img src="generated-img/graph-2482164804.png" alt="graph image2">
	</body>
	</html>`
	t := template.Must(template.New("a").Parse(tmp))
	t.Execute(w, imagePath)
	fmt.Println(imagePath)
}

func generateGraphImage() (string, error) {
	g := graphviz.New()
	graph, err := g.Graph()
	if err != nil {
		log.Fatal(err)
	}
	defer func() {
		if err := graph.Close(); err != nil {
			log.Fatal(err)
		}
		g.Close()
	}()
	n, err := graph.CreateNode("n")
	if err != nil {
		log.Fatal(err)
	}
	m, err := graph.CreateNode("m")
	if err != nil {
		log.Fatal(err)
	}
	e, err := graph.CreateEdge("e", n, m)
	if err != nil {
		log.Fatal(err)
	}
	e.SetLabel("e")

	// save to temporary file
	tmpFile, err := os.CreateTemp("", "graph-*.png")
	if err != nil {
		log.Println(err)
		return "", err
	}
	if err := g.RenderFilename(graph, graphviz.PNG, tmpFile.Name()); err != nil {
		return "", err
	}

	return tmpFile.Name(), nil
}

// TODO: implement
func getRelevantMergelogsHandler(w http.ResponseWriter, req *http.Request) {

}

// TODO: implement
func getRelevantMergelogsImageHandler(w http.ResponseWriter, req *http.Request) {

}
