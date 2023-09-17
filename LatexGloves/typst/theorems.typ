#import "@preview/lemmify:0.1.2": *


#let (
  definition, theorem, lemma, corollary, remark, proposition, example, proof, rules: thm-rules
) = default-theorems("thm-group", lang: "en", max-reset-level: 3)

// #show: thm-rules
// #show thm-selector("thm-group", subgroup: "definition"): it => box(
//   it,
//   stroke: (left: (thickness: 2pt)),
//   inset: 1em,
// )
// #show thm-selector("thm-group", subgroup: "theorem"): it => box(
//   it,
//   stroke: 1pt,
//   inset: 1em
// )
// #show thm-selector("thm-group", subgroup: "lemma"): it => box(
//   it,
//   stroke: (thickness: 1pt, dash: "dotted"),
//   inset: 1em
// )
// #show thm-selector("thm-group", subgroup: "corollary"): it => box(
//   it,
//   stroke: 1pt,
//   inset: 1em
// )
// #show thm-selector("thm-group", subgroup: "example"): it => box(
//   it,
//   inset: (left: 1em, right: 1em, top: 1em, bottom: 1em),
// )
// #show thm-selector("thm-group", subgroup: "remark"): it => box(
//   it,
//   inset: (left: 1em, right: 1em, top: 1em, bottom: 1em),
// )
// #show thm-selector("thm-group", subgroup: "proof"): it => box(
//   it,
//   stroke: (left: (thickness: 1pt, dash: "dotted")),
//   inset: (left: 1em, right: 1em, top: 0.5em, bottom: 0.5em),
// )

#let my-theorem-styles(body) = {
  show: thm-rules
  show thm-selector("thm-group", subgroup: "definition"): it => box(
    it,
    stroke: (left: (thickness: 2pt)),
    inset: 1em,
  )
  show thm-selector("thm-group", subgroup: "theorem"): it => box(
    it,
    stroke: 1pt,
    inset: 1em
  )
  show thm-selector("thm-group", subgroup: "lemma"): it => box(
    it,
    stroke: (thickness: 1pt, dash: "dotted"),
    inset: 1em
  )
  show thm-selector("thm-group", subgroup: "corollary"): it => box(
    it,
    stroke: 1pt,
    inset: 1em
  )
  show thm-selector("thm-group", subgroup: "example"): it => box(
    it,
    inset: (left: 1em, right: 1em, top: 1em, bottom: 1em),
  )
  show thm-selector("thm-group", subgroup: "remark"): it => box(
    it,
    inset: (left: 1em, right: 1em, top: 1em, bottom: 1em),
  )
  show thm-selector("thm-group", subgroup: "proof"): it => box(
    it,
    stroke: (left: (thickness: 1pt, dash: "dotted")),
    inset: (left: 1em, right: 1em, top: 0.5em, bottom: 0.5em),
  )

  body
}

#show thm-selector("thm-group"): my-theorem-styles

#theorem(name: "Some theorem")[
  Theorem content goes here.
]<thm-label-example>

#proof[
  Complicated proof.
]<proof-label-example>

@proof-label-example and @thm-label-example[theorem]

#definition(name: "Something")[
    asdf
]
