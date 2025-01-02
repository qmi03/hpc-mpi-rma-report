= Algorithm <algorithm>
This chapter presents Brook's barrier algorithm within the context of the shared
memory model (@brook_algo).

@impl provides a straightforward implementation of Brook's two-process barrier
algorithm using MPI's Remote Memory Access (RMA) operations.

Finally, @commentary offers an in-depth analysis of my implementation,
highlighting its key components and comparing it to the shared memory model.

#pagebreak()
== Brook Algorithm <brook_algo>
Brook @butterfly-barrier bases the n-process barrier on a two-process barrier
using two shared variables. The algorithm is as follows:
#set rect(inset: 8pt, fill: rgb(white), width: 100%)

#grid(
  columns: (0.2fr, 1fr, 1fr), // Auto width for step numbers, equal width for processes
  gutter: 2pt, // Space between columns
  rows: auto, // Rows sized automatically to fit the content
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
// bo sung
== My proposed implementation of Brook's algorithm <impl>
We can extend the concept of Brooks’ two-process barrier, where two processes
share memory through shared variables, to the one-sided communication model.

In this model, one process can directly access the variables of another process.
Instead of storing the shared variables in a common memory segment, each process
maintains its own copy, allowing the other process to read and modify it using
one-sided communication primitives.

This is my simple implementation of Brook's two-process barrier technique
```cpp
#include "mpi.h"

int brook_2_proc(const MPI_Comm &comm) {
  // Get number of ranks and current rank
  int n_ranks, rank;
  MPI_Comm_size(comm, &n_ranks);
  MPI_Comm_rank(comm, &rank);

  // Ensure exactly 2 processes are used
  if (n_ranks != 2) {
    if (rank == 0) {
      fprintf(stderr, "This program requires exactly 2 processes.\n");
    }
    MPI_Abort(comm, 1);
  }

  // Initialize shared window
  bool exposed_buffer{false};
  MPI_Win win_buffer_handler;
  MPI_Win_create(&exposed_buffer, sizeof(bool), sizeof(bool),
                 MPI_INFO_NULL, comm, &win_buffer_handler);

  // Barrier synchronization
  // Step 1: Wait for my exposed buffer to be reset
  while (exposed_buffer) {
    // Busy-waiting loop
  }

  // Step 2: Set my exposed buffer to true
  exposed_buffer = true;

  // Step 3: Wait for the other process's exposed buffer to be true
  bool flag_from_other_process{false};
  int target_rank = 1 - rank;
  while (!flag_from_other_process) {
    MPI_Win_lock_all(0, win_buffer_handler);
    MPI_Get_accumulate(&flag_from_other_process, 0, MPI_CXX_BOOL,
                       &flag_from_other_process, 1, MPI_CXX_BOOL,
                       target_rank, 0, 1, MPI_CXX_BOOL,
                       MPI_NO_OP, win_buffer_handler);
    MPI_Win_flush_all(win_buffer_handler);
    MPI_Win_unlock_all(win_buffer_handler);
  }

  // Step 4: Reset the other process's exposed buffer
  bool false_value{false};
  MPI_Win_lock_all(0, win_buffer_handler);
  MPI_Accumulate(&false_value, 1, MPI_CXX_BOOL,
                 target_rank, 0, 1, MPI_CXX_BOOL,
                 MPI_REPLACE, win_buffer_handler);
  MPI_Win_flush(target_rank, win_buffer_handler);
  MPI_Win_unlock_all(win_buffer_handler);

  // Cleanup
  return MPI_Win_free(&win_buffer_handler);
}
```
#figure(
  [], caption: [My implementation of Brook's two-process barrier using MPI primitives], kind: raw,
)

== Commentary on Implementation <commentary>
We analyze the implementation step by step, comparing it with Brook's shared
memory model:

=== Memory Setup
In Brook's shared memory model:
- Two variables are shared between processes
- Both processes can directly access these variables
- No explicit initialization needed beyond variable declaration

In my MPI implementation:
- Each process owns a local buffer (`exposed_buffer`)
- MPI Window creation establishes remote memory access capability
- Explicit initialization required through `MPI_Win_create`

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
Key differences:
- Uses `MPI_Get_accumulate` instead of simple `MPI_Get` to ensure atomic
  operations
- The operation is atomic, preventing potential race conditions
- Requires explicit synchronization through window locks and flushes
- More complex due to RMA operation setup and synchronization

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
Key differences:
- Uses `MPI_Accumulate` instead of `MPI_Put` for atomic operation
- Requires explicit synchronization similar to Step 3
- More complex due to RMA operation requirements

=== Use of Atomic Operations
The implementation uses `MPI_Get_accumulate` and `MPI_Accumulate` instead of `MPI_Get` and `MPI_Put` for
two critical reasons:

1. Atomicity Guarantee:
  - These operations are guaranteed to be atomic by the MPI specification
  - Prevents race conditions when multiple processes access the same memory location
  - Ensures consistency of memory operations

2. Memory Ordering:
  - Atomic operations provide stronger memory ordering guarantees
  - Help maintain the happens-before relationship between operations
  - Essential for correct barrier synchronization behavior
