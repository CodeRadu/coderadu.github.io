---
title: Go Shell
date: 2022-08-12
layout: 'post'
slug: 'go-shell'
image: logo.png
menu:
  main:
    weight: -10
---

# Go Shell

I have recently made a shell in go, [link](https://github.com/CodeRadu/jail-shell) to its source code.

## Basic code

```go
package main

import (
	"bufio"
	"fmt"
	"os"
	"os/exec"
	"os/signal"
	"runtime"
	"strings"
)

func main() {
	if runtime.GOOS == "windows" {
		fmt.Println("Shell is not made for windows. Sorry")
		os.Exit(1)
	}

	reader := bufio.NewReader(os.Stdin)
	for {
		wd, err := os.Getwd()
		if err != nil {
			fmt.Fprintln(os.Stderr, err)
		}
		fmt.Print(wd)
		fmt.Print(" $ ")
		input, err := reader.ReadString('\n')
		if err != nil {
			fmt.Fprintln(os.Stderr, err)
		}
		if err = execInput(input); err != nil {
			fmt.Fprintln(os.Stderr, err)
		}
	}
}
func execInput(input string) error {
	home := os.Getenv("HOME")
	input = strings.TrimSuffix(input, "\n")

	args := strings.Split(input, " ")

	switch args[0] {
	case "exit":
		os.Exit(0)
	case "cd":
		if len(args) < 2 {
			return os.Chdir(home)
		}
		return os.Chdir(args[1])
	}

	cmd := exec.Command(args[0], args[1:]...)
	cmd.Stdin = os.Stdin
	cmd.Stdout = os.Stdout
	cmd.Stderr = os.Stderr

	return cmd.Run()
}

```

Don't worry, we'll go over the code

## Code explanation

### Check if running on windows

```go
if runtime.GOOS == "windows" {
  fmt.Println("Shell is not made for windows. Sorry")
  os.Exit(1)
}
```

This checks if it is running on windows. If it is, it exits with error.

### Create reader

```go
reader := bufio.NewReader(os.Stdin)
```

This allows us to read from the standard input.

### Read loop

```go
for {
  wd, err := os.Getwd()
  if err != nil {
    fmt.Fprintln(os.Stderr, err)
  }
  fmt.Print(wd)
  fmt.Print(" $ ")
  input, err := reader.ReadString('\n')
  if err != nil {
    fmt.Fprintln(os.Stderr, err)
  }
  if err = execInput(input); err != nil {
    fmt.Fprintln(os.Stderr, err)
  }
}
```

This reads from the standard input and executes the input.

### Execute input

```go
func execInput(input string) error {
  home := os.Getenv("HOME")
  input = strings.TrimSuffix(input, "\n")

  args := strings.Split(input, " ")

  switch args[0] {
  case "exit":
    os.Exit(0)
  case "cd":
    if len(args) < 2 {
      return os.Chdir(home)
    }
    return os.Chdir(args[1])
  }

  cmd := exec.Command(args[0], args[1:]...)
  cmd.Stdin = os.Stdin
  cmd.Stdout = os.Stdout
  cmd.Stderr = os.Stderr

  return cmd.Run()
}
```

This executes the input.

```go
switch args[0] {
case "exit":
  os.Exit(0)
case "cd":
  if len(args) < 2 {
    return os.Chdir(home)
  }
  return os.Chdir(args[1])
}
```

This switch statement adds commands that don't have a binary.

## Conclusion

This is a shell in go.  
Obviously it can be modified to add commands and customize it.
