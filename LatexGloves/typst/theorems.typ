#import "@preview/lemmify:0.1.2": *


#set heading(numbering: "1.1")

#translations.insert("ru", (
    "theorem": "Теорема",
    "lemma": "Лемма",
    "corollary": "Следствие",
    "remark": "Замечание",
    "proposition": "Предположение",
    "example": "Пример",
    "definition": "Определение",
    
    "memorizer": "Напоминалочка",
    "property": "Свойство",
    "Statement": "Условие",

    "proof": "Доказательство"
))


// Create a default set of theorems based
// on the language and given styling.
#let right-default-theorems(
  group,
  lang: "en",
  thm-styling: thm-style-simple,
  proof-styling: thm-style-proof,
  thm-numbering: thm-numbering-heading,
  ref-styling: thm-ref-style-simple,
  max-reset-level: 2
) = {
  let (proof, ..subgroup-map) = translations.at(lang)

  let (rules: rules-theorems, ..theorems) = new-theorems(
    group,
    subgroup-map,
    thm-styling: thm-styling,
    thm-numbering: thm-numbering
  )

  let (rules: rules-proof, proof) = new-theorems(
    group,
    (proof: translations.at(lang).at("proof")),
    thm-styling: proof-styling,
    thm-numbering: thm-numbering-proof,
    ref-numbering: thm-numbering
  )

  return (
    ..theorems,
    proof: proof,
    rules: concat-fold((
      thm-reset-counter-heading.with(group, max-reset-level),
      rules-theorems,
      rules-proof
    ))
  )
}

#let (
  definition, theorem, lemma, corollary, remark, proposition, example, memorizer, property, proof, rules: thm-rules
) = right-default-theorems("thm-group", lang: "ru", max-reset-level: 3)


// #let (property, memorizer, rules: custom-rules) = new-theorems("thm-group", (
//   property: text(red)[Note],
//   memorizer: [Напоминалочка],
// ))
// #show: custom-rules

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

#import "@preview/rose-pine:0.1.0": apply, rose-pine-dawn, rose-pine-moon, rose-pine


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
  show thm-selector("thm-group", subgroup: "definition"): it => box(
    it,
    stroke: (left: add-paint-if-some((thickness: 2pt), thm-styles, "definition")),
    inset: 1em,
  )
  show thm-selector("thm-group", subgroup: "theorem"): it => box(
    it,
    stroke: add-paint-if-some((thickness: 1pt), thm-styles, "theorem"),
    inset: 1em
  )
  show thm-selector("thm-group", subgroup: "lemma"): it => box(
    it,
    stroke: add-paint-if-some((thickness: 1pt, dash: "dotted"), thm-styles, "lemma"),
    inset: 1em
  )
  show thm-selector("thm-group", subgroup: "corollary"): it => box(
    it,
    stroke: add-paint-if-some((thickness: 1pt), thm-styles, "corollary"),
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
    stroke: (left: add-paint-if-some((thickness: 1pt, dash: "dotted"), thm-styles, "proof")),
    inset: (left: 1em, right: 1em, top: 0.5em, bottom: 0.5em),
  )

  body
}

= Тест

#show thm-selector("thm-group"): my-theorem-styles(
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

#repr(memorizer[a])

#memorizer[
  TODO
]

#property[
  asdfasdf
]


