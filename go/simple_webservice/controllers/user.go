package controllers

import (
	"encoding/json"
	"fmt"
	"net/http"
	"regexp"

	"github.com/KennyBlanckaert/Other/tree/master/go/webservice/models"
)

type userController struct {
	userIDPattern *regexp.Regexp
}

func newUserController() *userController {
	return &userController{
		userIDPattern: regexp.MustCompile(`^/users/(\d+)/?`),
	}
}

func (uc *userController) parseRequest(request *http.Request) (models.User, error) {
	var user models.User
	dec := json.NewDecoder(request.Body)

	err := dec.Decode(&user)
	if err != nil {
		fmt.Println("Empty User Object returned")
		return models.User{}, err
	}

	return user, nil
}

func (uc *userController) get(writer http.ResponseWriter, request *http.Request) {
	encodeResponseAsJSON(models.GetUsers(), writer)
}

func (uc *userController) post(writer http.ResponseWriter, request *http.Request) {
	user, err := uc.parseRequest(request)
	if err != nil {
		writer.WriteHeader(http.StatusInternalServerError)
		writer.Write([]byte("Could not parse User object"))
	}

	user, err = models.AddUser(user)
	if err != nil {
		writer.WriteHeader(http.StatusInternalServerError)
		writer.Write([]byte(err.Error()))
	}

	encodeResponseAsJSON(user, writer)
}

func (uc *userController) put(writer http.ResponseWriter, request *http.Request) {
	user, err := uc.parseRequest(request)
	if err != nil {
		writer.WriteHeader(http.StatusInternalServerError)
		writer.Write([]byte("Could not parse User object"))
	}

	user, err = models.UpdateUser(user)
	if err != nil {
		writer.WriteHeader(http.StatusInternalServerError)
		writer.Write([]byte(err.Error()))
	}

	encodeResponseAsJSON(user, writer)
}

func (uc *userController) delete(writer http.ResponseWriter, request *http.Request) {
	user, err := uc.parseRequest(request)
	if err != nil {
		writer.WriteHeader(http.StatusInternalServerError)
		writer.Write([]byte("Could not parse User object"))
	}

	user, err = models.RemoveUser(user)
	if err != nil {
		writer.WriteHeader(http.StatusInternalServerError)
		writer.Write([]byte(err.Error()))
	}

	encodeResponseAsJSON(user, writer)
}

func (uc userController) ServeHTTP(writer http.ResponseWriter, request *http.Request) {

	switch request.Method {
	case http.MethodGet:
		uc.get(writer, request)

	case http.MethodPost:
		uc.post(writer, request)

	case http.MethodPut:
		uc.put(writer, request)

	case http.MethodDelete:
		uc.delete(writer, request)

	default:
		writer.WriteHeader(http.StatusNotImplemented)
	}
}
