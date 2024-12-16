= Message Passing Interface (MPI)
== MPI
MPI is a message-passing library interface specification, as in it's primarily a
standard and guidelines for implementors and users for the message-passing
parallel programming model. In this type of programming model, data can be moved
from the address space of one process to that of another process through
cooperative operatioins on each process, or the so called "hand-shakes", or "classical"
message-passing.

MPI also provide an extension to the "classical" message-passing model in the
form of collective operations, remote-memory access operations, dynamic process
creation, and parallel I/O.

In this thesis, we will specifically deep dive into remote-memory access
operations within MPI, or so called One Sided Communication, introduced in MPI-2

== One-Sided Communications

