#import "cockumber_theory.typ" : *
#import "@preview/big-todo:0.2.0": *

#show: project.with(
  title: 
  "Теория чисел 
(теория)",
  authors: (vova, english_vova)
)





= Базовые определения

#definition(name: "группа")[…]
#definition(name: "кольцо")[…]
#remark[Будем работать с коммутативными кольцами, преимущественно — с областями целостности]
#example(name: "многочлены")[]

#definition(name: "поле")[…]
#definition(name: "область целостности")[…]

= Идеалы

#definition(name: "идеал")[…]

#remark[Пошло из обобщения понятия делимости, «идеальные делители».

Простой идеал — обобщение простого числа.
]

#definition(name: "Простой идеал")[
    $p lt.tri.eq R$ — простой $isdef$ $a b in p => a in p or b in p$.

    Эквивалентно: $a b equiv_p 0 => a equiv_p 0 or b equiv_p 0$
]


#definition(name: "факторкольцо по идеалу")[…]
#definition(name: "ОГИ")[…]
#definition(name: "нётерово кольцо")[…]
#theorem(name: "Гаусса о нётеровости кольца многочленов над Гауссовым полем")[…]


= Евклидовы кольца

#definition(name: "Евклидово кольцо")[
    $d: R \\ {0} -> NN_0$, тч

    + $d(a b) >= d(a)$
    + $forall a, b, b != 0 exists q, r: a = b q + r, r = 0 or d(r) < d(b)$
]
#example[$ZZ, F[x]$]

#theorem[Евклидово → ОГИ]
#proof[Находим $a$ — минимальный по $d$, если нашёлся не кратный, делим с остатком на $a$, получаем менльший, противоречие]

#definition(name: "Факториальное кольцо (UFD — Unique factorization domain)")[
    Область целостности

    - Существует разложение на неприводимые множители
    - Единственно с точностью до $R^*$: если $x = u dot a_1 dot … dot a_n =  u dot b_1 dot … dot b_m => m = n and a_i = b_sigma_i dot w_i, w_i in R^*$
]

#definition(name: "Неприводимый элемент")[
    $a != 0, a in.not R^* quad a = b c => b in R^* or c in R^*$
]

#property[
    Неприводимость сохраняется при домножении на обратимые ($r in R^*$)
]

#definition(name: "Простой элемент")[
    $a | b c => a | b or a | c$ ($<=> a R$ — простой идеал)
]

#theorem[Простой $=>$ неприводимый]
#proof[#todo[]]

#theorem[В факториальном кольце: Неприводимый $=>$ простой]
#proof[#todo[]]

#corollary[В факториальном кольце простые идеалы высоты 1 (то есть $0 <= q <= p => q = 0 or q = p$) являются главными]
#proof[
    Элемент идеала раскладывается на множители, а по простоте какой-то — $in p$, тогда $0 <= underbrace((a_i), "прост.") <= p$ → $(a_i) = p$
]

#todo[Помечать разделение не лекции красивыми заголовками (как ornament header в latex)]


#theorem[Евклидово $=>$ ОГИ $=>$ Факториальное]



#todo[Перейти на `lemmify`]
#proof(name: "Евклидово → ОГИ")[
    …
]

#definition[$R^*$ — мультипликативная группа кольца (все, для которых есть обратный, с умножением)]


#proof(name: "ОГИ → факториальное")[
    Обобщение ОТА на произвольную ОГА с целых чисел.


]

