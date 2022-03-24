import itertools

import numpy as np

a = np.array([[0, -10, 3, -5],
              [-4, 12, -6, 4],
              [4, 20, -4, 10],
              [12, 0, 6, 4]])
e1 = np.array([1, 0, 0, 0])
e2 = np.array([0, 1, 0, 0])
e3 = np.array([0, 0, 1, 0])
e4 = np.array([0, 0, 0, 1])

for e, l in ((e1, 0), (e2, 1), (e3, 2), (e4, 3)):
    f0 = e.transpose()
    f1 = (a * e)[:, l]
    f2 = (np.matmul(a, a) * e)[:, l]
    f3 = (np.matmul(np.matmul(a, a), a) * e)[:, l]
    f4 = (np.matmul(np.matmul(a, a), np.matmul(a, a)) * e)[:, l]

    rank = np.linalg.matrix_rank(np.array([f0.transpose(), f1.transpose(), f2.transpose(), f3.transpose()]))
    if rank == 2:
        print(f0, f1, f2)
        for p in itertools.combinations([0, 1, 2, 3], 2):
            try:
                x = np.linalg.solve(
                    np.array([[f0[i] for i in p], [f1[i] for i in p]]).transpose(),
                    np.array([[f2[i] for i in p]]).transpose())
            except np.linalg.LinAlgError:
                pass
        print(x)
    if rank == 3:
        print(f0, f1, f2, f3)
        for p in itertools.combinations([0, 1, 2, 3], 3):
            try:
                x = np.linalg.solve(
                    np.array([[f0[i] for i in p], [f1[i] for i in p], [f2[i] for i in p]]).transpose(),
                    np.array([[f3[i] for i in p]]).transpose())
            except np.linalg.LinAlgError:
                pass
        print(x)

    if rank == 4:
        print(f0, f1, f2, f3, f4)
        print(np.linalg.solve(np.array([f0[:], f1[:], f2[:], f3[:]]).transpose(), np.array([f4[:]]).transpose()))
        break
    print('')
