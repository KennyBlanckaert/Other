package main

import (
	"fmt"

	"github.com/KennyBlanckaert/Other/tree/master/go/files/models"
	"github.com/KennyBlanckaert/Other/tree/master/go/files/logic"
)

// Main function: Persistent Files from Mount/Share to local directory
func main() {
	// user := "kenny"

	// NOTE: '/' for Linux & '\\' for Windows
	// (do NOT end directories with '\\' for Windows)
	
	// profiles := []models.Copy{
	// 	{
	// 		Source: 		fmt.Sprintf("S:\\Test\\copy.txt"),
	// 		Destination: 	fmt.Sprintf("C:\\Test"),
	// 		Log:			fmt.Sprintf("S:\\Logging"),
	// 		Share:			models.Share{ Name: "\\\\192.168.25.70\\Files", Path: "S:" },
	// 		Credential:		models.Credential{ User: "ebo", Password: "Beb01hal" },
	// 	},
	// }

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
