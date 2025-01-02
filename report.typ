#set page(
  paper: "a4", header: { include "/src/meta/header.typ" }, footer: { include "/src/meta/footer.typ" }, margin: (top: 30mm, bottom: 20mm, left: 30mm, right: 20mm),
)

#set par(justify: true)
#let g = yaml("/globals.yml")
#let fonts = g.at("fonts")

#set document(title: g.at("title"), author: g.at("students").map(s => s.at("name")))
#set text(font: fonts.at("serif"), lang: "en", size: 13pt)
#show raw: set text(font: fonts.at("monospace"))
#show raw.where(block: true): set block(fill: gray.lighten(90%), width: 100%, inset: (x: 1em, y: 1em))
#show link: it => {
  set text(fill: blue)
  underline(it)
}
#import "@preview/numbly:0.1.0": numbly
#set heading(numbering: numbly(
  "Chapter {1:I}:",
  "{1}.{2}",
  "{1}.{2}.{3}",
  "{1}.{2}.{3}.{4}",
))
#show heading: it => {
  it
  v(.5em)
}
#set list(indent: 10pt)

#{ include "/src/report/index.typ" }

#bibliography("/bibliography.yml", title: [References])
