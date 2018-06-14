package main

import (
	"fmt"
	"os"
	"time"
)

func main() {
	for {
		fmt.Printf("Hello, %s!\n", os.Getenv("NAME"))
		time.Sleep(1 * time.Second)
	}
}
