#import "../LatexGloves/typst/template.typ": *
#import "../LatexGloves/typst/theorems.typ": *

#import "@preview/big-todo:0.2.0": *

// #import "@preview/rose-pine:0.1.0": apply, rose-pine-dawn, rose-pine-moon, rose-pine

// Define GF
#let GF = "GF"

#show: project.with(
  title:
  "Теория чисел  (теория)",
  authors: (vova, english_vova),
  which-rose-pine: rose-pine-moon
)

= Базовые определения

Кодер источника — убирает избыточность (например, архиватор или jpeg), может быть с потерями.

Кодер канала — вносит контроллируемую избыточность.

Канал — вероятностная модель передачи данных, определяется $P(Y | X)$, где $X$ — данные, непосредственно передающиеся, $Y$ — принимаемые данные на выходе канала.

== Декодирование
- По критерию идеального наблюдателя: минимизация $P_e$ за счёт выбора в каждой точке $x$, наиболее вероятного при условии $y$ (т.е. $max_x p(x | y)$).
- По максимуму правдоподобия — выбор для $x$ области, где его правдоподобие $p(y | x)$ выше других $x$: $max_x p(y | x)$.

При $P(x) = "const"$ критерии эквивалентны.


== Отношение сигнал-шум

$E_s = alpha^2$

$P_"noise" ~ sigma^2 = N_0 / 2$ ($N_0$ — спектральная плотность мощности шума, берём половину, т.к. комплексная часть не интересует)

На символ: $E_s / N_0$

На бит: $E_b / N_0 = E_s / (N_0  R)$

Принято измерять в децибелах: $10 log_10 (E_b / N_0)$

Для 2-АМ: $P_e = Q(sqrt(2 E_b / N_0))$

== Код

#definition(name: "Код")[Множество $cal(C)$ допустимых кодовых последвоательностей алфавита $X$ (на практике — они блоковые)]

#definition(name: "Кодер")[Отображение $cal(B)^n arrow.r.hook cal(C)$]

#definition(name: "Скорость кода")[Отношение длины кодовой и исходной последовательностей]

== Дублирование

Если $m$ раз продублировать каждый символ, то $P_e = Q(sqrt(2 m E_b / N_0))$, но $R = 1 / m$, т.ч. если смотреть в пересчёте на бит — прироста нет.

== Теоремы Шеннона

Есть трейдофф между скоростью и ошибками.

#theorem(name: "Прямая теорема Шеннона")[Оказывается, что со скоростью, сколь угодно близкой к $C$, но меньшей $C$ можно достигать сколь угодно малые $P_e$ начиная с некоторой длина блока кода.]

#theorem(name: "Обратная теорема Шеннона")[Если $R > C$, то $P_e$ ограничена снизу.]

т.е. теоретический результат идеален. Теорема не конструктивна, но знаем, как достичь. Но:
- декодеры неэффективны
- конкретные (не асимптотические) вероятности ошибок плохие

btw случайные коды реализуют теорему Шеннона ;)

Пропускная способность канала — $ C = max_P(x) I(X; Y) $, где $I(X; Y) = H(Y) - H(Y | X)$ — _определяется через свойства канала_.

Источники субоптимальности:
- конечность длины блока
- несовершенство кода
- субоптимальность декодера
- дискретизация выхода канала

== Жёсткое vs мягкoе декодирование

Жёсткое — декодер использует жёсткие оценки для каждого символа.
- Тогда АБГШ → BSC

Мягкое — декодер использует вероятности для каждого символа/напрямую принятое значение.

== Спектральная эффективность

$beta = R / W$ — число бит на Гц ширины спектра.


== Декодирования

Списочное декодирование — декодер возвращает не один, а несколько вариантов.

Побитовое — часто используются $L_i$ — лог. отношения правдоподобия — логарифм отношения вероятности всех слов с 1-цей ко всем словам с нулём на этой позиции.
_То есть зависит и от остальных прянятых символов_. Используется

== Критерий минимального расстояня: выбор ближайшего кодового слова к принятому.




= Блоковые коды

Если минимальное расстояние — $d$:
- Внутри шара радиуса $d - 1$ нет других кодовых слов
  → Находит $d - 1$ ошибок
- Шары радиуса $floor((d - 1) / 2)$ не пересекаются
  → Исправляет $floor((d - 1) / 2)$ ошибок


= Линейные коды

q-ичный код $(n, k, d)$ — k-мероное подпространство $"GF"(q)^n$ с минимальным расстоянием $d$.

Можно задать порождающей матрицей $G in GF^(k×n)$, код — "образ" — все линейные комбинации строк $G$.

Можно задать проверочной матрицей $H in GF(q)^(r×n), " т.ч." r >= n - k = "rank" H$, код — её "ядро" $H x^T = 0 <==> x H^T = 0$.

Столбцы H — это базис ортогонального дополнения к коду, т.е. $G H^T = 0$.

Домножение слева на обратимую матрицу не меняет кода.

Домножение G справа на перестановочную переставляет сигнальные символы $isdef$ коды эквивалентны.

== Систематическое кодирование
$G = (I_k | A)$, где $I_k$ — единичная матрица.
Проверочная матрица к ней: $H = (A^T | -I_(n - k))$.

Любой код можно привести к систематическому виду с точностью до эквивалетного: операциями над строками + перестановой столбцов.

== Размерность и расстояние кода по проверочной матрице

== Граница Синглтона

$n - k >= d - 1$

== Код Хэминга

== Синдромное декодирование

У каждого класса смежности $GF(q)^n$ по аддитивной подгруппе кода — находим вектор ошибок минимального веса.

Классы определяются синдромом — $s = y H^T = (x + e) H^T = u underbrace(G H^T, 0) + e H^T = e H^T$.
