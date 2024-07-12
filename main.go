package main

import (
	"fmt"
	"log"
	"net/http"
	"os"
)

func main() {
	listenAddr := os.Getenv("LISTEN_ADDR")
	if len(listenAddr) == 0 {
		listenAddr = ":8080"
	}

	mux := http.NewServeMux()
	mux.HandleFunc("/hello", helloHandler)

	log.Fatal(http.ListenAndServe(listenAddr, mux))
}

func helloHandler(w http.ResponseWriter, r *http.Request) {
	logger := log.New(os.Stdout, "", log.LstdFlags|log.Lshortfile)
	logger.Println("Hello World!")
	fmt.Fprint(w, "Hello World!")
}
