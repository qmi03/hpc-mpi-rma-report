#let m = yaml("/metadata.yml")

= Motivation
Applications of high performance computing has gained tremendous popularity due
to its applications in everything science, from application like simulations of
particle movement in physics, weather prediction, and it has gained tremendos
popularity with the booming of Large Language Models, with the rising demands of
distributed machine learning where the models is trained on an enormous dataset.
These applications require a tremendous effort of communicating and
synchronizing.

One of the basic building block that is widely used by these applications are
the barrier algorithms, these algorithms aim to synchronize computation to a
point to exchange data between computation nodes.

These barrier algorithms are built upon many programming model. Recently, a new
model has gained a lot of attention, it is the hybrid programming model between
MPI and C++11. Specifically, it is a crossover between MPI's power of
communicating and synchronizing across different computation nodes of MPI; and
C++'s power of communicating and synchronizing within one computation node.

A recent 
= Goal
