package main

import (
	"net/http"

	"github.com/KennyBlanckaert/Other/tree/master/go/simple_webservice/controllers"
)

// Main function
func main() {
	controllers.RegisterControllers()
	http.ListenAndServe(":3000", nil)
}
