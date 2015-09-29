---
layout: post
title: "Anonymous Structs in Go"
date: 2015-01-08 00:12:06 -0500
comments: false 
categories: golang
tags: [golang, structs]
---
Did you know you can use anonymous structs in Go? A co-worker and I discovered this when trying to figure out an easy way to format data to send to the json Marshal method in the standard library. It's incredibly easy to do and easier than using a blank interface!

{% highlight go %}
nesCarts := []string{"Battletoads", "Mega Man 1", "Clash at Demonhead"}
numberOfCarts := len(nesCarts)

anonymousStruct := struct {
	NESCarts 	[]string
	numberOfCarts   int
}{
	nesCarts,
	numberOfCarts,
}
{% endhighlight %}

Notice how I'm using not commas in the declaration of the struct, but I'm using them when initializing values in the struct. Keep this in mind when you're using them.

