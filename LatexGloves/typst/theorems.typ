#import "@preview/lemmify:0.1.7": *


#set heading(numbering: "1.1")

#let cyrsmallcaps(body) = [
  #show regex("[а-яё]") : it => text(size:.7em, upper(it))
  #body
]

#let smallcaps-style = thm-style-simple.with(
  // name: cyrsmallcaps // smallcaps
)

#let (
  definition, theorem, lemma, corollary, remark, proposition, example,  proof, rules: thm-rules
) = default-theorems("def-thms", lang: "ru", max-reset-level: 1, thm-styling: smallcaps-style)

#let memorizer = new-theorems("def-thms", (Reminder: "Reminder"), thm-styling: smallcaps-style)
#let property = new-theorems("def-thms", (Property: "Property"), thm-styling: smallcaps-style)
#let statement = new-theorems("def-thms", (Statement: "Statement"), thm-styling: smallcaps-style)
// #let statement = theorem-kind("Statement", style: smallcaps-style) // Not «Утверждение» because it's used for home tasks.

// #let (property, memorizer, rules: custom-rules) = new-theorems("thm-group", (
//   property: text(red)[Note],
//   memorizer: [Напоминалочка],
// ))
// #show: custom-rules


#import "@preview/rose-pine:0.1.0": apply, rose-pine-dawn, rose-pine-moon, rose-pine, apply-theme


#show: apply(variant: "rose-pine-moon")

#let rose-pine-theorem-colors(theme) = {
  (
    definition: theme.gold,
    theorem: theme.love,
    lemma: theme.love,
    corollary: theme.pine,
    
    remark: theme.foam,
    proof: theme.iris
  )
}

#let add-paint-if-some(res, source, key) = {
  if key in source {
    res.insert("paint", source.at(key))
  }

  res
}


#let my-theorem-styles = (thm-styles: (_nothing: none)) => body => {
  show: thm-rules

  // show: it => thm-reset-counter-heading-at("thm-group", 1, it)
  // show select-kind: it => 
  show thm-selector("def-thms", subgroup: "definition"): it => box(
    it,
    stroke: (left: add-paint-if-some((thickness: 2pt), thm-styles, "definition")),
    inset: 1em,
  )
  show thm-selector(theorem): it => box(
    it,
    stroke: add-paint-if-some((thickness: 1pt), thm-styles, "theorem"),
    inset: 1em
  )
  show thm-selector(lemma): it => box(
    it,
    stroke: add-paint-if-some((thickness: 1pt, dash: "dotted"), thm-styles, "lemma"),
    inset: 1em
  )
  show thm-selector(corollary): it => box(
    it,
    stroke: add-paint-if-some((thickness: 1pt), thm-styles, "corollary"),
    inset: 1em
  )
  show thm-selector(example): it => box(
    it,
    inset: (left: 1em, right: 1em, top: 1em, bottom: 1em),
  )
  show thm-selector(remark): it => box(
    it,
    inset: (left: 1em, right: 1em, top: 1em, bottom: 1em),
  )
  show thm-selector("def-thms", subgroup: "proof"): it => box(
    it,
    stroke: (left: add-paint-if-some((thickness: 1pt, dash: "dotted"), thm-styles, "proof")),
    inset: (left: 1em, right: 1em, top: 0.5em, bottom: 0.5em),
  )

  body
}




#let def = definition
#let thm = theorem
#let rm = remark
#let lm = lemma
#let cor = corollary
#let pr = proof









= Тест

#show: my-theorem-styles(
  thm-styles: rose-pine-theorem-colors(rose-pine-moon)
  )

#theorem(name: "Some theorem")[
  Theorem content goes here.
]<thm-label-example>

#proof[
  That's quite obvious
  
  #remark[
    See YouTube lectures for deeper understanding
  ]

  #lemma[
    sdfa
  ]
  #proof[
    Lemma's proof
  ]
]<proof-label-example>


@proof-label-example and @thm-label-example[theorem]

#lemma[
  OMG
]

#corollary[
  sadf
]

#definition(name: "Something")[
    asdf
]

#example[
  dfsgsdfg
]

#remark[
  by the way, I use arch
]

#proposition[
  asdf
]


// #repr(memorizer[a])

// #memorizer[
//   TODO
// ]

// #property[
//   asdfasdf
// ]


// #statement[
//   adsfasd
// ]
