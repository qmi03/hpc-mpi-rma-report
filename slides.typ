#import "@preview/touying:0.5.5": *
#import themes.stargazer: *
#import "@preview/numbly:0.1.0": numbly

#show: magic.bibliography-as-footnote.with(bibliography("/bibliography.yml", title: none))
#let g = yaml("/globals.yml")
#set text(font: g.at("fonts-slide").at("serif"))
#set heading(numbering: numbly("{1}.", default: "1.1"))
#show: stargazer-theme.with(
  aspect-ratio: "16-9",
  config-colors(
    primary: rgb("#008BDD"),
    primary-dark: rgb("#004078"),
    secondary: rgb("#ffffff"),
    tertiary: rgb("#005bac"),
    neutral-lightest: rgb("#ffffff"),
    neutral-darkest: rgb("#000000"),
  ),
  config-info(
    title: [#upper[#g.course.name report]],
    subtitle: [#upper[studying and developing: distributed barrier algorithms using the hybrid programming model combining MPI-3 and C++11]],
    author: [#g.students.at(0).name - #g.students.at(0).id],
    date: datetime.today(),
    institution: [#g.institution],
    logo: image("/static/images/logo.png"),
    short-subtitle: [Specialized Project Report],
    short-title: [Distributed Barrier Algorithms using MPI-3 & C++11],
  ),
)

#title-slide()
#outline-slide()

#{ include "/src/slides/index.typ" }
