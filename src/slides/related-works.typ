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
