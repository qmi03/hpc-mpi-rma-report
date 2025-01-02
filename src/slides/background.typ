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
    image("/static/images/separate-memory.svg", width: 62%),
  ),

  text(weight: "bold")[Unified Memory],
  figure(
    image("/static/images/E02-steve-alice_step2.svg", width: 60%),
    caption: [One-sided Communication @intermediate-mpi],
  ),
)
== C++11
- Introduced in 2011
- Support for multithreading and parallel programming within a single node
- *atomic operations* are supported
- Can use *shared memory* to communicate instead of *message passing*
