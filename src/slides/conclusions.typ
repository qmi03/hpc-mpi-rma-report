= Conclusions
== Accomplishments
- Studied and familiarized myself with MPI and its One-Sided Communication techniques
- Explored C++11 threading and concurrency features
- Successfully implemented the two-process Brooks barrier algorithm utilizing
  MPI's Remote Memory Access (RMA) Operations
== Challenges and Learnings
=== Initial Challenges:
- Faced a steep learning curve with parallel programming concepts.
- Extensive effort required to comprehend the MPI standard documentation and its historical context.
=== Key Learnings:
- Gained a robust understanding of memory models and synchronization techniques.
- Developed insight into one-sided communication mechanics in MPI.
=== Adaptation Effort:
- Adapting Brook’s barrier algorithm to distributed memory was straightforward but required a comprehensive system understanding.
=== Outcomes:
- Established a solid foundation in distributed memory systems and synchronization strategies.
- Successfully adapted the two-process barrier algorithm to distributed memory.
- Future Opportunities:
- Yet to implement a fully functional barrier algorithm for hybrid memory models.
-	Room for further exploration and development in this domain.
== Future Works
=== Plan
- Understanding of C++ and MPI Memory model to implement C++ and MPI Hybrid model
- Adapting and Implementing barrier algorithms using MPI's One-Sided Communication
- Testing of proposed algorithms on existing clusters
- Performance benchmarking

---

#import "@preview/timeliney:0.0.1"

#block(height: 50%)[
  #figure([
    #timeliney.timeline(
      show-grid: true,
      spacing: 4.2pt,
      {
        import timeliney: *

        // Header for months
        headerline(
          group(([*January*], 4)),
          group(([*February*], 4)),
          group(([*March*], 4)),
          group(([*April*], 4)),
        )
        headerline(
          group(..range(4).map(n => strong("" + str(n + 1)))),
          group(..range(4).map(n => strong("" + str(n + 1)))),
          group(..range(4).map(n => strong("" + str(n + 1)))),
          group(..range(4).map(n => strong("" + str(n + 1)))),
        )
        taskgroup(
          title: [*Barrier Implementation*],
          {
            task("Research and Design", (0, 1), style: (stroke: 2pt + green))
            task(
              "Brook Dissemination & Tournament",
              (1, 3),
              style: (stroke: 2pt + green),
            )
            task("Tree Based", (3, 4), style: (stroke: 2pt + green))
            task("Other barrier algorithms", (4, 5), style: (stroke: 2pt + green))
          },
        )

        taskgroup(
          title: [*C++11 and MPI Hybrid model*],
          {
            task("Research and Design", (4, 5), style: (stroke: 2pt + green))
            task("Implementation", (6, 8), style: (stroke: 2pt + green))
          },
        )
        taskgroup(
          title: [*Testing and Benchmarking*],
          {
            task("Cluster Testing Setup", (8, 9), style: (stroke: 2pt + green))
            task("Performance Benchmarking", (9, 11), style: (stroke: 2pt + green))
          },
        )

        taskgroup(
          title: [*Documentation and Integration*],
          {
            task("Algorithm Comparison", (11, 12), style: (stroke: 2pt + green))
            task("Report Writing", (12, 13), style: (stroke: 2pt + green))
            task(
              "MPI Library Contribution Preparation",
              (13, 15),
              style: (stroke: 2pt + green),
            )
          },
        )

        // Milestones
        milestone(
          at: 8,
          style: (stroke: (dash: "dashed")),
          align(
            center,
            [
              *Implementation*\
            ],
          ),
        )

        milestone(
          at: 11,
          style: (stroke: (dash: "dashed")),
          align(
            center,
            [
              *Testing*\
            ],
          ),
        )
      },
    )
  ])
]
---
