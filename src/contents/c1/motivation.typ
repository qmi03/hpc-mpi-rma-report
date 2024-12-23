#import "/macros.typ": bao

= Motivation
Applications of high-performance computing have gained tremendous popularity due
to its applications in various scientific domains, from simulations of particle
movement in physics #bao[citation?] , weather prediction #bao[citation?], and it has gained tremendous popularity
with the booming of Large Language Models #bao[LLMs], with the rising demands of
distributed machine learning where the models are trained on enormous datasets.
#bao[it is not clear why LLMs need to be trained on large scale data. It is nice to
discuss recent studies about neural scaling law found in LLMs and Computer Vision (CV)
here. Find key words "Neural Scaling Laws for LLM, CV, GNN, TGNN, etc. The main 
idea of these works is to highlight the more training data => better performance of the models.
However, training large scale of data is exponentially expensive regard of time complexity,
which stresses the need to perform training in parallel.]

These applications require tremendous #bao[repeated word] effort in communication and
synchronization. One of the basic building blocks that is widely used by these
applications is the barrier algorithm, which aims to synchronize computation to a
point to exchange data between computation nodes.

These barrier algorithms are built upon many programming models. Recently, a new
model has gained a lot of attention: a hybrid programming model between MPI and
C++11. Specifically, it is a crossover between MPI's power of communicating and
synchronizing across different computation nodes, and C++'s power of
communicating and synchronizing within one computation node.

A recent research by Quaranta et al. @quaranta-mpi has shown the potential of
this programming model in terms of performance through a newly proposed barrier
algorithm. However, they have ignored a large number of existing barrier
algorithms that have been designed for similar programming models.
@herlihy2020art
