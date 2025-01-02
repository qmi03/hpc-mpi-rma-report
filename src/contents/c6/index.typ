= Conclusions and Future Works <conclusions>
This chapter presents the accomplishments and future direction of the research.

@accomplishments highlights the progress made this semester, including the
implementation of Brook's two-process barrier algorithm using MPI's RMA
operations.

@future_works outlines the planned research trajectory, focusing on further
algorithm development, benchmarking, and integration into larger systems. This
chapter concludes with a Gantt chart timeline illustrating the key milestones
and activities for the upcoming semester.
#pagebreak()

== Accomplishments This Semester <accomplishments>
Within the confines of this semester, I have:
- Studied and familiarized myself with MPI and its One-Sided Communication
  techniques
- Explored C++11 threading and concurrency features
- Successfully implemented the two-process Brooks barrier algorithm utilizing
  MPI's Remote Memory Access (RMA) Operations

== Planned Research Trajectory <future_works>
For the upcoming semester, my research will focus on:
- Understanding of C++ and MPI Memory model to implement C++ and MPI Hybrid model
- Extending barrier algorithm implementations using MPI's RMA Operations and
  One-Sided Communication techniques
- Implement barrier algorithm on C++ shared memory model
- Testing of proposed algorithms on existing clusters
- Performance benchmarking to identify and select optimal barrier synchronization
  strategies
- Integration and contribution to existing applications

#import "@preview/timeliney:0.0.1"

#figure(
  kind: image,
  caption: [Gantt chart timeline.],
  timeliney.timeline(
    show-grid: true,
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
  ),
)
