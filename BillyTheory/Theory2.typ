#import "billy_theory.typ": *

 
#show: project.with(
  title: 
  "Теоретический конспект по теорверу"
//   font: "Victor Mono"
)

// \section{Числовые характеристики случайных величин}

// \begin{definition}
//     Пусть $X$ — случайная величина. Тогда её математическим ожиданием называется число
//     \begin{equation}
//         \E X = \int_{\sR} x \d P_X(x)
//     \end{equation}
// \end{definition}

// Rewrite in typst ↑↑

= Об инегралах

Можно рассматривать функции от случайных векторов. Если $g: RR^n → RR$, то $g(X)$ — случайная величина.

Более того, можно интегрировать эту штуку по вероятностному пространству $Omega$:

$
    integral_Omega g(X(omega)) P(dif omega) = 
    integral_(RR^n) g(x) P_X(dif x)
$

Forward measure — мера при отображении.

#theorem(name: "Фубини")[
    Пусть $X$ — случайный вектор в $RR^n$, $g: RR^n → RR$ — борелевская функция. Тогда
    $
        integral g(x, y) P_(X, Y)(dif x, dif y) = integral [ integral g(x, y) dif F_Y(y) ] dif F_X(x) = \ = integral [ integral g(x, y) dif F_X(x) ] dif F_Y(y)
    $ (один интеграл — по Forward measure, другой — по мере Лебега-Стилтьеса)
]


= Числовые характеристики случайных величин

#definition[
    Пусть $X$ — случайная величина. Тогда её математическим ожиданием называется число
    $
        EE X = integral_RR x dif F_X(x)
    $
    (интеграл Лебега-Стилтьеса)
]

#remark[
    Если $X$ — дискретная случайная величина, то
    $
        EE X = sum_(x in RR) x P_X(x)
    $
]

#remark[
    Если $X$ — абсолютно непрерывная случайная величина, то
    $
        EE X = integral_RR x p_X(x) dif x
    $
]

#property(name: "Функция от случайной величины")[
    $g: RR → RR$ — борелевская функция, $X$ — случайный вектор. Тогда $
    EE underbrace(g(X_1, …, X_n), Y) = integral y dif F_Y(y) =
     integral_(RR^n) g(x_1, …, x_n) P_(dif x_1, …, dif x_n)
     $
]

#property(name: "Линейность")[
    $EE (a X + b Y) = a EE X + b EE Y$
]

#property(name: "Неотрицательность")[
    - $X >= 0$ почти наверное $=> EE X >= 0$.
    - $X >= 0, EE X = 0 => X = 0$ почти наверное.
]

#property(name: "Монотонность")[
    $X <= Y$ почти наверное, то $EE X <= EE Y$
]

#property(name: "Матожидание произведения независимых случайных величин")[
    $EE X Y = EE X EE Y$
]


#theorem(name: "Неравенство Маркова")[
    Пусть $X$ — неотрицательная случайная величина, $exists EE X$, $a > 0$. Тогда
    $
        P(X >= a) <= (EE X) / a
    $
]
#proof[
    $
        EE X = integral_0^∞ x p_X(x) dif x >= integral_a^∞ a p_X(x) dif x >= a integral_a^∞ p_X(x) dif x = a P(X >= a)
    $
]

#property[
    $EE X = integral_0^∞ P(X >= x) dif x$ для абсолютно непрерывных случайных величин.

    $EE X = sum_(x in RR) P(X >= x)$ для дискретных случайных величин.
]

 
#definition[
    Пусть $X$ — случайная величина. Тогда её дисперсией называется число
    $
        Var X = DD X = EE (X - EE X)^2
    $

    Стандартным отклонением случайной величины $X$ называется число $sigma_X = sqrt(Var X)$.
    Она часто используется вместо дисперсии, потому что она имеет ту же размерность, что и $X$.
]

#property(name: "Неотрицательность")[
    $Var X >= 0$
]

#property(name: "Связь с матожиданием")[
    $Var X = EE X^2 - (EE X)^2$
]


#property(name: "Квадратичная однородность")[
    $Var (a X + b) = a^2 Var X$
]


#property(name: "Дисперсия суммы (разности)")[
    $
    Var (X ± Y) = Var X + Var Y ± 2 Cov(X, Y)
    $ (для независимых случайных величин $Cov(X, Y) = 0$)
]

#property(name: "Нулевая дисперсия и константность")[
    $Var X = 0 <=> X = C$ почти наверное
]


#theorem(name: "Неравенство Чебышёва")[
    Пусть $X$ — случайная величина, $exists EE X, Var X$, $a > 0$. Тогда
    $
        P(|X - EE X| >= a) <= (Var X) / a^2
    $
]
#proof[
    $
        P(|X - EE X| >= a) = P((X - EE X)^2 >= a^2) <= (EE (X - EE X)^2) / a^2 = (Var X) / a^2
    $
]


#definition[
    Пусть $X$ — случайная величина. Тогда для $alpha in (0, 1)$
    $
        q_alpha — "квантиль порядка" alpha — "число, такое что" cases(
            P(x >= q_alpha) >= 1 - alpha,
            P(x <= q_alpha) >= alpha
        )
    $
]

Для непрерывной случайной величины $X$ квантиль порядка $alpha$ — это решение уравнения $F_X(x) = alpha$. Если $F_X$ строго возрастает, то $q_alpha = F_X^(-1)(alpha)$.

Для дискретной случайной величины $X$ квантиль порядка $alpha$ — это минимальное $x$, такое что $P_X(x) >= alpha$.

#definition[
    Медиана случайной величины $med X$ — это квантиль порядка $1/2$.
]

#theorem[
    $
    med X = limits(argmin)_(x in RR) EE |X - x|
    $
]

Матожидание тоже кое-что оптимизирует, но не так круто.

#theorem[
    $
    EE X = limits(argmin)_(x in RR) EE (X - x)^2
    $
]

Почему не так круто, спросите вы? Потому что матожидание — это не медиана, а среднее. А среднее — это для средних, посредственных людей. А медиана — это для лучших. © Copilot


#definition[
    Момент порядка $k$ случайной величины $X$ — это число $EE X^k$.
]

#definition[
    Центральный момент порядка $k$ случайной величины $X$ — это число $EE (X - EE X)^k$.
]

#definition[
    Абсолютный момент порядка $k$ случайной величины $X$ — это число $EE |X|^k$.
]

#definition[
    Абсолютный центральный момент порядка $k$ случайной величины $X$ — это число $EE |X - EE X|^k$.
]

#example[
    Коэфициент асимметрии случайной величины $X$ — это, с точностью до коэфициента, центральный момент порядка $3$: $EE (X - EE X)^3 / sigma^3$.

    Коэфициент эксцесса случайной величины $X$ — это, с точностью до коэфициента, центральный момент порядка $4$: $EE (X - EE X)^4 / sigma^4 - 3$. Минус три потому что мы хотим, чтобы эксцесс нормального распределения был нулевой.
]

#definition[
    Мода случайной величины $X$ — это число $argmax_(x in RR) p_X(x)$.

    Если мода одна, то говорят, что случайная величина $X$ унимодальна.
]


#definition[
    Ковариация случайных величин $X$ и $Y$ — это число $Cov(X, Y) = EE (X - EE X) (Y - EE Y)$.
]

#property[
    $Cov(X, Y) = EE X Y - EE X EE Y$, то есть для независимых случайных величин $Cov(X, Y) = 0$. (Но обратное неверно: если $Cov(X, Y) = 0$, то случайные величины могут быть зависимыми)
]

#property[
    $Cov(X, X) = Var X$.
]

#property(name: "Симметричность")[
    $Cov(X, Y) = Cov(Y, X)$.
]

#property(name: "Билинейность")[
    $Cov(a X + b, Y) = a Cov(X, Y)$.
]




