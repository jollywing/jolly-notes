---
title: hacking exposed Linux 读书笔记
layout: post
---

网络协议：NetBIOS.
Wireshark: 抓包工具.
worm.

Security is the separation of an asset from a threat.
THE FOUR COMPREHENSIVE CONSTRAINTS: channel, vector, index and scope.

`channel`, `vector` and `index` are all physical constraints.

`channel`是攻击的途径。OSSTMM将攻击途径分为五类：物理、无线、人、telecommunication和数据网络。

`vector` 是攻击来的方向。以Linux mail server为例，有三个攻击向量存在：机房内物理接触、本地网络的攻击、通过internet发起的攻击。

`index` 用来唯一标记安全领域中的目标对象的。
在一个安全领域中，目标对象要么是财产本身，要么是通往财产的门径 (gateway)。
在Linux mail server的例子中，物理上该服务器可以通过标签被索引。在数据网络中，该服务器可以通过MAC地址或者IP地址来索引。


only `scope` is a logical constraint.
安全需要涵盖的领域。比如一个邮件服务器，范围涵盖邮箱本身、键盘访问、远程访问、远程使用SMTP服务、远程与DNS服务的交互等。
