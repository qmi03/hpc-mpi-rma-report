= Motivation <motivation>
Applications of high-performance computing have gained immense popularity due to
its applications in various scientific domains, from simulations of particle
movement in physics @hpc-applications, weather prediction , and it has also
gained tremendous popularity with the booming of Large Language Models (LLMs),
with the rising demands of distributed machine learning where the models are
trained on enormous datasets.

These applications require tremendous effort in communication and
synchronization. One of the basic building blocks that is widely used by these
applications is the barrier algorithm, which aims to synchronize computation to
a point to exchange data between compute nodes.

These barrier algorithms are built upon many programming models. Recently, a new
model has gained a lot of attention: a hybrid programming model between MPI and
C++11. Specifically, it is a crossover between MPI's power of communicating and
synchronizing across different compute nodes, and C++'s power of
communicating and synchronizing within one compute node.

A recent research by Quaranta and Maddegedara @quaranta-mpi has shown the
potential of this programming model in terms of performance through a newly
proposed barrier algorithm. However, they have ignored a large number of
existing barrier algorithms that have been designed for similar programming
models. @herlihy2020art
