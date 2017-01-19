---
date: 2016-03-07
title: Metta architecture
categories: [metta]
type: note
---
System works as a federation of autonomous services distributed onto different machines across the network.

The API between these services are described using interfaces. Each interface has a certain specific semantic. Interfaces also specify points at which separation of work could happen, where one service could delegate the work to another without bothering too much about where this service is located and how this work will be arranged.

There are storage and computation services. They have some common properties, like latency (time between sending a request and receiving a result), and some specific ones, like capacity (the amount of data which can be stored onto the storage device). These values become the basis for QoS - quality of service control, which manages latency and bandwidth constraints to keep services useful, but not let less important services interrupt more important ones. For example, you wouldn’t want your audio-video conference to be interrupted by background file-sharing activity.

