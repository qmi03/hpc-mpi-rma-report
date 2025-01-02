#let m = yaml("/globals.yml")

#set text(font: m.at("fonts").at("serif"), size: 10pt)
#set par(leading: 0.75em)
#show: block.with(stroke: (bottom: 1pt), inset: (bottom: 0.5em))
#show: upper

#locate(loc => [
  // skip first page header
  #if loc.page() == 1 {
    return
  }

  #box(image("/static/images/logo.png", height: 2.5em))
  #h(0.5cm)
  #box[
    HO CHI MINH CITY UNIVERSITY OF TECHNOLOGY\
    FACULTY OF COMPUTER SCIENCE AND ENGINEERING
  ]
  #h(1fr)
])
