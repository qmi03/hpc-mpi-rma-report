#let m = yaml("/metadata.yml")

#set align(center)

#[
  #show: upper
  #set par(leading: 1.2em)
  #set text(size: 15pt)

  *VIETNAM NATIONAL UNIVERSITY HO CHI MINH CITY\
  HO CHI MINH CITY UNIVERSITY OF TECHNOLOGY\
  FACULTY OF COMPUTER SCIENCE AND ENGINEERING*
]

#v(2fr)

#align(center, image("/static/images/logo.png", height: 5cm))

#v(2fr)

#[
  #set text(size: 15pt)
  #set align(center)

  *#upper(m.at("course").at("name"))*
]

#v(.5fr)

#block(width: 100%, inset: (y: 2em), stroke: (y: 1pt))[
  #set par(leading: 1em)

  #set text(weight: "bold", size: 16pt)
  #upper(m.at("title"))

  #set text(weight: "regular", size: 15pt)
  Major: Computer Science
]

#v(1fr)

#set text(weight: "regular", size: 15pt)
#show: upper
#grid(
  columns: (1fr, 1fr), rows: (2em, auto), column-gutter: .5cm, align(right, [supervisors:]), align(left, for s in m.at("supervisors") [
    #v(1em, weak: true)
    #s.at("name")
  ]),
)

#grid(
  columns: (1fr, 1fr), rows: (2em, auto), column-gutter: .5cm, align(right, [Student:]), align(left, for s in m.at("students") [
    #v(1em, weak: true)
    #s.at("name") - #s.at("id")
  ]),
)

#v(1fr)

HCMC, #datetime.today().display("[month]/[year]")
