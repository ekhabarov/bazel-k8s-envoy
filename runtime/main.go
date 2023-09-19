package main

import (
	"fmt"
	"runtime"
)

func main() {
	fmt.Printf("Hello, from %s/%s!", runtime.GOOS, runtime.GOARCH)
}
