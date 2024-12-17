= Conclusions and Future Works

== Accomplishments This Semester
Within the confines of this semester, I have:
- Studied and familiarized myself with MPI and its One-Sided Communication
  techniques
- Explored C++11 threading and concurrency features
- Conducted in-depth research on barrier synchronization algorithms for shared
  memory models
- Successfully implemented the two-process Brooks barrier algorithm utilizing
  MPI's Remote Memory Access (RMA) Operations

== Planned Research Trajectory
For the upcoming semester, my research will focus on:
- Extending barrier algorithm implementations using MPI's RMA Operations and
  One-Sided Communication techniques
- Implements barrier algorithm on C++ shared memory model
- Implement C++ and MPI Hybrid model
- Comprehensive testing of proposed algorithms on existing computational clusters
- Rigorous performance benchmarking to identify and select optimal barrier
  synchronization strategies
- Potential integration and contribution to existing applications

== Gantt chart timeline
#import "@preview/timeliney:0.0.1"

#figure(
  caption: [Gantt chart timeline], timeliney.timeline(
    show-grid: true, {
      import timeliney: *

      // Header for months
      headerline(
        group(([*January*], 4)), group(([*February*], 4)), group(([*March*], 4)), group(([*April*], 4)),
      )
      headerline(
        group(..range(4).map(n => strong("" + str(n + 1)))), group(..range(4).map(n => strong("" + str(n + 1)))), group(..range(4).map(n => strong("" + str(n + 1)))), group(..range(4).map(n => strong("" + str(n + 1)))),
      )
      taskgroup(
        title: [*Barrier Implementation*], {
          task("Research and Design", (0, 1), style: (stroke: 2pt + green))
          task(
            "Brook Dissemination & Tournament", (1, 3), style: (stroke: 2pt + green),
          )
          task("Tree Based", (3, 4), style: (stroke: 2pt + green))
          task("Other barrier algorithms", (4, 5), style: (stroke: 2pt + green))
        },
      )

      taskgroup(title: [*C++11 and MPI Hybrid model*], {
        task("Research and Design", (4, 5), style: (stroke: 2pt + green))
        task("Implementation", (6, 8), style: (stroke: 2pt + green))
      })
      taskgroup(
        title: [*Testing and Benchmarking*], {
          task("Cluster Testing Setup", (8, 9), style: (stroke: 2pt + green))
          task("Performance Benchmarking", (9, 11), style: (stroke: 2pt + green))
        },
      )

      taskgroup(
        title: [*Documentation and Integration*], {
          task("Algorithm Comparison", (11, 12), style: (stroke: 2pt + green))
          task("Report Writing", (12, 13), style: (stroke: 2pt + green))
          task(
            "MPI Library Contribution Preparation", (13, 15), style: (stroke: 2pt + green),
          )
        },
      )

      // Milestones
      milestone(at: 8, style: (stroke: (dash: "dashed")), align(center, [
        *Implementation*\
      ]))

      milestone(at: 11, style: (stroke: (dash: "dashed")), align(center, [
        *Testing*\
      ]))
    },
  ),
)
