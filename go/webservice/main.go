package main

import (
	"net/http"

	"github.com/webservice/controllers"
)

// Main function
func main() {
	controllers.RegisterControllers()
	http.ListenAndServe(":3000", nil)
}
