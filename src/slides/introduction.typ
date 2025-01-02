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
  image("/static/images/Moore.png", height: 80%),
  caption: [Moore's Law @moores-law-graph],
)
#figure(
  image("/static/images/HPCCluster.JPG", width: 50%),
  caption: [Multiple Computing Nodes connect to each other to form a HPC Cluster @hpc-cluster],
)
- Nodes are connected via a very fast network (Infiniband, Ethernet, etc.)
---
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
---
=== The Paper
- Quaranta et al @quaranta-mpi proposed to combine MPI-3 and C++11 (hybrid model)
- Only implements a simple barrier algorithm using the hybrid model
#sym.arrow Implement and benchmark more complex barrier algorithms using the hybrid model

---
== Objectives
- Survey existing barrier synchronization algorithms
- Implements variants of barrier synchronization algorithms in the hybrid programming model.
- *Compare the performance of the implemented barrier algorithms with existing
  algorithms.*
- Propose methods to deploy selected barrier algorithms on the current HPC system.

---
== Scope
- Explore key concepts in high-performance computing (HPC).
- Study MPI-3 and its programming model.
- Investigate C++11 threading and concurrency features.
- Research the hybrid programming model combining MPI-3 and C++11.
- Survey existing barrier synchronization algorithms.
- Implement a simple barrier synchronization algorithm with the hybrid model.

