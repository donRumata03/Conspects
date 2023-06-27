#let vova_email = "donrumata03@gmail.com";

#let vova = (name: "Владимир Латыпов", email: vova_email)
#let english_vova = (name: "Vladimir Latypov", email: vova_email)

// The project function defines how your document looks.
// It takes your content and some metadata and formats it.
// Go ahead and customize it to your liking!
#let project(
  title: "",
  abstract: [],
  authors: (vova,),
  date: none,
  logo: none,
  font: "Kurale",
  body,
) = {
  // Set the document's basic properties.
  set document(author: authors.map(a => a.name), title: title)
  set page(numbering: "1", number-align: center)
  set text(font: font, lang: "ru")
  show math.equation: set text(weight: 400)
  set heading(numbering: "1.1")

  show raw: set text(font: "MonoLisa")

  // Title page.
  // The page can contain a logo if you pass one with `logo: "logo.png"`.
  v(0.6fr)
  if logo != none {
    align(right, image(logo, width: 26%))
  }
  v(9.6fr)

  text(1.1em, date)
  v(1.2em, weak: true)
  text(2em, weight: 700, title)

  // Author information.
  pad(
    top: 0.7em,
    right: 20%,
    grid(
      columns: (1fr,) * calc.min(3, authors.len()),
      gutter: 1em,
      ..authors.map(author => align(start)[
        *#author.name* \
        #author.email
      ]),
    ),
  )

  v(2.4fr)
  pagebreak()

  // Abstract page.

  if abstract != [] {
  v(1fr)
align(center)[
    #heading(
      outlined: false,
      numbering: none,
      text(0.85em, smallcaps[Abstract]),
    )
    #abstract
  ]
  v(1.618fr)
  pagebreak()
  }
  
  // Table of contents.
  outline(depth: 3, indent: true)
  pagebreak()


  // Main body.
  set par(justify: true)

  body
}




#let empty = $diameter$
#let argmax = $op("argmax")$
#let argmin = $op("argmin")$
#let comp = $circle.stroked.tiny$ // Composition

// Show rule for beautiful «>=» and «<=»
// leqslant and geqslant are not supported yet…
