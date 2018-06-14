package main

import (
	"fmt"
	"time"
)

func main() {
	for {
		fmt.Println("Hello, Kaniko!")
		time.Sleep(1 * time.Second)
	}
}
