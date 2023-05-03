// #import "../../../LatexGloves/typst/template.typ": *
// #import "../../../LatexGloves/typst/theorems.typ": *

#import "../../billy_theory.typ": *

 
#show: project.with(
  title: 
  "Практика 9 
(тупые задачи про интегрирование)",
  authors: (vova, english_vova)
)


#counter(heading).update(3)

= Нормальные величины в эллипсоиде

#definition(name: "Нормальные величины в эллипсоиде")[
  Нормальные величины в эллипсоиде — это величины, которые подчиняются нормальному закону распределения, но только внутри эллипсоида. Это как, спросите вы, такое возможно? А вот так: если величина подчиняется нормальному закону распределения, то она подчиняется нормальному закону распределения в любом эллипсоиде. Но вот если величина подчиняется нормальному закону распределения в любом эллипсоиде, то она подчиняется нормальному закону распределения. Так что нормальные величины в эллипсоиде — это величины, которые подчиняются нормальному закону распределения в любом эллипсоиде.
]

#theorem(name: lorem(10))[
  #lorem(50)
]

#pagebreak()

Координаты точки А в пространстве (X, Y, Z) подчинены нормальному закону
$
f(x, y, z)= rho^3 / (pi^(3 / 2) sigma_x sigma_y sigma_z) e^(-rho^2 (x^2 / sigma_x^2 + y^2 / sigma_y^2 + z^2 / sigma_z^2 ))
$

Определить вероятность того, что точка $"A"$ окажется внутри эллипсоида с главными полудиаметрами $k sigma_x, k sigma_y, k sigma_z$.

То есть $E subset RR^3$, $E: A_x^2 / (k sigma_x)^2 + A_y^2 / (k sigma_y)^2 + A_z^2 / (k sigma_z)^2 <= 1 $

#let erf = $op("erf")$

$
integral_E f(x, y, z) dif x dif y dif z = [u = x / sigma_x, v = y / sigma_y, w = z / sigma_z] 

= rho^3 / (pi^(3 / 2) sigma_x sigma_y sigma_z) integral_(u^2 + v^2 + w^2 <= k^2)
 e^(-rho^2 (u^2 + v^2 + w^2 )) dif u dif v dif w = \ 

= mat(delim: "[", r^2 = u^2 + v^2 + w^2; u = r cos psi cos phi; v = r cos psi sin phi; w = r sin psi) = \

rho^3 / (pi^(3 / 2) sigma_x sigma_y sigma_z) integral_(0 <= r <= k) r^2 e^(-rho^2 r^2) dif r integral_(-pi/2 <= psi <= pi/2) cos psi dif psi integral_(-pi <= phi <= pi) dif phi = \

= 2pi rho^3 / (pi^(3 / 2) sigma_x sigma_y sigma_z) integral_(0 <= r <= k) r^2 e^(-rho^2 r^2) dif r integral_(-pi/2 <= psi <= pi/2) cos psi dif psi = \

= 2 dot.c 2 pi rho^3 / (pi^(3 / 2) sigma_x sigma_y sigma_z) integral_(0 <= r <= k) r^2 e^(-rho^2 r^2) dif r = \ 

2 dot.c 2 pi rho^3 / (pi^(3 / 2) sigma_x sigma_y sigma_z) dot.c (sqrt(π) erf(k ρ) - 2 k ρ e^(-k^2 ρ^2))/(4 ρ^3)
$

Стремится к $1$ при $k -> oo$. #link("https://wolfreealpha.on.fleek.co/input?i=series+%28sqrt%28%CF%80%29%2F%284+%28%CF%81%5E2%29%5E%283%2F2%29%29+-+%28sqrt%28%CF%80%29+erf%28k+%CF%81%29+-+2+k+%CF%81+e%5E%28-k%5E2+%CF%81%5E2%29%29%2F%284+%CF%81%5E3%29%29&lang=en")[Скорость сходимости] — как у $erf(k)$:

$
1 - v prop e^(-k^2) (c_1 k + O(1/k))
$



$Bern$



