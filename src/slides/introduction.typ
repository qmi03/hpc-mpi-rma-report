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
