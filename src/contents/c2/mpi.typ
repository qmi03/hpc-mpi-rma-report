= Message Passing Interface (MPI) <mpi>
In this section, we'll explore Message Passing Interface, its various paradigms
for message passing. And then we'll deep dive into its One-Sided Communication
mechanics as the focus of this thesis.

== Introduction
MPI @mpi41 is a message-passing library interface specification - essentially a
set of standard guidelines for both implementors and users of the parallel
programming model. In this programming paradigm, data traverses between the
address spaces of different processes through cooperative operations - what we
might call "hand-shakes" or "classical" message-passing techniques.

Beyond the classical model, MPI extends its capabilities by offering:
- Collective operations
- Remote-memory access operations
- Dynamic process creation
- Parallel I/O

Within this thesis, I will specifically dive deep into remote-memory access
operations in MPI, which form the critical building block for MPI's One-Sided
Communication, a concept first introduced in MPI-2 @mpi2, and later refined in MPI-3 @mpi3.

== One-Sided Communications
Unlike traditional "classical" Point-to-Point communication - where
communication is a two-way collaborative effort between processes, with one
sending and another receiving - Remote Memory Access introduces a more flexible
communication mechanism called One-Sided communication.

In this approach, a single MPI process can now independently orchestrate the
entire communication task, specifying communication parameters for both the
sending and receiving sides.

Regular send/receive communication requires a matching operations by sender and
receiver. And to issue the matching operations, the application needs to
distribute the transfer parameters. This may require all MPI processes to
participate in a global computation, or to explicitly poll for potential
communication requests to response periodically.

The use of RMA communication operations avoids the need for global computation
or explicit polling.

Message-passing in general achieves two effects: communication of data from
sender to receiver and synchronization of sender with receiver. RMA design
separates these two functions. Within MPI standards, the primitive communication
operations are as follows:

- Remote write operations: MPI_PUT, MPI_RPUT
- Remote read operations: MPI_GET, MPI_RGET
- Remote update operations: MPI_ACCUMULATE, MPI_RACCUMULATE
- Combined read and update operations: MPI_GET_ACCUMULATE, MPI_RGET_ACCUMULATE,
  and MPI_FETCH_AND_OP
- Remote atomic swap: MPI_COMPARE_AND_SWAP

== Memory Model
MPI supports two distinct memory models:

1. Separate Memory Model:
  - Highly portable
  - No inherent memory consistency assumptions
  - Similar to weakly coherent memory systems
  - Requires explicit synchronization for correct memory access ordering

2. Unified Memory Model:
  - Exploits cache-coherent hardware
  - Supports hardware-accelerated one-sided operations
  - Typically found in high-performance computing environments

The RMA design's flexibility allows implementors to leverage platform-specific
communication mechanisms, including:
- Coherent and non-coherent shared memory
- Direct Memory Access (DMA) engines
- Hardware-supported put/get operations
- Communication coprocessors

While most RMA communication mechanisms can be constructed atop message-passing
infrastructure, certain advanced RMA functions might necessitate support from
asynchronous communication agents like software handlers or threads in
distributed memory environments.

Terminology clarification:
- Origin (or origin process): The MPI process initiating the RMA procedure
- Target (or target process): The MPI process whose memory is being accessed

In a put operation: source = origin, destination = target

In a get operation: source = target, destination = origin
