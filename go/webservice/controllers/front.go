package controllers

import (
	"encoding/json"
	"io"
	"net/http"
)

// RegisterControllers - return: nil
func RegisterControllers() {
	uc := newUserController()

	http.Handle("/users", *uc)
	http.Handle("/users/", *uc)
}

// encodeReponseAsJSON - return: nil
func encodeResponseAsJSON(data interface{}, writer io.Writer) {
	enc := json.NewEncoder(writer)
	enc.Encode(data)
}
