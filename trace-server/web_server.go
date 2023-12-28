package main

import (
	"fmt"
	"html/template"
	"log"
	"net/http"
	"time"

	"github.com/goccy/go-graphviz"
)

func rootHandler(w http.ResponseWriter, _ *http.Request) {
	t, err := template.ParseFiles("root/index.html")
	if err != nil {
		log.Fatal(err)
	}

	sliceData := []string{
		"/assets",
		"/get-all-mergelogs",
		"/get-all-mergelogs-image",
		"/get-relevant-mergelogs",
		"/get-relevant-mergelogs-image",
	}
	t.Execute(w, sliceData)
}

func getAllMergelogsHandler(w http.ResponseWriter, _ *http.Request) {
	t, err := template.ParseFiles("root/template/getAllMergelogs.html")
	if err != nil {
		log.Fatal(err)
	}
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

	t, err := template.ParseFiles("root/template/getAllMergelogsImage.html")
	if err != nil {
		log.Fatal(err)
	}
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

	// TODO: generate graph from mergelogList
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

	now := time.Now().UTC()
	imagePath := fmt.Sprintf("assets/generated-img/%s.png", now.Format("20060102-150405"))
	if err := g.RenderFilename(graph, graphviz.PNG, imagePath); err != nil {
		return "", err
	}

	return imagePath, nil
}

// TODO: implement
func getRelevantMergelogsHandler(w http.ResponseWriter, req *http.Request) {

}

// TODO: implement
func getRelevantMergelogsImageHandler(w http.ResponseWriter, req *http.Request) {

}

// TODO: implement
func tryCanvasHandler(w http.ResponseWriter, _ *http.Request) {
	t, err := template.ParseFiles("root/template/tryCanvas.html")
	if err != nil {
		log.Fatal(err)
	}
	t.Execute(w, nil)
}
