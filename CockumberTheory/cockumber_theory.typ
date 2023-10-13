#import "../LatexGloves/typst/template.typ": *
#import "../LatexGloves/typst/theorems.typ": *
#import "@preview/commute:0.1.0": node, arr, commutative-diagram


#let gcd = $op("gcd")$

#let idealIn = $lt.tri.eq$
// #let withMap(mapper) = $attach(→, t: #mapper)$

// #show math.

// #let slash = $#h(2em) slash #h(0cm)$

// #show math.slash: it => $\/$ // Crashes
// #show sym.slash: it => $\/$ // Crashes
#let fraction(a, b) = $frac(#box(a), b)$
#show math.frac: it => {
if it.num.func() == box { it } else { 
    box($#it.num \/ #it.denom$) 
    } // Turns everything into slash
}
#let frac = fraction
$a / b$ // Should be slash

$a slash b$ // Should be slash

$frac(a, b)$ // Should be fraction

$1 = fraction(a, b) - 1$
