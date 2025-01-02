= Preliminary Results <results>
This chapter showcases the preliminary test result of the Brook's two-process
barrier algorithm using MPI's RMA operations.
#pagebreak()

== Test Environment
- Hardware: Apple M1 chip
- Compiler: MPICH's mpic++ compiler
- MPI Implementation: MPICH
- Compilation flags: -std=c++11
- Operating System: macOS

== Test Implementation
The test program was designed to verify the basic functionality of the barrier
synchronization:

#figure([
```cpp
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
], caption: [Main function to test brook_2\_proc function])

== Compilation and Execution
The program was compiled using the following command:
```bash
mpic++ -std=c++11 src/brook.cpp -o brook
```

Execution was performed using MPICH's mpirun with two processes:
```bash
mpirun -np 2 ./brook
```

== Results
The test results demonstrated successful barrier synchronization between two
processes:

#figure(image("/static/res.png"), caption: [Test results on Apple M1])
