package models

// Share Object
type Share struct {
	Name string
	Path string
}

// Credential Object
type Credential struct {
	User string
	Password string
}

// File Object
type Copy struct {
	Source	string
	Destination string
	Log string
	Share Share
	Credential Credential
}