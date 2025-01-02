#{ include "./introduction.typ" }
#{ include "./background.typ" }
#{ include "./related-works.typ" }

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
