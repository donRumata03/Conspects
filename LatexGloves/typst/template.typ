#import "theorems.typ": *

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
  which-rose-pine: none,
  body,
) = {
  // Set the document's basic properties.
  set document(author: authors.map(a => a.name), title: title)
  set page(numbering: "1", number-align: center)
  set text(font: font, lang: "ru")
  show math.equation: set text(weight: 400)
  set heading(numbering: "1.1")

  show raw: set text(font: "MonoLisa")

  // 
    show: content => if which-rose-pine != none { apply-theme(content, which-rose-pine) } else { content }
  // }
  show heading: set text(which-rose-pine.pine) if which-rose-pine != none
  show: my-theorem-styles(thm-styles:
    if which-rose-pine != none {
      rose-pine-theorem-colors(which-rose-pine)
    } else {
      (_nothing: none )
    }
  )

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

#let iso = $tilde.equiv$


// Show rule for beautiful «>=» and «<=»
// \leqslant and \geqslant are not supported yet…

#let isdef = $attach(<==>, t: "def")$
#let eqdef = $eq.def$ // $attach(eq, t: "def")$

#let proofDir(from, to, arrow: $->$) = {
  $(#from) #arrow (#to)$
}
#let proofRight =  $=>$

#let lectureSplitter(name) = {
  line(length: 100%)
  align(center)[
    #text(size: 2em, name)
  ]
  line(length: 100%)
}

#let letBe = $\]" "$
#let is = $  " " #[ — ] $

// Logically separate proof parts

#let logicalProofPart(mathSymbol) = $#circle(radius: 9pt)[
  #set align(center + horizon)
  #mathSymbol
]$

#let rightImpl = logicalProofPart($=>$)
#let leftImpl = logicalProofPart($arrow.double.l$)

#let existence = logicalProofPart($exists$)
#let uniqueness = logicalProofPart($!$)

#let contradiction = logicalProofPart($?!$)

#let underset(major, under) = $attach(b: #under, limits(#major))$
#let overset(major, over) = $attach(t: #over, limits(#major))$

// #let bilateralImplDef = underset($<==>$, $op("eq")$)

#let restriction(x, y) = $lr(#x"|", size: #200%)_#y$

///////// Examples 
$isdef$

$a eqdef b$

#rightImpl Доказательство1

Ещё доказательство

#leftImpl Доказательство2

#existence

#uniqueness

$1 eqdef 0'$ 

$1 isdef 0'$ 

$contradiction$




#proofDir(1, 2): 112 1212 dfsg sdfg sdf 

#proofDir(3, $*$, arrow: $=>$): … \*

