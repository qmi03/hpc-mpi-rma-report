#let m = yaml("/globals.yml")

#set text(font: m.at("fonts").at("serif"), size: 8pt)
#show: block.with(stroke: (top: 1pt), inset: (top: 1em))

#locate(loc => [
    // skip first page footer
    #if loc.page() == 1 {
        return
    }

    #let current-page = counter(page).at(loc).at(0)
    #let total-pages = counter(page).final(loc).at(0)

    #let semester = m.at("semester")
    #let semester-of-year = calc.rem(semester, 10)
    // change this if you use this in the 2100s
    #let year-from = calc.round(semester / 10) + 2000
    #let year-to = year-from + 1

    #m.at("course").at("name") Report - Semester #semester-of-year year #year-from - #year-to
    #h(1fr)
    Page #current-page/#total-pages
])
