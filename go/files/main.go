package main

import (
	"fmt"

	"github.com/KennyBlanckaert/Other/tree/master/go/files/models"
	"github.com/KennyBlanckaert/Other/tree/master/go/files/logic"
)

// Main function
func main() {
	// user := "kenny"
	profiles := []models.Copy{
		{
			Source: 		fmt.Sprintf("/Files/Test/"),
			Destination: 	fmt.Sprintf("/tmp/Test/"),
			Log:			fmt.Sprintf("/Files/Logging/"),
			Share:			models.Share{ Name: "//<host>/Files/", Path: "/Files/" },
			Credential:		models.Credential{ User: "<username>", Password: "<password>" },
		},
	}

	logic.CopyProfiles(profiles)
}
