#import "@preview/lovelace:0.3.0": *
= Algorithm & Simple Implementaion
== Brook 2 process algorithm
- The basis of many butterfly barrier algorithms
- Barrier for 2 threads of execution
#pseudocode-list(
  booktabs: true,
  title: smallcaps[Brook-Barrier-Algorithm],
)[
  + *procedure* Brook's-Barrier(SetByMyProcess, SetByTargetProcess)
    + *while* SetByMyProcess *is* true *do* wait

    + SetByMyProcess ← true

    + *while* SetByTargetProcess *is* false *do* wait

    + SetByTargetProcess ← false

  + *end procedure*
]
#image("/static/images/epoch.png")
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
#let brook_algo_2_3 = grid(
  columns: (0.2fr, 1fr, 1fr), // Auto width for step numbers, equal width for processes
  gutter: 2pt, // Space between columns
  // Step numbers column
  rect[
    #set align(center)
    #strong([Step])


    *2*

    *3*

  ],
  // Process 1 column
  rect[
    #set align(center)
    #strong([Process 1])


    SetByProcess1 := true;

    while not SetByProcess2 do wait;

  ],
  // Process 2 column
  rect[
    #set align(center)
    #strong([Process 2])


    SetByProcess2 := true;

    while not SetByProcess1 do wait;

  ],
)
#brook_algo_2_3
#brook_algo
---
== Implementation using RMA Operation

#pseudocode-list(
  booktabs: true,
  title: smallcaps[Distributed-Mem-Brook-Barrier],
)[
  + *procedure* Brook's-Barrier(exposed_flag, win, target_rank)

    + *while* exposed_flag *is* true *do* wait \//step 1

    + exposed_flag ← true \//step 2

    + \//step 3
    + *while* target_flag *is* false *do* wait
      + MPI_WIN_LOCK(win)
      + MPI_GET_ACCUMULATE(&target_flag, 0, BOOL, &target_flag, 1, BOOL, target_rank, 0, 1, BOOL, MPI_NO_OP, win);
      + MPI_WIN_FLUSH(win)
      + MPI_WIN_UNLOCK(win)
    + *end while*

    + \//step 4

    + false_value ← false
    + MPI_WIN_LOCK(win)
    + MPI_ACCUMULATE(&false_value, 1, BOOL, target_rank, 0, 1, BOOL, MPI_REPLACE, win);
    + MPI_WIN_FLUSH(win)
    + MPI_WIN_UNLOCK(win)

  + *end procedure*
]
== Preliminary Result
=== Test Environment
- Hardware: Apple M1 chip
- Compiler: MPICH's mpic++ compiler
- MPI Implementation: MPICH
- Compilation flags: -std=c++11
- Operating System: macOS
```cpp
int main(int argc, char **argv) {
  // init the mpi world
  MPI_Init(&argc, &argv);
  MPI_Comm comm = MPI_COMM_WORLD;

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

  // set the target
  int target_rank = 1 - rank;

  // create a window
  bool exposed_bool{false};
  MPI_Win win_buffer_handler;
  MPI_Win_create(&exposed_bool, sizeof(bool), sizeof(bool), MPI_INFO_NULL, comm,
                 &win_buffer_handler);

  barrier_brook(exposed_bool, win_buffer_handler, target_rank);
  barrier_brook(exposed_bool, win_buffer_handler, target_rank);
  barrier_brook(exposed_bool, win_buffer_handler, target_rank);
  barrier_brook(exposed_bool, win_buffer_handler, target_rank);

  printf("Process %d: reached destination\n", rank);

  return MPI_Finalize();
}
```

=== Compilation and Execution
The program was compiled using the following command:
```bash
mpic++ -std=c++11 src/brook.cpp -o brook
```

Execution was performed using MPICH's mpirun with two processes:
```bash
mpirun -np 2 ./brook
```
