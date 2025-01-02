= Introduction
== Motivation
=== HPC and its Applications
#grid(
  columns: 2,
  gutter: 16pt,
  figure(
    image("/static/images/Map.png"),
    caption: [Weather Simulation @nasa-weather],
  ),
  figure(
    image("/static/images/distributedML.png"),
    caption: [Distributed Machine Learning @verbraeken-2020],
  ),
)

#figure(
  image("/static/images/Moore.png", height: 90%),
  caption: [Moore's Law @moores-law-graph],
)
#figure(
  image("/static/images/HPCCluster.JPG", width: 50%),
  caption: [Multiple Computing Nodes connect to each other to form a HPC Cluster @hpc-cluster],
)
- Nodes are connected via a very fast network (Infiniband, Ethernet, etc.)
---
=== Message Passing Interface (MPI)
- MPI is a standard for message-passing between nodes in a distributed system
- MPI is optimized for communication between nodes
- Multiple implementations of MPI are available (OpenMPI, MPICH, MVAPICH, etc.)
- Multiple programming languages support MPI (C, Fortran, etc.)
#figure(
  image("/static/images/02-send-recv.png", width: 50%),
  caption: [Live program communicating with each other using MPI @intermediate-mpi],
)

---
=== C++11
- C++11 is a standard for the C++ programming language released in 2011
- C++11 provides support for multithreading and parallel programming
//- Historically, we have to rely on 3rd party libraries like \<pthread> and Windows API to support multithreading in C++
- C++11 provides native support for multithreading
#figure(
  image("/static/images/c-11.png", width: 45%),
  caption: [Features introduced in C++11 @cpp-cyberplusIndia],
)
=== The Paper
- Quaranta et al @quaranta-mpi proposed to combine MPI-3 and C++11 (hybrid model)
- Only implements a simple barrier algorithm using the hybrid model
#sym.arrow Implement and benchmark more complex barrier algorithms using the hybrid model

== Objectives
- Explore key concepts in high-performance computing (HPC) #sym.checkmark
- Research and familiarize with the MPI-3 and C++11 programming model #sym.checkmark
- Research how to combine MPI-3 and C++11 for a hybrid programming model #sym.checkmark
- Research about many barrier algorithms #sym.checkmark
- Implement a simple barrier algorithm using MPI-3 #sym.checkmark

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

= Related Works
== The MPI-3 C++11 Paper
- Quaranta et al @quaranta-mpi proposed a hybrid model of MPI-3 and C++11
- Showed potential of combining MPI-3 and C++11 for a synchronization implementation
- Potential reduction in communication overhead
== Barrier Algorithm Selection
#grid(
  columns: 2,
  align: (left + horizon, center + horizon),
  [
    3 school of thoughts:
    - Linear
    - Tree-based
    - Butterfly
  ],
  figure(
    grid(
      rows: 3,
      image("/static/images/linear.png", width: 60%),
      image("/static/images/tree.png", width: 60%),
      image("/static/images/butterfly-barrier.png", width: 60%),
    ),
    caption: [Barrier Algorithm Selection],
  ),
)
---
= Algorithm & Simple Implementaion
== Brook 2 process algorithm
- The basis of many butterfly barrier algorithms
- Barrier for 2 threads of execution
---
#let brook_algo = grid(
  columns: (0.2fr, 1fr, 1fr), // Auto width for step numbers, equal width for processes
  gutter: 2pt, // Space between columns
  // Step numbers column
  rect[
    #set align(center)
    #strong([Step])

    *1*

    *2*

    *3*

    *4*
  ],
  // Process 1 column
  rect[
    #set align(center)
    #strong([Process 1])

    while SetByProcess1 do wait;

    SetByProcess1 := true;

    while not SetByProcess2 do wait;

    SetByProcess2 := false;
  ],
  // Process 2 column
  rect[
    #set align(center)
    #strong([Process 2])

    while SetByProcess2 do wait;

    SetByProcess2 := true;

    while not SetByProcess1 do wait;

    SetByProcess1 := false;
  ],
)
#brook_algo
---
== Implementation using RMA Operation

=== Memory Setup
In Brook's shared memory model:
- Two variables are shared between processes
- Both processes can directly access these variables
- No explicit initialization needed beyond variable declaration

In my MPI implementation:
- Each process owns a local buffer (`exposed_buffer`)
- MPI Window creation establishes remote memory access capability
- Explicit initialization required through `MPI_Win_create`

---
=== Step 1: Wait for Reset
Brook's model:
```cpp
while SetByProcess1 do wait;  // Direct memory access
```
My implementation:
```cpp
while (exposed_buffer) {
    // Busy-waiting loop
}
```
The implementation directly checks the local buffer since each process owns its
buffer. This is simpler than Brook's model as we're checking local memory.
---
=== Step 2: Set Flag
Brook's model:
```cpp
SetByProcess1 := true;  // Direct shared memory write
```
My implementation:
```cpp
exposed_buffer = true;  // Local memory write
```
Similar to Step 1, we're working with local memory, making this operation
straightforward.

---
=== Step 3: Wait for Other Process
Brook's model:
```cpp
while not SetByProcess2 do wait;  // Direct memory read
```
My implementation:
```cpp
while (!flag_from_other_process) {
    MPI_Win_lock_all(0, win_buffer_handler);
    MPI_Get_accumulate(&flag_from_other_process, 0, MPI_CXX_BOOL,
                       &flag_from_other_process, 1, MPI_CXX_BOOL,
                       target_rank, 0, 1, MPI_CXX_BOOL,
                       MPI_NO_OP, win_buffer_handler);
    MPI_Win_flush_all(win_buffer_handler);
    MPI_Win_unlock_all(win_buffer_handler);
}
```

---
=== Step 4: Reset Other's Flag
Brook's model:
```cpp
SetByProcess2 := false;  // Direct shared memory write
```
My implementation:
```cpp
bool false_value{false};
MPI_Win_lock_all(0, win_buffer_handler);
MPI_Accumulate(&false_value, 1, MPI_CXX_BOOL,
               target_rank, 0, 1, MPI_CXX_BOOL,
               MPI_REPLACE, win_buffer_handler);
MPI_Win_flush(target_rank, win_buffer_handler);
MPI_Win_unlock_all(win_buffer_handler);
```
== Preliminary Result
=== Test Environment
- Hardware: Apple M1 chip
- Compiler: MPICH's mpic++ compiler
- MPI Implementation: MPICH
- Compilation flags: -std=c++11
- Operating System: macOS
#figure(
  [
    ```cpp
    int main(int argc, char **argv) {
      // init the mpi world
      MPI_Init(&argc, &argv);
      MPI_Comm comm = MPI_COMM_WORLD;
      int rank;
      MPI_Comm_rank(comm, &rank);

      brook_2_proc(comm);
      brook_2_proc(comm);
      brook_2_proc(comm);

      printf("Process %d: reached destination\n", rank);
      return MPI_Finalize();
    }
    ```
  ],
  caption: [Main function to test brook_2\_proc function],
)

=== Compilation and Execution
The program was compiled using the following command:
```bash
mpic++ -std=c++11 src/brook.cpp -o brook
```

Execution was performed using MPICH's mpirun with two processes:
```bash
mpirun -np 2 ./brook
```
= Conclusions
== Accomplishments
- Explore key concepts in high-performance computing (HPC) #sym.checkmark
- Research and familiarize with the MPI-3 and C++11 programming model #sym.checkmark
- Research how to combine MPI-3 and C++11 for a hybrid programming model #sym.checkmark
- Research about many barrier algorithms #sym.checkmark
- Implement a simple barrier algorithm using MPI-3 #sym.checkmark
== Future Works
=== Plan
- Research C++ and MPI Hybrid model
- Implement more algorithms
- Implement barrier algorithms on C++ shared memory model
- Testing of proposed algorithms on existing computational clusters
- Performance benchmarking to identify and select optimal barrier synchronization
  strategies
- Integration and contribution to existing applications

---

#import "@preview/timeliney:0.0.1"

#block(height: 50%)[
  #figure([
    #timeliney.timeline(
      show-grid: true,
      spacing: 4.2pt,
      {
        import timeliney: *

        // Header for months
        headerline(
          group(([*January*], 4)),
          group(([*February*], 4)),
          group(([*March*], 4)),
          group(([*April*], 4)),
        )
        headerline(
          group(..range(4).map(n => strong("" + str(n + 1)))),
          group(..range(4).map(n => strong("" + str(n + 1)))),
          group(..range(4).map(n => strong("" + str(n + 1)))),
          group(..range(4).map(n => strong("" + str(n + 1)))),
        )
        taskgroup(
          title: [*Barrier Implementation*],
          {
            task("Research and Design", (0, 1), style: (stroke: 2pt + green))
            task(
              "Brook Dissemination & Tournament",
              (1, 3),
              style: (stroke: 2pt + green),
            )
            task("Tree Based", (3, 4), style: (stroke: 2pt + green))
            task("Other barrier algorithms", (4, 5), style: (stroke: 2pt + green))
          },
        )

        taskgroup(
          title: [*C++11 and MPI Hybrid model*],
          {
            task("Research and Design", (4, 5), style: (stroke: 2pt + green))
            task("Implementation", (6, 8), style: (stroke: 2pt + green))
          },
        )
        taskgroup(
          title: [*Testing and Benchmarking*],
          {
            task("Cluster Testing Setup", (8, 9), style: (stroke: 2pt + green))
            task("Performance Benchmarking", (9, 11), style: (stroke: 2pt + green))
          },
        )

        taskgroup(
          title: [*Documentation and Integration*],
          {
            task("Algorithm Comparison", (11, 12), style: (stroke: 2pt + green))
            task("Report Writing", (12, 13), style: (stroke: 2pt + green))
            task(
              "MPI Library Contribution Preparation",
              (13, 15),
              style: (stroke: 2pt + green),
            )
          },
        )

        // Milestones
        milestone(
          at: 8,
          style: (stroke: (dash: "dashed")),
          align(
            center,
            [
              *Implementation*\
            ],
          ),
        )

        milestone(
          at: 11,
          style: (stroke: (dash: "dashed")),
          align(
            center,
            [
              *Testing*\
            ],
          ),
        )
      },
    )
  ])
]
---
