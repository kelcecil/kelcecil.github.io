---
categories: 
- speaking
comments: false
date: "2015-10-03T23:31:06Z"
tags:
- ohiolinux
- encouragement
- kubernetes
title: Don't Sweat What You Can't Control
---

I was honored to be part of Ohio Linuxfest's 2015 schedule this year. My presentation agenda was introducing Kubernetes resources and processes such as the api server, kubelet and others using slides. I followed with a live demonstration where I deployed a container with my blog to a Kubernetes cluster.

The thought of doing a demonstration was somewhat terrifying to me. A speaker's primary goal is to present an argument through a convincing story, and I was feeling nervous about presentation. What if I stumbled when discussing something? What if I said something that didn't make any sense? What do I do if I have an attendee that really wanted to heckle me? I imagined doomsday-like scenarios where my demonstration crashed and caused a room full of people to decide never to give Kubernetes a shot. Perhaps my presentation would be so disastrous that these fine listeners might give up computing entirely and relocate to the Himalayas to reconnect with nature? This all may seem a bit ridiculous, but that's just how irrational fear can be.

My Ohio Linuxfest '15 presentation started out strong, but my demo suffered from a slight problem. I submitted a replication controller using kubectl that should have used a cached Docker image on my nodes to create the pods. Kubelet on the nodes unexpectedly tried to query my Docker repository. The conference wifi was unreliable, and I quickly found my request to the repository 404'd. I did my best to make a joke out of this unfortunate turn of events, but I was beginning to enter a panic mode. I'd prepared a plan B for my slides, but I really didn't want to find myself faced with using my boring backup slides for my talk. My audience was digging the demonstration, and I would be heartbroken for my talk to end like that.

A member of the audience named Bill stepped up and offers their personal wifi access point for my use. I was able to connect to his wifi, get the images I needed, and finish the presentation. The audience loved the presentation, and I received tons of positive feedback.

I reflected on this experience for a while, and I came to a few conclusions. Demonstrations aren't always going to go your way, but handling the unexpected is just as important as performing what you've rehearsed. A presenter's attitude when dealing with  unexpected problems can show the audience that problems can be easily dealt with. Unexpected issues also provide members of your audience and the community to step up and be a part of your presentation.

What the overall lesson here? Don't sweat what you can't control. The unexpected problems can add to your presentation if you approach them with the right attitude.
