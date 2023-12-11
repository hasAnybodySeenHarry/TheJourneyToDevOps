package main

import (
    "fmt"
    "net/http"
)

func main() {
    http.HandleFunc("/", func(w http.ResponseWriter, r *http.Request) {
        fmt.Fprintf(w, "<h1>The Journey to DevOps - Go</h1>")
    })

    port := 3000
    fmt.Printf("Server is running on :%d...\n", port)
    http.ListenAndServe(fmt.Sprintf(":%d", port), nil)
}

