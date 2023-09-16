#import "../algo.typ": *


#show: project.with(
  title: 
  "Практика 9 
(теория чисел)",
  authors: (vova, english_vova)
)




#counter(heading).update(4)

= Число решений

#memorizer(name: "Класс решений")[
    $ (x_0 + k dot.c dif x, y_0+k dot.c dif y) $

    , где $dif x = b / gcd(a, b)$, $dif y = - a / gcd(a, b)$
]



#statement()[
    Найдите число решений диофантового уравнения $a x+b y=c$, в которых $|x|,|y| <= M$.
]

Найдём отрезок $[l_x, r_x]$ значений $k$, при которых $-M <= x_0 + k dot.c dif x <= M$:

$
l_x = ceil(-M - x_0) / (dif x) \
r_x = floor(M - x_0) / (dif x)
$

PS: если $dif x$ отрицательный, → поставим минусы

Аналогично для $y$ получаем $[l_y, r_y]$.

Тогда ответом будет $max(0, min(r_x, r_y) - max(l_x, l_y) + 1)$.


#counter(heading).update(12)

#pagebreak()

= Выражение через линейные комбинации

#statement()[
    Есть массив $a_i$. Найти максимальное $y$, для которого существуют $x$ и $b_i$ такие, что $a_i=x+y dot.c b_i$.
]


#theorem(name: "Эквивалентная переформулировка")[
    Нужно найти максимальный модуль, по которому $a_i$ сравнимы
    ]

#proof[
    Если зафиксирован $y$, то существование $x, {b_i}$ $<==> a_i equiv_y a_j equiv_y a_0$, так как

- Если нашли, $x, {b_i}$, то $forall i:  x mod y equiv_y a_i = x + y dot.c b_i$
- Если $forall i: c equiv_y a_i$, то для $a_i = x + y dot.c b_i$ возьмём $
cases(x := c \ b_i = (a_i - c)/y)
$
]

Введём $a'_i = a_i - a_0$

Очереная переформулировка: нужно найти максимальный модуль, по которому $a'_i$ сравнимы с $0$, aka делятся на этот модуль.

Тогда ответом будет $gcd({a'_i})$.
