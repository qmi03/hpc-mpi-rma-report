= Message Passing Interface (MPI) <mpi>
This section explores Message Passing Interface, its various paradigms
for message passing (@mpi-intro). The section will then shift its focus into MPI's One-Sided Communication
mechanics.

== Introduction <mpi-intro>
MPI @mpi41 is a message-passing library interface specification - essentially a
set of standard guidelines for both implementors and users of the parallel
programming model. In this programming paradigm, data traverses between the
address spaces of different processes through cooperative operations - what we
might call as "classical message-passing techniques".

Beyond the classical model, MPI extends its capabilities by offering:
- Collective operations
- Remote-memory access operations
- Dynamic process creation
- Parallel I/O

Within this thesis, I will specifically dive deep into remote-memory access
operations in MPI, which form the critical building block for MPI's One-Sided
Communication, a concept first introduced in MPI-2 @mpi2, and later refined in MPI-3 @mpi3.

== One-Sided Communications <one-sided-comm>
Unlike "classical" Point-to-Point communication - where
communication is a two-way collaborative effort between processes, with one
sending and another receiving - Remote Memory Access introduces a more flexible
communication mechanism called One-Sided communication.

In this approach, a single MPI process can now independently orchestrate the
entire communication task, by specifying communication parameters for both the
sending and receiving sides.

Regular send/receive communication requires matching operations by sender and
receiver. To issue the matching operations, the application needs to
distribute the transfer parameters. This may require all MPI processes to
participate in a global computation, or to explicitly poll for potential
communication requests to respond periodically.
This could potentially introduce plenty overhead.

The use of RMA communication operations avoids the need for global computation
or explicit polling @mpi41.

Message-passing in general achieves two effects: communication of data from
sender to receiver and synchronization of sender with receiver. RMA design
separates these two functions.

Within MPI standards, the primitive communication operations are as follows:
- Remote write operations: MPI_PUT, MPI_RPUT
- Remote read operations: MPI_GET, MPI_RGET
- Remote update operations: MPI_ACCUMULATE, MPI_RACCUMULATE
- Combined read and update operations: MPI_GET_ACCUMULATE, MPI_RGET_ACCUMULATE,
  and MPI_FETCH_AND_OP
- Remote atomic swap: MPI_COMPARE_AND_SWAP
The primitive synchronization operations are:
- Active Target Communication:
- Passive Target Communication:

== Memory Model
MPI supports two distinct memory models:

1. Separate Memory Model:
  - No inherent memory consistency assumptions
  - Similar to weakly coherent memory systems
  - Requires explicit synchronization for correct memory access ordering

2. Unified Memory Model:
  - Exploits cache-coherent hardware
  - Supports hardware-accelerated one-sided operations
  - Typically found in high-performance computing environments

The MPI design's flexibility allows implementors to leverage platform-specific
communication mechanisms, including:
- Coherent and non-coherent shared memory
- Direct Memory Access (DMA) engines
- Hardware-supported put/get operations
- Communication coprocessors
