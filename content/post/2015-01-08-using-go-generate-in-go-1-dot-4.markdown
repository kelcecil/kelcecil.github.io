---
categories: golang
comments: false
date: "2015-01-08T21:24:12Z"
tags:
- golang
- github
- gamesdb
title: Using go generate in Go 1.4
---
I'm finding that my love for code that generates code grows as I get further in my life as a developer. Every individual method or function is one more item that I'm responsible for, and I'm a huge fan of reducing that responsibility. I'd love to share a way to accomplish this in Golang, and I'll point to a small project on Github where I give this a go.

<!--more-->

Go 1.4 introduced the generate tool in order to allow directives in Go source to call command line applications to generate code. Code generation seems to be a pretty popular idea in the Go community, and this new tool carries the idea a little further. The Golang blog (and several other places) use [generate to implement a grammar](http://blog.golang.org/generate) like so:

{{< highlight go >}}
//go:generate go tool yacc -o gopher.go -p parser gopher.y
{{< / highlight >}} 

This seems like a great use of the generate tool, but I for one don't implement grammars on daily basis. The generate tool seemed cool, but I tucked the idea away in my mind until a few nights ago.

I was implementing calls to the GamesDB web service for a Go app I was writing when I noticed that all of my functions looked almost identical to each other. The functions were identical with the exception of the function names, the first return value (with the second always being of type error), and the endpoint of the API call. I didn't want to copy and paste the code as that made for separate code for each call that had to be maintained. I wanted to be able to make a change once and generate my functions from that.

I started by writing a command line app in Go that accepted the above parameters and additionally a file name to output the source. I began with creating a template for the function and file I wanted to generate:

{{< highlight go >}}
{% raw %}
package thegamesdb

import (
        "encoding/xml"
        "net/http"
)

func {{.MethodName}}(parameters map[string]string) (*{{.OutputType}}, error) {
        var output {{.OutputType}}
        endpoint := "{{.ApiEndpoint}}?" + ConvertMapIntoGetParams(parameters)
        resp, err := http.Get(apiEndpoint + endpoint)
        if err != nil {
                return nil, err
        }

        defer resp.Body.Close()
        decoder := xml.NewDecoder(resp.Body)
        decoder.Decode(&output)
        return &output, nil
}
{% endraw %}
{{< / highlight >}}

Notice that the parameters passed in are represented in the template by the double handlebars ({{}}). These parameters are represented by a struct I constructed to hold these options to call them into the template.

{{< highlight go >}}
type Options struct {
        Output      string
        MethodName  string
        ApiEndpoint string
        OutputType  string
}
{{< / highlight >}}

Generating the source is as simple as parsing the template and executing with a Writer and my options struct.

{{< highlight go >}}
tmpl, err := template.New("method").Parse(methodTemplate)
err = tmpl.Execute(writer, options)
{{< / highlight >}}

The full source to this is available at [https://github.com/kelcecil/go-gamesdb/blob/master/generategamesdb/generate_gamesdb_call.go]. If you're not familiar with Go's [text/template](http://golang.org/pkg/text/template/), then I highly recommend giving it a look as well.

All that remains is to add directives to the source to generate the functions when executing go generate like so: 

{{< highlight go >}}
//go:generate generategamesdb -output get_art.go -method GetArt -type GetArtResponse -endpoint GetArt.php
{{< / highlight >}}

My executable is called generategamesdb, but you can replace this with any executable in your *PATH* (make sure that *${GOPATH}/bin* is in your *PATH* if you're interesting in using a Go command line app like I am.) Running go generate after adding my generate directive provides beautiful, generated functions like so:

{{< highlight go >}}
func GetArt(parameters map[string]string) (*GetArtResponse, error) {
        var output GetArtResponse
        endpoint := "GetArt.php?" + ConvertMapIntoGetParams(parameters)
        resp, err := http.Get(apiEndpoint + endpoint)
        if err != nil {
                return nil, err
        }

        defer resp.Body.Close()
        decoder := xml.NewDecoder(resp.Body)
        decoder.Decode(&output)
        return &output, nil
}
{{< / highlight >}}

If you'd like to check out a working example of this flow, feel free to view my repository for go-gamesdb at [https://github.com/kelcecil/go-gamesdb/]. Feel free to pull it down, play with it, write an app with it, and learn from it. Pull requests are always welcome if you see anything you'd like to add.

I hope you'll give go generate a try and share your experiences! I can't wait to see what other uses we can come up with as we begin to use the tool. 
