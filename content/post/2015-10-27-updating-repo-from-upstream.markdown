---
categories: 
- git
comments: false
date: "2015-10-27T22:36:00Z"
tags:
- git
- github
- open source
title: Keeping Your Github Fork Updated
---

Tonight was a rainy, cold night in my town, so I spent the evening trying to get my four pull requests in for [Digital Ocean's Hackoberfest](https://hacktoberfest.digitalocean.com/). I found myself updating an old fork on [my Github page](https://github.com/kelcecil) and reflecting on the questions I had when starting with Git and Github. How to update my personal fork on Github from the original repository was one of my first tasks I learned, and I thought I'd take the opportunity to pass the knowledge along in the spirit of Hackoberfest.
<!--more-->

I have a [fork of Kubernetes](https://github.com/kelcecil/kubernetes) in my Github account for preparing pull requests. I can clone my repository to my development workstation using *git clone*:

{{< highlight bash >}}
> git clone git@github.com:kelcecil/kubernetes.git
Cloning into 'kubernetes'...
remote: Counting objects: 162966, done.
remote: Compressing objects: 100% (6/6), done.
remote: Total 162966 (delta 0), reused 0 (delta 0), pack-reused 162960
Receiving objects: 100% (162966/162966), 124.80 MiB | 8.79 MiB/s, done.
Resolving deltas: 100% (106653/106653), done.
Checking connectivity... done.
{{< / highlight >}}

The URI used in the *git clone* command is stored as a remote named *origin*. We can verify this very easily using *git remote*:

{{< highlight bash >}}
> git remote -v                                                                   
origin  git@github.com:kelcecil/kubernetes.git (fetch)
origin  git@github.com:kelcecil/kubernetes.git (push)
{{< / highlight >}}

This remote named origin is the repository location we are referring to when we perform *git push origin master* or *git pull origin master*. *origin* is only one possible location, and we can add other remote repositories such as the upstream repository that we'd like to pull data from. Let's add the main Kubernetes repository as a remote named *upstream* using *git remote add*.

{{< highlight bash >}}
> git remote add upstream git@github.com:kubernetes/kubernetes.git
> git remote -v
origin  git@github.com:kelcecil/kubernetes.git (fetch)
origin  git@github.com:kelcecil/kubernetes.git (push)
upstream        git@github.com:kubernetes/kubernetes.git (fetch)
upstream        git@github.com:kubernetes/kubernetes.git (push)
{{< / highlight >}}

We can now easily update our code from the upstream Kubernetes repository with a simple *git pull*. You can then push your repository to origin to update your forked repository.

{{< highlight bash >}}
> git pull upstream master
...
> git push origin master
...
{{< / highlight >}}

Excellent work! Our forked repository is now up to date with the upstream repository, and we're ready to hack on our favorite project!
