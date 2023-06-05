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

#let t = counter("ticket")
  

#ticket[dsfgdsf]

= sdfgsdgsd
 
== dfgdfs

#ticket[dsfgdsf]

#ticket[dsfgdsf] 

#ticket(lb: "hello")[dsfgdsf]


 dsfs 
 = dfgsd
== dfgdf

#ticket[dsfgdsf]
