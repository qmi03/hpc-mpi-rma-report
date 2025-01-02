= Related Works
== The Paper
- Quaranta et al @quaranta-mpi proposed a hybrid model of MPI-3 and C++11
- Showed potential of combining MPI-3 and C++11 for a synchronization implementation
- Potential reduction in communication overhead
== Barrier Algorithm Selection
#grid(
  columns: 2,
  align: (left + horizon, center + horizon),
  [
    2 schools of thoughts:
    - Linear
    - Butterfly
  ],
  figure(
    grid(
      rows: 2,
      image("/static/images/linear.png", width: 60%),
      image("/static/images/butterfly-barrier.png", width: 60%),
    ),
    caption: [Barrier Algorithm Selection],
  ),
)
---
