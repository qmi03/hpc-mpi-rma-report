= Background
== Barrier Algorithm
#grid(
  columns: 2,
  gutter: 16pt,
  align: (center, right),
  [#text(weight: "bold", size: 30pt)[What is a Barrier Algorithm?]],
  figure(
    block(image("/static/images/barrier.svg"), clip: true),
    caption: [Barrier Algorithm],
  ),
)
#image("/static/images/epoch.png")
== MPI-3
=== Message Passing Interface (MPI)
- MPI is a standard for message-passing between nodes in a distributed system
- MPI is optimized for communication between nodes
- Multiple implementations of MPI are available (OpenMPI, MPICH, MVAPICH, etc.)
- Multiple programming languages support MPI (C, Fortran, etc.)

---
#figure(
  image("/static/images/02-send-recv.png", width: 50%),
  caption: [Live program communicating with each other using MPI @intermediate-mpi],
)

---
#grid(
  columns: 3,
  rows: 2,
  gutter: 16pt,
  align: (center, center),
  text(weight: "bold")[Traditional Message Passing],
  figure(
    image("/static/images/E02-send-recv_step2.svg"),
    caption: [Point-to-point communication @intermediate-mpi],
  ),
  [
    - Point-to-point
    - Explicit send and receive
  ],

  text(weight: "bold")[One-sided Communication],
  figure(
    image("/static/images/E02-steve-alice_step2.svg"),
    caption: [One-sided Communication @intermediate-mpi],
  ),
  [
    - Remote Memory Access
    - Handshake is implicit
  ],
)

=== One-sided Communication
- Introduced in MPI-2
- Share mechanism:
  - Declare a window of memory to be shared
  - read/write without explicit send/receive
- Simple operations:
  - MPI_Put
  - MPI_Get
  - MPI_Accumulate
- Atomic operations:
  - MPI_Get_accumulate
  - MPI_Fetch_and_op
  - MPI_Compare_and_swap

=== New Features in MPI-3
#grid(
  columns: 2,
  rows: 2,
  gutter: 16pt,
  align: (center, center),
  text(weight: "bold")[Separate Memory],
  figure(
    image("/static/images/separate-memory.svg", width: 58%),
  ),

  text(weight: "bold")[Unified Memory],
  figure(
    image("/static/images/E02-steve-alice_step2.svg", width: 50%),
    caption: [One-sided Communication @intermediate-mpi],
  ),
)
=== C++11
Supports Multithreading 

#sym.arrow Allows Shared memory programming model instead of Distributed memory programming model

in the STL

#sym.arrow No reliance on 3rd party libraries for multithreading programming

#figure(
  image("/static/images/c-11.png", width: 50%),
  caption: [Features introduced in C++11 @cpp-cyberplusIndia],
)

---
