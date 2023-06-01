#import "math_coq.typ": *

 
#show: project.with(
  title: 
  "ДЗ 13 
()"
)


#counter(heading).update(5)

= Ромбик за один шаг не замыкается!

$(lambda x. T) Omega$

- $→_beta T$
- $→_beta (lambda x. T) Omega$

Однако $T$ — уже в нормальной форме → не $beta$-редуцируется ни во что, т.ч.$
exists.not S. T→_beta S  and (lambda x. T) Omega →_beta S
$


// $(lambda x. x * 4) ((lambda x. x * 100) (lambda x. x * 100))$


// $1→ ((lambda x. x * 100) (lambda x. x * 100)) * 4$ → $((lambda x. x * 100) * 100) * 4$

// $2→ (lambda x. x * 4) ((lambda x. x * 100) * 100)$ → $$



// $(lambda x. T x) Omega$

// $Delta ident lambda x. x x x$

// $Omega T T$

// $→ T T T$


// $((lambda x. lambda y.x) " " T) " " Delta$

// $ → (lambda y. T) Omega$

// $→ ((lambda x. lambda y.x) " " T) " " Omega$


= 7…

= Наличие типа подвыражений

Рассмотрим дерево доказательства, что $A$ имеет тип $alpha$. И докажем для подвыражений индукцией по дереву разбора $A$, каждый раз ссылаясь на детей и делая это конечное количество раз.

- Если $D$ — переменная, доказано: постулировали, что она имеет тип $delta$
- Если $D ident lambda x. E$ и оно было получено как абстракция, то для подвыражения $x$ есть тип в контексте $Gamma$, а для $E$ — доказательство в дереве выше.
$
(("proof")/(Gamma, x: phi tack.r E : psi)) / (Gamma tack.r lambda x. E: phi → psi)
$

- Если $D$ было получено как MP (аппликация $B С$), то в левой ветке есть доказательство, что $Gamma tack.r C: phi$, а в правой — что $Gamma tack.r B: phi → delta$.
$
(("proof"_1)/(Gamma tack.r C : phi) quad ("proof"_2)/(Gamma tack.r B : phi → psi)) / (Gamma tack.r D: psi)
$


= Необитаемый остров невезения

Утверждается, что вот же он: $((alpha → beta) → beta) → alpha$.

Пусть у нас есть $lambda$-выражение, имеющее этот тип и дерево доказательство, что оно этот тип имеет.
Тогда 
