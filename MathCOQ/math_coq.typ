#import "../LatexGloves/typst/template.typ": *
#import "../LatexGloves/typst/theorems.typ": *


// $attach(
//   t: alpha, b: beta,
//   tl: 1, tr: 2, bl: 3, br: 4,
//   Pi
// )$

// attach(base, top, bottom, topleft, bottomleft, topright, bottomright)

// $attach(limits(a), tl: x, t: y). $

// Version 0.3 of typst which introduces attach isn't supported by typst-LSP yet

// #let goedel_index(x) = {
//   return $attach(tl: ┌, tr: ┐, #x)$
// }

// Works
// #let myxi = $xi$
// $#goedel_index(myxi)$


// Works
// #goedel_index($xi$)

// OMG, this works too:
// $ #goedel_index($xi$) d $

// $ #goedel_index([#goedel_index([#goedel_index([$xi$])])]) $
