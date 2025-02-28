// Store theorem environment numbering

#let thmcounters = state("thm",
  (
    "counters": ("heading": ()),
    "latest": ()
  )
)


#let thmenv(identifier, base, base_level, fmt) = {

  let global_numbering = numbering

  return (
    body,
    name: none,
    numbering: "1.1",
    base: base,
    base_level: base_level
  ) => {
    let number = none
    if not numbering == none {
      locate(loc => {
        thmcounters.update(thmpair => {
          let counters = thmpair.at("counters")
          // Manually update heading counter
          counters.at("heading") = counter(heading).at(loc)
          if not identifier in counters.keys() {
            counters.insert(identifier, (0, ))
          }

          let tc = counters.at(identifier)
          if base != none {
            let bc = counters.at(base)

            // Pad or chop the base count
            if base_level != none {
              if bc.len() < base_level {
                bc = bc + (0,) * (base_level - bc.len())
              } else if bc.len() > base_level{
                bc = bc.slice(0, base_level)
              }
            }

            // Reset counter if the base counter has updated
            if tc.slice(0, -1) == bc {
              counters.at(identifier) = (..bc, tc.last() + 1)
            } else {
              counters.at(identifier) = (..bc, 1)
            }
          } else {
            // If we have no base counter, just count one level
            counters.at(identifier) = (tc.last() + 1,)
            let latest = counters.at(identifier)
          }

          let latest = counters.at(identifier)
          return (
            "counters": counters,
            "latest": latest
          )
        })
      })

      number = thmcounters.display(x => {
        return global_numbering(numbering, ..x.at("latest"))
      })
    }

    fmt(name, number, body)
  }
}


#let thmref(
  label,
  fmt: auto,
  makelink: true,
  ..body
) = {
  if fmt == auto {
    fmt = (nums, body) => {
      if body.pos().len() > 0 {
        body = body.pos().join(" ")
        return [#body #numbering("1.1", ..nums)]
      }
      return numbering("1.1", ..nums)
    }
  }

  locate(loc => {
    let elements = query(label, loc)
    let locationreps = elements.map(x => repr(x.location().position())).join(", ")
    assert(elements.len() > 0, message: "label <" + str(label) + "> does not exist in the document: referenced at " + repr(loc.position()))
    assert(elements.len() == 1, message: "label <" + str(label) + "> occurs multiple times in the document: found at " + locationreps)
    let target = elements.first().location()
    let number = thmcounters.at(target).at("latest")
    if makelink {
      return link(target, fmt(number, body))
    }
    return fmt(number, body)
  })
}


#let thmbox(
  identifier,
  head,
  fill: none,
  stroke: none,
  inset: 1.2em,
  radius: 0.3em,
  breakable: false,
  padding: (top: 0.5em, bottom: 0.5em),
  namefmt: x => [(#x)],
  titlefmt: strong,
  bodyfmt: x => x,
  separator: [#h(0.1em):#h(0.2em)],
  base: "heading",
  base_level: none,
) = {
  let boxfmt(name, number, body) = {
    if not name == none {
      name = [ #namefmt(name)]
    } else {
      name = []
    }
    let title = head
    if not number == none {
      title += " " + number
    }
    title = titlefmt(title)
    body = bodyfmt(body)
    pad(
      ..padding,
      block(
        fill: fill,
        stroke: stroke,
        inset: inset,
        width: 100%,
        radius: radius,
        breakable: breakable,
        [#title#name#separator#body]
      )
    )
  }
  return thmenv(identifier, base, base_level, boxfmt)
}


#let thmplain = thmbox.with(
  padding: (top: 0em, bottom: 0em),
  breakable: true,
  inset: (top: 0em, left: 1.2em, right: 1.2em),
  namefmt: name => emph([(#name)]),
  titlefmt: emph,
)

// Last-element-numbering:
// (there's a property «base_level» but it takes prefix, not suffix of base)
#let lastElementsNumbering = (elementCount) => (..nums) => if (nums.pos().len() == 0) {
  "shouldn't happen LOL"
} else {
  str(nums 
      .pos()
      .slice(nums.pos().len() - elementCount)
      .map(str)
      .join(".")
    )
}

// Theorem environments

#let theorem = thmbox(
  "theorem",
  "Теорема",
  fill: rgb("#e8e8f8")
).with(numbering: lastElementsNumbering(1))
#let lemma = thmbox(
  "theorem",            // Lemmas use the same counter as Theorems
  "Лемма",
  fill: rgb("#efe6ff")
)
#let corollary = thmbox(
  "corollary",
  "Следствие",
  base: "theorem",      // Corollaries are 'attached' to Theorems
  fill: rgb("#f8e8e8")
).with(numbering: lastElementsNumbering(2))

#let definition = thmbox(
  "definition",
  "Определение",
  fill: rgb("#e8f8e8")
)

#let example = thmplain("example", "Пример").with(numbering: none)
#let remark = thmplain("remark", "Замечание").with(numbering: none)

#let proof = thmplain(
  "proof",
  "Доказательство",
  base: "theorem",
  bodyfmt: body => [
    #body #h(1fr) $square$    // Insert QED symbol
  ]
).with(numbering: none)

#let property = thmbox(
  "property",
  "Свойство",
  base: "definition",      // Properties are 'attached' to Definitions
  fill: rgb("#f8e8e8")
)



#let memorizer = thmbox(
  "memorizer",            // use the same counter as Memorizer
  "Напоминалочка",
  fill: rgb("#efe6ff")
)

#let statement = thmbox(
    "statement",            // use the same counter as Memorizer
    "Условие",
    fill: rgb("#e6f7ff"),
    base: none
)


= df

== df

=== dfd

==== sdfads

#theorem[
  Теорема
]

#corollary[
  Следствие
]

#corollary[
  Следствие
]

