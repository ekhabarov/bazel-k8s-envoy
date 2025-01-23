package main

import (
	"fmt"
	"runtime"
)

func main() {
	fmt.Printf("Hello1, from %s/%s!", runtime.GOOS, runtime.GOARCH)
}
