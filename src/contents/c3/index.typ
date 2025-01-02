#import "/macros.typ": cxx
= Related Works <related-works>
This section examines two key areas relevant to my implementation: barrier
synchronization algorithms and hybrid parallelization approaches.

@barrier-algos
review MellorCrummey's foundational work on barrier algorithms, which provides
crucial insights into synchronization strategies for different multiprocessor
architectures.

@hybrid explore recent advances in hybrid parallelization, particularly Quaranta
and Maddegedara's novel approach combining MPI-3 shared memory windows with the
C++11 memory model.

Based on these works, @design-decision formulate the implementation strategy
that leverages both efficient barrier synchronization and modern memory model
capabilities.

#pagebreak()

#set heading(offset: 1)

#{ include "./barrier_algos.typ" }
#{ include "./hybrid.typ" }

#set heading(offset: 0)
== Design Decisions <design-decision>
From these works, my proposal for a barrier algorithm within a compute node
like C++ will use the broadcast-based cache-coherent multiprocessors method. For
inter-core communication, I will implement the second approach. This choice
aligns with the expectation that modern multi-core processors typically maintain
cache coherence. The implementation will also consider the synchronization
techniques demonstrated by Quaranta and Maddegedara, particularly their use of
C++11 atomic operations for fine-grained control.
