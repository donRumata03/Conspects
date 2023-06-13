#import "../LatexGloves/typst/template.typ": *
#import "../LatexGloves/typst/theorems.typ": *

= sdfde

#let prob = $cal(P)$


#let ticket(name, lb: none) = [
    #counter("ticket").step()

    // #locate(loc => [#counter(heading).update(counter("ticket").at(loc))])

    #locate(loc => [
        #heading(
            level: 3,
            numbering: (..nums) => "Билет " + str(counter("ticket").at(loc).at(0)) + "."
        )[#name]
    ])
] 

#let essSup = $limits(op("ess sup"))$
#let AE = "п. в."
#let scalar(l, r) = $angle.l #l, #r angle.r$
#let conj(x) = $overline(#x)$
#let Hilbert = $cal(H)$
#let Lin = $cal(L)$
#let supp = $op("supp")$
#let mf(r, k, n) = $MM^((#r))_(#k #n)$
