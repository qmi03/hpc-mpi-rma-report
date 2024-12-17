= Background
Chapter 2 provides a comprehensive background on the fundamental technologies
underlying the research: Message Passing Interface (MPI) and C++11
Multithreading. The chapter explores these technologies within the context of
high-performance computing, laying the groundwork for understanding the hybrid
programming model proposed in the thesis.

Section 2.1 delves into MPI, presenting it as a critical message-passing library
interface specification. The section goes beyond traditional communication
models by highlighting MPI's advanced capabilities, including collective
operations, remote-memory access, and parallel I/O. A significant focus is
placed on One-Sided Communications, a sophisticated communication mechanism that
allows a single MPI process to independently manage communication tasks. The
section elaborates on the various Remote Memory Access (RMA) operations and
explores two distinct memory models: Separate and Unified Memory Models.

Section 2.2 explores C++11 Multithreading, marking a pivotal advancement in
parallel computing. The section demonstrates how C++11 introduced native,
platform-independent threading support through its standard library. It
comprehensively covers key multithreading features, including thread management,
synchronization primitives, atomic operations, and asynchronous programming
constructs. The discussion emphasizes the advantages of C++11's threading model,
such as type-safe synchronization and reduced dependency on platform-specific
libraries.

The concluding Section 2.3 bridges these technologies within the
high-performance computing context. It illustrates how C++11 multithreading and
MPI can complement each other: C++11 provides efficient inter-core communication
within a single node, while MPI handles communication between different
computers in a cluster. This perspective sets the stage for the thesis's
exploration of a hybrid programming model that leverages the strengths of both
technologies.

By providing this detailed technological background, Chapter 2 establishes the
theoretical and practical foundations necessary for understanding the subsequent
research on barrier synchronization algorithms in high-performance computing.
#set heading(offset: 1)

#{ include "./mpi.typ" }

#{ include "./cpp11.typ" }

= HPC Context
In the landscape of high-performance computing, C++11 multithreading offers a
nuanced approach to parallel processing. To illustrate this idea of bridging
C++11 multithreading library and MPI, consider a typical high-performance
computing cluster: each node typically comprises one or more multi-core
processors.
- Within a single personal computer (or computation node), C++11 multithreading
  provides an efficient mechanism for inter-core communication
- For communication between different computers in a cluster, Message Passing
  Interface (MPI) remains the preferred approach

This makes C++11's threading library particularly effective for parallelizing
computations within a single, multi-core system, complementing MPI's inter-node
communication capabilities.
