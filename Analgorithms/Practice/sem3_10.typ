#import "../algo.typ": *

 
#show: project.with(
  title: 
  "ДЗ 10 
(криптография и теория чисел)"
)

#counter(heading).update(3)

= …

$
phi(n) = (p-1)(q-1) = p q - q - p + 1\
n = p q\
n - phi(n) = p + q - 1\
p = n/q\
n/q+q-1= n - phi(n)\
n/q+q - 1 -(n - phi(n)) = 0\
n+q^2 -q(1 - (n - phi(n))) = 0\
a = 1, b = -(1 - (n - phi(n))), c = n\
D = b^2 - 4 a c\
q = (-b +- sqrt(D)) / 2a\
q = ((1 - (n - phi(n))) +- sqrt((1 - (n - phi(n)))^2 - 4n)) | 2\
p = N/q
$

#counter(heading).update(17)

= $gcd$ декомпозиция таблицы


#statement[
 Дана таблица $d[i, j]$. Построить массивы $a$ и $b$ такие, что $gcd(a_i, b_j) = d[i, j]$.
]

Заметим, что $
cases(
  forall j: a_i dots.v d[i, j] =>  a_i = c limits(op("lcm"))_(k in [1, n]) d[i, k],
  forall i: b_j dots.v d[i, j] =>  b_j = c limits(op("lcm"))_(k in [1, n]) d[k, j]
)
$

Возьмём $c := 1$ везде. Пройдёмся по таблице и проверим, что $gcd(a_i, b_j) = d[i, j]$.

- Всегда верно, что $gcd(a_i, b_j) >= d[i, j]$, так как $a_i$ и $b_j$ оба делятся на $d[i, j]$.
- Если нашлось $d[i, j]$, для которого $gcd(a_i, b_j) > d[i, j]$, задача не имеет решения, так как это неравенство останется для любого выбора $c$-шек.
