#let m = yaml("/metadata.yml")

= Motivation
Applications of high-performance computing have gained tremendous popularity due
to its applications in various scientific domains, from simulations of particle
movement in physics, weather prediction, and it has gained tremendous popularity
with the booming of Large Language Models, with the rising demands of
distributed machine learning where the models are trained on enormous datasets.

These applications require tremendous effort in communication and
synchronization. One of the basic building blocks that are widely used by these
applications are the barrier algorithms, which aim to synchronize computation to
a point to exchange data between computation nodes.

These barrier algorithms are built upon many programming models. Recently, a new
model has gained a lot of attention: a hybrid programming model between MPI and
C++11. Specifically, it is a crossover between MPI's power of communicating and
synchronizing across different computation nodes, and C++'s power of
communicating and synchronizing within one computation node.

A recent research by Quaranta et al. @quaranta-mpi has shown the potential of
this programming model in terms of performance through a newly proposed barrier
algorithm. However, they have ignored a large number of existing barrier
algorithms that have been designed for similar programming models.

Hence, the goal of this thesis is to research and develop distributed barrier
synchronization algorithms using the hybrid programming model.
