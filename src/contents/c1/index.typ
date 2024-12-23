#import "/macros.typ": bao
= Introduction

In Chapter 1, I introduce the project's research focus on distributed barrier
synchronization algorithms in high-performance computing. Section 1.1 #bao[should use some commands function in the same way as \ref{} in latex] explores
the motivation behind the research, highlighting the growing importance of
high-performance computing across scientific domains, including large language
model training and complex simulations. #bao[Particularly], the section emphasizes the critical role
of barrier algorithms in synchronizing computational processes across different
nodes.

Section 1.2 details the thesis objectives, which encompass a comprehensive
exploration of high-performance computing concepts, including MPI-4.1 and C++11
threading technologies. The research aims to investigate a hybrid programming
model that combines the communication strengths of MPI with the synchronization
capabilities of C++11. The objectives include surveying existing barrier
synchronization algorithms and proposing methods for their deployment on current
high-performance computing systems.

The thesis proposal structure, outlined in Section 1.3, provides a clear roadmap for the
research. The document is organized into six chapters, progressing from
foundational concepts to detailed algorithm proposals, experimental results, and
future research directions. Each chapter builds upon the previous one, creating
a comprehensive narrative of the research journey from introduction to
conclusion.

#set heading(offset: 1)
#{ include "./motivation.typ" }
#{ include "./objective.typ" }
#{ include "./thesis_structure.typ" }
