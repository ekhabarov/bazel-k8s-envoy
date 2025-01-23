//go:build tools
// +build tools

package tools

import (
	_ "github.com/BurntSushi/toml"
	_ "golang.org/x/tools/go/analysis"
	_ "honnef.co/go/tools/unused"
)
