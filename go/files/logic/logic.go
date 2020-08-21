package logic

import (
	"os"
	"fmt"
	"runtime"
	"os/exec"

	io "github.com/otiai10/copy"

	"github.com/KennyBlanckaert/Other/tree/master/go/files/models"
)

// FileCopy - execute all copy operations
func CopyProfiles(objects []models.Copy) error {
	for _, object := range objects {
		
		initialize(object)
		err := verify(object)
		switch (err) {
			case nil: 
				copy(object)
				return err
			default: 
				return err
		}
	}

	// Copy succesful
	return nil
}

// verify - checks the source & destionation paths
func verify(object models.Copy) error {
	var err error

	// source file
	_, err = os.Stat(object.Source)
	if err != nil {
        return err
    }

	// destination file
	_, err = os.Stat(object.Destination)
	if err != nil {
        return err
	}
	
	// everything OK
	return nil
}

// initialize - create shares & directories
func initialize(object models.Copy) {
	if object.Share.Path != "" && object.Share.Name != "" {
		var err error
		var result []byte
		if runtime.GOOS == "windows" {
			err = exec.Command("cmd.exe", "/C", "net", "use", object.Share.Path, "/delete", "/yes").Run()
			err = exec.Command("cmd.exe", "/C", "net", "use", object.Share.Path, object.Share.Name, "/yes").Run()
			err = exec.Command("cmd.exe", "/C", "mkdir", object.Destination).Run()
		}
		if runtime.GOOS == "linux" {
			err = exec.Command("umount", object.Share.Path).Run()
			err = exec.Command("mkdir", "-p", object.Share.Path).Run()
			err = exec.Command("mkdir", "-p", object.Destination).Run()

			options := fmt.Sprintf("username=%s,password=%s", object.Credential.User, object.Credential.Password)
			err = exec.Command("mount", "-t", "cifs", object.Share.Name, object.Share.Path, "-o", options).Run()
		}
	}

}

// copy - copy source to destination
func copy(object models.Copy) error {

	// copy source to destination
	err := io.Copy(object.Source, object.Destination)
	if err != nil {
		return err
	}

	// everything OK
	return nil
}