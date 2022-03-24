import itertools
import math

import numpy as np
from sympy import poly, factor, Poly, latex, factor_list, degree
from sympy import lcm
from sympy.abc import x, t

F = np.array([[0, -10, 3, -5],
              [-4, 12, -6, 4],
              [4, 20, -4, 10],
              [12, 0, 6, 4]])

G = np.array(
    [
        [-22, 20, 4, -36],
        [22, 4, 10, 12],
        [5, -19, -9, 24],
        [27, -13, 3, 34]
    ]
)

P = np.array(
    [
        [-4, 6, 3, 3],
        [3, -6, -3, -2],
        [-3, 5, 2, 2],
        [-6, 11, 6, 4]
    ]
)

Q = np.array(
    [
        [-26, -39, 65, 13],
        [-18, -27, 45, 9],
        [-16, -24, 40, 8],
        [-26, -39, 65, 13]
    ]
)

V = np.array(
    [
        [-5, 8, 4, -10],
        [5, -7, 8, -5],
        [0, -4, -7, 4],
        [2, 8, 4, -17]
    ]
)

W = np.array(
    [
        [1, 2, -4, -4],
        [10, -1, 10, 8],
        [-2, 2, -1, -4],
        [4, -4, 10, 11]
    ]
)

a = W

e1 = np.array([1, 0, 0, 0])
e2 = np.array([0, 1, 0, 0])
e3 = np.array([0, 0, 1, 0])
e4 = np.array([0, 0, 0, 1])


current_lcm = poly(1, t)

for e, l in ((e1, 0), (e2, 1), (e3, 2), (e4, 3)):
    f0 = e.transpose()
    f1 = (a * e)[:, l]
    f2 = (np.linalg.matrix_power(a, 2) * e)[:, l]
    f3 = (np.linalg.matrix_power(a, 3) * e)[:, l]
    f4 = (np.linalg.matrix_power(a, 4) * e)[:, l]

    # print(f1, f2, f3, f4)

    rank = np.linalg.matrix_rank(np.array([f0.transpose(), f1.transpose(), f2.transpose(), f3.transpose()]))
    if rank == 2:
        print(f0, f1, f2, r"\\")
        for p in itertools.combinations([0, 1, 2, 3], 2):
            try:
                x = np.linalg.solve(
                    np.array([[f0[i] for i in p], [f1[i] for i in p]]).transpose(),
                    np.array([[f2[i] for i in p]]).transpose()
                )
            except np.linalg.LinAlgError:
                pass
    if rank == 3:
        print(f0, f1, f2, f3, r"\\")
        for p in itertools.combinations([0, 1, 2, 3], 3):
            try:
                x = np.linalg.solve(
                    np.array([[f0[i] for i in p], [f1[i] for i in p], [f2[i] for i in p]]).transpose(),
                    np.array([[f3[i] for i in p]]).transpose()
                )
            except np.linalg.LinAlgError:
                pass

    if rank == 4:
        print(f0, f1, f2, f3, f4, r"\\")
        x = np.linalg.solve(np.array([f0[:], f1[:], f2[:], f3[:]]).transpose(), np.array([f4[:]]).transpose())

    this_poly_coefficients = [1.] + [-float(alpha[0]) for alpha in x][::-1]
    assert all([math.isclose(c, round(c), rel_tol=1e-9, abs_tol=0.0001) for c in this_poly_coefficients])
    int_coeff = [round(c) for c in this_poly_coefficients]
    this_poly = Poly(int_coeff, t, domain="Z")
    current_lcm = lcm(current_lcm, this_poly)
    dg = degree(current_lcm, gen=t)

    print(f"Processed vector №{l + 1}. Rank: {rank}\\\\")
    print(f"Got this coefficients: {int_coeff}\\\\")
    print(f"This polynom is: ${latex(this_poly)}$\\\\")
    print(f"Current LCM is: ${latex(current_lcm)}$\\\\")
    ra = "$\\Rightarrow$"
    print(f"Its degree is {dg}{'…' if dg < 4 else f' {ra} stop!'}")
    print()
    if dg == 4:
        break

    # this_poly_string = " + ".join([f"{coeff} * t^{i}" for (i, coeff) in enumerate(this_poly_coefficients)])
    # print(this_poly, latex(this_poly), factor_list(this_poly))
    #
    #
    #
    # print(current_lcm, degree(current_lcm, gen=t))


    # for pw in range()

# print(factor_list(current_lcm))
print(f"\\begin{{equation}}{latex(factor_list(current_lcm))}\\end{{equation}}")