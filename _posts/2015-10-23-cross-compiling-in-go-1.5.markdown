---
layout: post
title: "Cross Compiling in Go 1.5"
date: 2015-10-23 22:52:00 -0500
comments: false
categories: golang
tags: [golang, cross-compile]
---

Are you a developer that develops on one operating system and deploys to another? You might be an open source developer that wants to generate binaries for combinations of operating systems and platforms? One of the coolest features of Go 1.5 is how easy cross-compiling your applications for other architectures and operating systems can be, and I'm going to show you how in this post.
<!--more-->

Why might we need to cross-compile our code? One of my favorite aspects of Golang are the  binaries that are produced during a build. Gone are the days of having to install a runtime and dependencies on production boxes to execute that incredibly helpful script. Go's static binaries include everything you'll need to run your app in a single easy-to-transfer executable. [This is a fantastic asset for system administrators,](http://www.youtube.com/watch?v=wyRbHhHFZh8) but this convenience comes with a minor concern. Using low-level binaries means that we'll need binaries prepared for specific processor architecture and platform combinations. This may sound like a hassle, but read on to see how Go 1.5 makes this task trivial!

Let's take this incredibly simple Go application and pretend this is a slick tool for system administrators:
{% highlight go %}
package main

import (
        "fmt"
        "time"
)

func main() {
        for {
                fmt.Println("Hello!")
                time.Sleep(time.Second)
        }
}
{% endhighlight %}

What an awesome, feature-rich tool! Let's build our tool using *go build*:

{% highlight bash %}
go build -o hello main.go
{% endhighlight bash %}

*go build* uses the host operating system and processor architecture by default. We can verify the format of the produced binary using the *file* utility and see this binary was prepared for a x86-64 (64-bit, Intel-based) processor running on Mac OS (which uses the [Mach-O file format](https://en.wikipedia.org/wiki/Mach-O)):
{% highlight bash %}
> file hello
hello: Mach-O 64-bit executable x86_64
{% endhighlight %}

We now have this excellent utility that works on a x86-64, Mac OS machine, but we need to compile our application for x86-64, Linux-based machines. You can easily set the target operating system and processor architecture using the environment variables GOOS and GOARCH respectively. Building for a Linux system using an x86-64 processor (commonly also referred to as an amd64 processor) is as simple as running this one-liner:

{% highlight bash %}
GOOS=linux GOARCH=amd64 go build -o hello main.go
{% endhighlight %}

The *file* utility tells us that our binary has been prepared using the ELF executable format and ready for action on a x86-64 Linux system.

{% highlight bash %}
> file hello
hello: ELF 64-bit LSB executable, x86-64, version 1 (SYSV), statically linked, not stripped
{% endhighlight %}

Easy, huh? Cross-compiling in Go 1.5 is that simple!

I can hear your next question from the other side of the internet. What architectures and operating systems does Go 1.5 support? Go currently enjoys operating system support for Windows, OS X, Linux, plenty of BSD variants, and [Plan 9](https://en.wikipedia.org/wiki/Plan_9_from_Bell_Labs) among others. Supported architectures includes x86, x86-64 (amd64), 32 and 64-bit arm processors, PowerPC, and others! A list of valid operating system and processor architecture combinations are available in [the Go documentation](https://golang.org/doc/install/source).

We can also take a peak inside the source for [*go build*](https://github.com/golang/go/blob/master/src/cmd/dist/build.go) and see what *go build* will accept.

{% highlight go %}
// The known architectures.
var okgoarch = []string{
	"386",
	"amd64",
	"amd64p32",
	"arm",
	"arm64",
	"ppc64",
	"ppc64le",
}

// The known operating systems.
var okgoos = []string{
	"darwin",
	"dragonfly",
	"linux",
	"android",
	"solaris",
	"freebsd",
	"nacl",
	"netbsd",
	"openbsd",
	"plan9",
	"windows",
}
{% endhighlight %}

I highly recommend using the combinations in [the Go documentation](https://golang.org/doc/install/source) for applications that require stability, but peeking into the source provides a glimpse into what [the future might bring](https://github.com/golang/mobile).

You're now prepared to cross-compile some of your Go tools to share with friends using other architectures and environments! Try experimenting with building binaries for different platforms, and be sure to share what you learn!
