# ICM Peripheral Library

The Integrity Check Monitor (ICM) is a DMA controller that performs hash calculation over multiple memory regions using transfer descriptors located in memory (ICM Descriptor Area). The Hash function is based on the Secure Hash Algorithm (SHA). The ICM integrates two modes of operation. The first one is used to hash a list of memory regions and save the digests to memory (ICM Hash Area). The second mode is an active monitoring of the memory. In that mode, the hash function is evaluated and compared to the digest located at a predefined memory
address (ICM Hash Area). If a mismatch occurs, an interrupt is raised.

* [Configuring the library](help.md/##-Configuring-the-library)

* [Using the library](help.md/##-Using-the-library)

* [Library interface](interface.md)
