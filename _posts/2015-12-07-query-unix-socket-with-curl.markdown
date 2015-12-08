---
layout: post
title: "Querying Unix Sockets with curl"
date: 2015-12-07 16:11:00 -0400
comments: false
categories: curl
tags: [curl, unix-sockets, netcat]
---

I recently found myself in a situation where I wanted to query the Docker socket to query their API for information, and I found myself wishing with every passing moment that I could just query a unix socket using a tool as simple and straight-forward as *curl*. Imagine my joy when I discovered that *curl* now has unix socket support in *curl* 7.40 and later. Discovering this new feature made my day, and I'm thrilled to share this with you.

Let's take a look at how this works by using *curl*'s unix socket support to find out what images our local Docker daemon has available.

{% highlight bash %}
# curl -X METHOD --unix-socket /path/to/socket.sock <endpoint>
kcecil@ubuntu:~$ curl -X GET --unix-socket /var/run/docker.sock http:/images/json
[{"Id":"3a10494514dcef7fb1b48fb4ce3c25a941bfdb5b8dfd3a0275267fc1094e9782","ParentId":"e34cf9c36b25be359613467859eb53af43787adeb35e902d68dc2a26d4b15538","RepoTags":["kelcecil/chucksay:latest"],"RepoDigests":[],"Created":1433631743,"Size":0,"VirtualSize":486914149,"Labels":{}}]
{% endhighlight %}

That's pretty easy, huh? Simply use the --unix-socket flag and make sure to throw *http:* before your endpoint (omitting the protocol in 7.46 DEV will result in a malformed url error). You can skip specifying the HTTP method (-X) if you're okay with *curl*'s default of using the HTTP GET method.

How much effort does using *curl* save? Here's an equivalent example using OpenBSD's *netcat* (also available on Ubuntu Server 15.04):

{% highlight bash %}
kcecil@ubuntu:~$ echo -e "GET /images/json HTTP/1.0\r\n" | netcat -U /var/run/docker.sock
HTTP/1.0 200 OK
Content-Type: application/json
Server: Docker/1.9.1 (linux)
Date: Mon, 07 Dec 2015 21:44:20 GMT
Content-Length: 277

[{"Id":"3a10494514dcef7fb1b48fb4ce3c25a941bfdb5b8dfd3a0275267fc1094e9782","ParentId":"e34cf9c36b25be359613467859eb53af43787adeb35e902d68dc2a26d4b15538","RepoTags":["kelcecil/chucksay:latest"],"RepoDigests":[],"Created":1433631743,"Size":0,"VirtualSize":486914149,"Labels":{}}]
{% endhighlight %}

How useful is using *curl* over *netcat*? Using *curl* can potentially provide benefits in scripting and ease of use, but anyone who already has the muscle memory to hammer out something familiar to the *netcat* line above might not be as easily persuaded by the convenience. *curl* 7.40 may also not be available in some software repositories, so knowledge of using *netcat* still may be useful if a newer version of *curl* isn't available.

You'll be ready to work with a unix socket next time you find yourself in a similar position. Go forth and *curl*!
