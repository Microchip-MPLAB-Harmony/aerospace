---
parent: Peripheral libraries
title: ICM Peripheral Library
has_children: true
has_toc: false
nav_order: 2

family: SAMRH71
function: ICM
---

# ICM Peripheral Library

The Integrity Check Monitor (ICM) is a DMA controller that performs hash calculation over multiple memory regions using transfer descriptors located in memory (ICM Descriptor Area). The Hash function is based on the Secure Hash Algorithm (SHA). The ICM integrates two modes of operation. The first one is used to hash a list of memory regions and save the digests to memory (ICM Hash Area). The second mode is an active monitoring of the memory. In that mode, the hash function is evaluated and compared to the digest located at a predefined memory
address (ICM Hash Area). If a mismatch occurs, an interrupt is raised.

* [Configuring the library](usage.md/#configuring-the-library)

* [Using the library](usage.md/#using-the-library)

* [Library interface](interface.md)
