= Background <background>
Chapter 2 provides a comprehensive background on the fundamental technologies
underlying the research: Message Passing Interface (MPI) and C++11
Multithreading. The chapter explores these technologies within the context of
high-performance computing, laying the groundwork for understanding the hybrid
programming model proposed in the thesis.

@mpi delves into MPI, presenting it as a critical message-passing library
interface specification. The section goes beyond traditional communication
models by highlighting MPI's advanced capabilities, including collective
operations, remote-memory access, and parallel I/O. A significant focus is
placed on One-Sided Communications, a sophisticated communication mechanism that
allows a single MPI process to independently manage communication tasks. The
section elaborates on the various Remote Memory Access (RMA) operations and
explores two distinct memory models: Separate and Unified Memory Models.

@cpp11 explores C++11 Multithreading, marking a pivotal advancement in parallel
computing. The section demonstrates how C++11 introduced native,
platform-independent threading support through its standard library. It
comprehensively covers key multithreading features, including thread management,
synchronization primitives, atomic operations, and asynchronous programming
constructs. The discussion emphasizes the advantages of C++11's threading model,
such as type-safe synchronization and reduced dependency on platform-specific
libraries.

The concluding @hpc-context bridges these technologies within the
high-performance computing context. It illustrates how C++11 multithreading and
MPI can complement each other: C++11 provides efficient inter-core communication
within a single node, while MPI handles communication between different
computers in a cluster. This perspective sets the stage for the thesis's
exploration of a hybrid programming model that leverages the strengths of both
technologies.

By providing this detailed technological background, Chapter 2 establishes the
theoretical and practical foundations necessary for understanding the subsequent
research on barrier synchronization algorithms in high-performance computing.

#pagebreak()
#set heading(offset: 1)

#{ include "./mpi.typ" }

#{ include "./cpp11.typ" }

= HPC Context <hpc-context>
In the landscape of high-performance computing (HPC), C++11 multithreading
provides a standardized approach to shared-memory parallel processing. When
considering hybrid parallelization strategies in modern HPC environments,
C++11's threading capabilities play a crucial role alongside distributed
computing protocols.

To illustrate the complementary relationship between C++11 multithreading and
Message Passing Interface (MPI), consider a typical HPC cluster architecture:

- Within a single compute node: * C++11 multithreading provides efficient
  shared-memory parallelism across CPU
  cores* Thread communication occurs through direct memory access *
  Synchronization is handled through native C++11 primitives (mutex, atomic
  operations)* Zero-copy data sharing is possible between threads

- Between cluster nodes: * MPI handles inter-node communication through message
  passing* Network infrastructure facilitates data transfer * Explicit data
  serialization and communication required* Each node runs independent processes

This hierarchical approach to parallelism, often called hybrid parallelization,
leverages the strengths of both paradigms:
1. C++11 threads efficiently utilize shared memory within a node
2. MPI manages distributed memory communication across the cluster
3. The combination can potentially reduce the overall MPI process count
4. Memory footprint can be optimized by sharing data between threads

This makes C++11's threading library particularly effective in modern HPC
applications, where it serves as the intra-node parallelization layer in hybrid
MPI+threads programs.
