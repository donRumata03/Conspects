#import "cockumber_theory.typ" : *
#import "@preview/big-todo:0.2.0": *

// #import "@preview/rose-pine:0.1.0": apply, rose-pine-dawn, rose-pine-moon, rose-pine


#show: project.with(
  title:
  "Теория чисел  (теория)",
  authors: (vova, english_vova),
  which-rose-pine: rose-pine-moon
)

= Базовые определения

// #text(fill: rose-pine.love)[Some red text]

// https://1

// #footnote[asdf]

#definition(name: "группа")[
    $lr(angle.l G, star angle.r)$ — группа, если

    // $cases(
    // #[
        + $forall a, b, c in G quad a star (b star c) = (a star b) star c$ (ассоциативность)
        + $exists e in G quad forall x in G quad x star e = e star x = x$ (существование нейтрального элемента)
        + $forall x exists y quad x star y = y star x = e$ (существование обратного элемента)
    // ])
    // $

    аксиома 1 даёт _полугруппу_, при добавлении аксиомы 4 — получается _абелева группа_
]

#example[
    - $S_n$ — группа, но не абелева
]

#definition(name: "кольцо")[
    + $lr(angle.l R, + angle.r)$ — абелева группа
    + $lr(angle.l R \\ {0}, dot angle.r)$ — полугруппа
    + $a dot (b + c) = a dot b + a dot c = (b + c) dot a$ (дистрибутивность умножения относительно сложения)
]
#remark[Будем работать с коммутативными кольцами (умножение коммутативно), преимущественно —  с областями целостности]

#example[
    - $ZZ$ — кольцо
    - $R[x]$ — кольцо многочленов над $R$ от переменной $x$.
]

#definition(name: "Гомофморфизм колец")[
    $f: R_1 → R_2$

    + $f(x + y) = f(x) + f(y)$ («дистрибутивность» относительно сложения)
    + $f(a b) = f(a) f(b)$ («дистрибутивность» относительно умножения)
    + $f(1_R_1) = 1_R_2$ (сохранение единицы)
]

#example(name: "Независимость третей аксиомы")[
    $
    f: mat(R → R×R; r |-> (r, 0))
    $ — 1, 2 выполнены, но не 3
]

#definition(name: "поле")[
    - Коммутативное кольцо с единицей
    - $forall x != 0 exists y quad x dot y = y dot x = e$ (существование обратного элемента по умножению)

    (пишут $y = x^(-1)$)
]
#remark[
    То есть ещё и $R \\ {0}$ — абелева группа.
]

#example[
    - $RR$
    - $CC$
    - $FF_2$
]

#definition(name: "область целостности")[
    + $1 != 0$
    + $forall a, b in R quad a b = 0 => a = 0 or b = 0$ (отсутствие делителей нуля)
    2'. $forall a != 0 quad a b = a c => b = c$ (можно сокращать на всё, кроме нуля)

    (2 и 2' эквивалентны)
]

#example[
    $ZZ$, любое поле (действительно, сократим через деление на обратный)
]

= Идеалы

#definition(name: "идеал")[
    $I idealIn R$
    
    - $forall a, b in I quad a - b in I$ (замкнутость относительно разности)
    - $forall r in R, a in I quad r dot a in I$ (замкнутость относительно умножения на элемент кольца)
]

#remark[
    - У любого кольца есть идеалы $0, R$.
    - $R$ — поле $=>$ есть только эти идеалы
]

#remark[Идеалы в кольцах и нормальные подгруппы обозначают «меньше или равно с треугольничком»: $idealIn$, остальные подструктуры — обычно просто $<=$]

#definition(name: "Операции над идеалами")[
    - Сложение
    - Пересечение
    — определяются поэлементно

    - Умножение: натягиваем на произведение множеств по Минковскому
]

#definition[
    Идеал, порождённый подмножеством $S subset R$: $
    (S) = sect.big_(S subset I idealIn R) I
    $ Он же — $
    {sum r_i s_i | r_i in R, s_i in S}
    $
]
#remark[
    $
    (a_1, …, a_n) = {sum_(i = 1)^n = r_i s_i | r_i in R}
    $ (линейная комбинация)

    $(a) = a R = R a = {r a | r in R}$
]

#definition[
    Идеалы, которые можно породить одним элементом — _главные_.
]

#definition(name: "PID/ОГИ")[
    Когда все идеалы — главные.
]


#definition(name: "Факторкольцо по идеалу")[
    Введём отношение эквивалентности $a - b in I$ и факторизуем по нему. Получим $R \/ I$ — кольцо с элементами $x + I, quad x in R$.
]



#remark[Понятие идеала пошло из обобщения концепции делимости, «идеальные делители».
Простой идеал — обобщение простого числа.
]

#definition(name: "Простой идеал")[
    $p idealIn R$ — простой $isdef$ $a b in p => a in p or b in p$.

    Эквивалентно: $a b equiv_p 0 => a equiv_p 0 or b equiv_p 0$
]


#definition(name: "Нётерово кольцо")[
    Конечно порождённое кольцо
]
#theorem(name: "Эквивалентные определения нётеровости")[
    + Все идеалы конечно порождены
    + Вложенная расширяющаяся последовательность идеалов стабилизируется
    + У множества идеалов существует максимальный по включению (но не обязательно — _наибольший_)
]
#proof[

    #proofDir(1, 2): Пусть $I = union.big I_k = (a_1, … a_n)$. Каждое $a_i$ лежит в каком-то $I_k_i$. Тогда стабилизция происходит уже при $I_(max{k_i})$.

    #proofDir(2, 3): Итеративно будем выбирать идеал, содержащий предыдцщий, пока таковой имеется.
    - Если кончились, мы нашли максимальный
    - Если нет, построили последовательность вложенных идеалов. Так как она стабилизирутеся, стабильное значение — наш ответ.

    #proofDir(3, 1): $I = max {J | J subset I, J - "конечно порождён"}$.
]

#theorem(name: "Гильберта о нётеровости кольца многочленов над нётеровым кольцом")[
    Пусть для $I idealIn R[x] quad a(i) = {r in R | r x^i + *dot x^(<i-1) in I}$, то есть коэфициенты при $x^i$, когда это старшая степень.

    Тогда $a(1) subset a(2) subset …$ — вложенная цепочка идеалов $idealIn R$. Пусть стабилизируется на $a(k)$.

    #todo[]
]


= Евклидовы кольца

#definition(name: "Евклидово кольцо")[
    $d: R \\ {0} -> NN_0$, тч

    + $d(a b) >= d(a)$
    + $forall a, b, b != 0 exists q, r: a = b q + r, r = 0 or d(r) < d(b)$
]
#example[$ZZ, F[x]$]

#theorem[Евклидово → ОГИ]
#proof[Находим $a$ — минимальный по $d$, если нашёлся не кратный, делим с остатком на $a$, получаем меньший, противоречие]

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
    $a divides b c => a divides b or a divides c$ ($<=> a R$ — простой идеал)
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



#proof(name: "Евклидово → ОГИ")[
    …
] 

#definition[$R^*$ — мультипликативная группа кольца (все, для которых есть обратный, с умножением)]
 

#proof(name: "ОГИ → факториальное")[
    Схема: следует из двух свойств, докажем оба для ОГИ.

#lemma[В ОГИ: неприводимый → простой]

    Обобщение ОТА на произвольную ОГА с целых чисел.

    Переформулируем: …

    Пусть есть такие элементы, возьмём цепочку максимальной длины, последний — приводим, представим как необратимые, тогда они сами представляются как …, тогда и он тоже.

    #todo[]
]

#definition[нснм — начиная с некоторого места]

#remark[
    Нётеровость: не можем бесконечно делить, так как при переходе к множителям идеалы расширяются, но в какой-то момент стабилизируются.
]


#theorem[$R$ факториально $=> R[x]$ — тоже]


#example[
    F — поле.

    $f in F[x]$ — неприводим.

    $F[x]/((f))$ — область целостности, но докажем, что поле.

    - $overline(g) quad deg g < deg f$
    - $(f, g) = 1$, то есть $1 = f p_1 + g p_2$, $overline(1) = overline(f)overline(p_1) + overline(g)overline(p_2)$

    $dim_F K = deg f$
]

Можем построить все конечные поля.

$FF_p[x] in.rev f, deg f = m$

$FF_(p^m)[x] "«=»" FF_p[m]/((f))$

#theorem[Над конечным полем существуют неприводимые многочлены любой степени]

#example[
    $FF_2[x]/((x^2 + x + 1))$

    Таблица сложения:

    #table(columns: 5,
    [], [$0$],[$1$],[$alpha$],[$beta$],
    [$0$],[$0$],[$1$],[$3$],[$4$]

    )
]

#theorem[Группа простого порядка — циклическая]


// #thm-reset-counter("thm-group")

// #show: my-theorem-styles()

== sdafasf
=== dasasd

==== asdf

= vdsf

== 231


#theorem[sdfs] #todo[Why isn't the theorem counter reset?]



// Renders an image or a placeholder if it doesn't exist.
// Don’t try this at home, kids!
#let maybe-include(path) = locate(loc => {
  let path-label = label(path)
  let first-time = query(locate(_ => {}).func(), loc).len() == 0
  if first-time or query(path-label, loc).len() > 0 {
    [#include path
    #path-label]
  } else {
    rect(width: 50%, height: 5em, stroke: 1pt)[
      #set align(center + horizon)
      Could not find #raw(path)
    ]
    // none
  }
})

#for i in range(1, 15) {
    let path = "theory/lecture-" + str(i) + ".typ"
    let failed = false // TODO: handle loop ending condition (first read the typst.meta docs)

    let content = locate(loc => {
        let path-label = label(path)
        let first-time = query(locate(_ => {}).func(), loc).len() == 0
        if first-time or query(path-label, loc).len() > 0 {
            [#include path
            #path-label]
        } else {
            // failed = true
            rect(width: 50%, height: 5em, stroke: 1pt)[
            #set align(center + horizon)
            Could not find #raw(path)
            ]
            // none
        }
        })
    if failed {
        break
    } else {
        [
            #content
            
        ]
    }
}

#lectureSplitter[Лекция 3]

= Поля

#definition(name: "Подполе")[]

#property[$R — "поле" <=> "в" R " ровно 2 идеала"$]
#property[Гомоморфизмы полей инъективны, так как ядро — идеал]

#definition(name: [$F$-аглебра (алгебра над $F$)])[
    кольцо $R$, тч $F <= R$
]
#remark[Тогда это заодно и векторное пространство]

#definition(name: [Гомофморфизм $F$-алгебр])[
    - $f: R → R'$ — гомоморфизм колец
    - $f(alpha) = alpha forall alpha in F$ (сохраняет элементы поля)
]
#remark[Получается, это автоматически гомоморфизм векторных пространств]

#definition(name:[Характеристика])[
    $ZZ attach(→, t: f) F \ n |-> underbrace(1_F + 1_F + … 1_F, n "раз")$.

    + $ker f = 0$
        
    #align(center)[#commutative-diagram(
        node((0, 0), [$ZZ$]),
        node((0, 2), [$F$]),
        node((2, 1), [$QQ$]),
        arr((0, 0), (0, 2), [$f$]),
        arr((2, 1), (0, 2), [$$], label-pos: -1em, "dashed", "inj"),
        arr((0, 0), (2, 1), [$$]),
    )]

    + $ker f = (p)$

    Итого: минимальное количество раз, которое нужно сложить единицу с собой, чтобы стала нулём.
] 

#definition(name: [Простые поля])[
    Не содержат подполя
]

#remark(name: "Бином Ньютона")[
    В полях характеристики $p$/в $FF_p$ алгебрах $p dot (a = 0) => quad (a + b)^p = a^p + b^p$.
]

#definition(name: [эндоморфизм Фробениуса])[
    $f: mat(R → R; a |-> a^p)$.

-  Если поле, то инъективен ($ker f = 0$) и $"Im" f$ — подполе
- $R = FF_p$ — конечное поле $=>$ назвают «автоморфизм Фробениуса»
]

$ FF_p(x) →^f FF_p(x) quad Im f = FF_p(X^p) = { g(x^p) / h(x^p) | g, h in FF_p[x], h != 0 } $.

#definition(name: [Унитарный многочлен])[
    Старший коэфициент = 1
]

#theorem(name: [Лемма Гаусса])[
    
]

#theorem(name: "Критерий Эйзенштейна")[
    $ h = a_n x^n + … + a_1 x + a_0, quad a_i in ZZ, quad p is "простой" $
    
    + $p divides.not a_n$
    + $p divides a_(n - 1), … a_0$
    + $p^2 divides.not a_0$

    Тогда $h is "неприводим"$
]

#proof[

]

#definition(name: "Расширение поля")[
    $E is "расширение" F$, если $F <= E$. "$E\/F$" — $E "расширяет" F$.

    $E\/F$ называется конечным, если $∞ > dim_F E := [E::F] is "степень" E "над" F$.

    $E →^f E'$
]

#example[
    - $CC\/RR$
    - $RR\/QQ$
    - $QQ[i]\/QQ$
    - $F(x)\/F$
]

#theorem[
$letBe F <= E <= L quad L\/ F < ∞ <==>  E\/F < infinity$, при этом $ [L:F] = [L:E] dot [E:F] $
]

#proof[

#rightImpl
- $E$ — подпространство $F => dim_F E < ∞$
- ${e}_1^n is "базис" L "над" F => {e}_1^n "порождает" L "над" E$

#leftImpl …

]

#def(name: [Подалгебра, порождённая ?])[
    $ E\/F quad S <= E quad F[S] = { sum a_I alpha^I | a_I in F, alpha_I in S} $
]

#lm[$R is "конечная F-алг." quad R is "область целостности" => R is "поле"$]
#proof[
    $a != 0 quad f: R → R quad f(r) = a r$

    - $f in "F-Lin"$
    - $f in "Inj"$
    
    $=>$ $f in "Surj"$, а тогда $exists b$, тч $a b = 1$, значит любой $a != 0$ обратим, значит, это поле.
]

#corollary[
    $E\/F$ — конечное $R is "подалгебра" E => R is "поле"$
]

#def(name: "Простое расширение")[
    $E\/F is "простое" quad E = F(alpha), alpha in E$
]

#def(name: "Композит двух полей")[
    $F, F' <= E quad F(F') = F dot F' = F'(F)$
]

#rm[Поля разных характеристик не могут содержаться в одном поле, так как единица должна лежать и там, и там]



$F[x] in.rev f is$ непрерывны, унитарны.


== Построение циркулем и линейкой

Удалить 