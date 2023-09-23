#import "cockumber_theory.typ" : *
#import "@preview/big-todo:0.2.0": *

#show: project.with(
  title: 
  "Теория чисел 
(практика)",
  authors: (vova, english_vova),
  which-rose-pine: rose-pine-moon
)

= Разбор ДЗ 1

== Поле

#theorem[
    $ZZ/(p ZZ)$ — поле из $p$ элементов
]

#proof[
    Решим уравнение $overline(a) dot overline(b) + overline(c) dot overline(d) = 1$ алгоритмом Евклида, тогда $overline(a) dot overline(b) = 1$.
]

== Корретность определения локализации $S^(-1) R$

Показываем, что отношение из определения $S^(-1) R$ — отношение эквивалентности: $(a_1, s_1) ~ (a_2, s_2) isdef (a_1 s_2 -  a_2 s_1) dot s$ для некоторого $s$.

Без $s$ тразитивность для не областей целостности не докажется.

Д: домножим накрест равенства, вынесем за скобку.

== Пример, где условие $dot s$ существено: $ZZ$

$S = {1, 2, 4}$

$S^(-1)R tilde.equiv FF_3$

Разберём 18 случаев, расположим в 3 ряда, 6 колонок.


== Прообраз идеала при гомоморфизме — тоже идеал

#remark[Уже доказали для ядра (прообраза ${bb(0)}$)]

#proof[
    Для начала покажем, что это 
]


= Гауссовы числа

#definition[$Z[i]$ — целые Гауссовы числа ($Re, Im in ZZ$)
]
Поле частных $Z[i]$ ($tilde.equiv QQ[i] = Z[i] + i Z[i]$) вкладывается в $CC$.

Евклидова норма определяется почти как для копексных: $d(a + b i) = a^2 +  b^2$.

Целые гауссовы числа — тоже Евклидово кольцо: для деления с остатком
- делим как комплексные числа
- берём ближайшее из $ZZ[i]$

= Практика 2

== Раскладываем на простые множители в кольце Гауссовых чисел

От 1 до 10-и

- $1$
- $2 = (1 + i)(1 - i) = -i (1 + i)^2$
- $3$
- $5 = (2 - i)(2 + i)$
- $7$

#remark[
  Если сумма квардатов частей — простое число, то и само Гауссово число простое ($a^2 + b^2 — "простое" => a + b i — "простое"$ + в силу мультипликативности нормы «$||a + b i|| = a^2 + b^2$» имеем $N(a + b i) = N(x) + N(y)$)
]


$1 + 3i = (1 + i)(2 + i)$

Нарисовали на координатах схемку $5×5$ простых гауссовых чисел.

#theorem[
  $
  ZZ[i]\/(a + b i) tilde.equiv ZZ\/(a^2 + b^2)
  $
]
#proof[

#align(center)[#commutative-diagram(
  node((0, 0), [$ZZ$]),
  node((0, 1), [$ZZ[i]\/ (a + b i)$]),
  node((1, 0), [$ZZ\/(a^2 + b^2)$]),
  arr((0, 0), (0, 1), [$f$]),
  arr((1, 0), (0, 1), [$g$], label-pos: -1em, "dashed", "inj"),
  arr((0, 0), (1, 0), [$$]),
)]


  $ZZ attach(->, t: f) ZZ[i]\/ (a + b i)$.

  Покажем, что $a^2 + b^2 in.rev ker f = ZZ attach(sect, b: "внутри " Z[i]) (a + b i)$.

]

#remark[
  $a, b != 0 quad a + b i — "простое" <=> a^2 + b^2 — "простое"$
]

#example[
 #let cell = rect.with(
  inset: 8pt,
  width: 100%,
  radius: 6pt
)
  #grid(
  columns: (auto, auto, auto),
  rows: (60pt, auto),
  gutter: 3pt,
  cell(height: 100%)[Easy to learn],
  cell(height: 100%)[Great output],
  cell(height: 100%)[Intuitive],
  cell[Our best Typst yet],
  cell[
    Responsive design in print
    for everyone
  ],
  cell[One more thing...],
)
  #grid(columns: 2, gutter: 1em, )[
    $ZZ[i] \/ (2) = ZZ[i] \/ (1 + i)^2 = FF_2[epsilon] \/ (epsilon^2)$ (где $epsilon$ — нильпотент)
  ][
dfgdsfg dfgdsfg dfgdsfgdfgdsfg dfgdsfg dfgdsfg
dfgdsfg dfgdsfg dfgdsfgdfgdsfg dfgdsfg dfgdsfg

dfgdsfg dfgdsfg dfgdsfgdfgdsfg dfgdsfg dfgdsfg

dfgdsfg dfgdsfg dfgdsfgdfgdsfg dfgdsfg dfgdsfg

dfgdsfg dfgdsfg dfgdsfgdfgdsfg dfgdsfg dfgdsfg

  ]
]

#theorem(name: "Китайская теорема об остатках")[
  $gcd(m, n) = 1 quad ZZ\/m n ZZ iso ZZ\/n ZZ × ZZ\/m ZZ$
]


