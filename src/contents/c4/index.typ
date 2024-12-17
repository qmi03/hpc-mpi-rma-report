= Algorithm
== Brook Algorithm
Brooks @butterfly-barrier bases the n-process barrier on a two-process barrier
using two shared variables. Its algorithm is as follows:
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
We can extend the concept of Brooks’ two-process barrier, where two processes
share memory through shared variables, to a one-sided communication model.

In this model, one process can directly access the variables of another process.
Instead of storing the shared variables in a common memory segment, each process
maintains its own copy, allowing the other process to read and modify it using
one-sided communication primitives.

This is my simple implementation of Brook's two-process barrier technique
```cpp
#include "mpi.h"
#include "mpi_proto.h"
#include <cstdio>
#include <stdio.h>

int brook_2_proc(const MPI_Comm &comm) {
  // get number of ranks
  int n_ranks;
  MPI_Comm_size(comm, &n_ranks);
  // get current rank
  int rank;
  MPI_Comm_rank(comm, &rank);

  if (n_ranks != 2) {
    if (rank == 0) {
      fprintf(stderr, "This program requires exactly 2 processes.\n");
    }
    MPI_Abort(comm, 1);
  }
  bool exposed_buffer{false};
  bool false_value = false;
  bool true_value = true;
  MPI_Win win_buffer_handler;
  MPI_Win_create(&exposed_buffer, sizeof(bool), sizeof(bool), MPI_INFO_NULL,
                 comm, &win_buffer_handler);
  // barrier
  // step 1: wait for other process to set my exposed buffer to false
  while (exposed_buffer) {
    // busy waiting
  }

  // step 2: set my exposed buffer to true
  // set my exposed buffer to true
  exposed_buffer = true;

  // step 3: wait for the other process to set their exposed buffer to true
  bool flag_from_other_process = false;
  int target_rank = 1 - rank;
  while (!flag_from_other_process) {
    // get exposed buffer from the other process
    MPI_Win_lock_all(0, win_buffer_handler);
    MPI_Get(&flag_from_other_process, 1, MPI_CXX_BOOL, target_rank, 0, 1,
            MPI_CXX_BOOL, win_buffer_handler);
    MPI_Win_flush_all(win_buffer_handler);
    MPI_Win_unlock_all(win_buffer_handler);
  }

  // step 4: set their exposed buffer to false
  MPI_Win_lock_all(0, win_buffer_handler);
  MPI_Put(&false_value, 1, MPI_CXX_BOOL, target_rank, 0, 1, MPI_CXX_BOOL,
          win_buffer_handler);
  MPI_Win_flush(target_rank, win_buffer_handler);
  MPI_Win_unlock_all(win_buffer_handler);
  // end barrier
  return MPI_Win_free(&win_buffer_handler);
};

int main(int argc, char **argv) {
  // init the mpi world
  MPI_Init(&argc, &argv);
  MPI_Comm comm = MPI_COMM_WORLD;
  int rank;
  MPI_Comm_rank(comm, &rank);

  brook_2_proc(comm);

  printf("Process %d: reached destination\n", rank);

  return MPI_Finalize();
}
```
