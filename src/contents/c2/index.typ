= Background
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
