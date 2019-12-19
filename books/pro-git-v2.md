# Pro Git 2nd Edition (2014)

以下是 Pro Git 第二版的摘录。

## 1. Getting Started

Version control is a system that records changes to a file or set of files over time so that you can recall specific versions later. 

The history of version control:

1. Local Version Control Systems: RCS
1. Centralized Version Control Systems: CVS, Subversion and Perforce
1. Distributed Version Control Systems: Git, Mercurial, Bazaar or Darcs

### 1.2 A Short History of Git

For most of the lifetime of the Linux kernel maintenance (1991–2002), changes to the software were passed around as patches and archived files.

In 2002, the Linux kernel project began using a proprietary DVCS called [**BitKeeper**](https://www.bitkeeper.org/).

In 2005, the relationship between the community that developed the Linux kernel and the commercial company that developed BitKeeper broke down, and the tool’s free-of-charge status was revoked. This prompted the Linux development community (and in particular Linus Torvalds, the creator of Linux) to develop their own tool based on some of the lessons they learned while using BitKeeper.

### 1.3 Getting Started - What is Git?

**Snapshots, Not Differences.**

Other systems use **delta-based** version control. Git thinks about its data more like a **stream of snapshots**. This makes Git more like a mini filesystem with some incredibly powerful tools built on top of it, rather than simply a VCS.

**Git Has Integrity**

Everything in Git is checksummed before it is stored and is then referred to by that checksum.

TODO

https://git-scm.com/book/en/v2/Getting-Started-What-is-Git%3F

## REF

1. [Pro Git 2nd Edition (2014)][1], by *Scott Chacon* and *Ben Straub*, Apress

[1]: https://git-scm.com/book/en/v2 "Pro Git"
