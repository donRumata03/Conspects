import numpy as np
import numpy.linalg


def restriction_rank(operator, basis):
	return np.linalg.matrix_rank(np.matmul(np.array(operator), np.array(basis)))

def compute_restriction_ranks_for_powers(operator, basis, max_power):
	ranks = [restriction_rank(numpy.linalg.matrix_power(operator, p), basis) for p in range(max_power)]
	for p in range(max_power):
		print(f"\\rg \\mathfrak{{B}}^{{{p}}} = {ranks[p]}")
	for r in range(1, max_power - 1):
		print(f"d_{r} = {ranks[r - 1] - 2 * ranks[r] + ranks[r + 1]}")


# P:
# compute_restriction_ranks_for_powers([
# 	[-3, 6, 3, 3],
# 	[3, -5, -3, -2],
# 	[-3, 5, 3, 2],
# 	[-6, 11, 6, 5]
# ], [
# 	[1, 0, 0, 0],
# 	[0, 1, 0, 0],
# 	[0, 0, 1, 0],
# 	[0, 0, 0, 1]
# ], 6)

# Q:
# compute_restriction_ranks_for_powers([
# 	[-26, -39, 65, 13],
# 	[-18, -27, 45, 9],
# 	[-16, -24, 40, 8],
# 	[-26, -39, 65, 13]
# ], [
# 	[1, 0, 0, 0],
# 	[0, 1, 0, 0],
# 	[0, 0, 1, 0],
# 	[0, 0, 0, 1]
# ], 6)
#

# V, -11:
# compute_restriction_ranks_for_powers([
# 	[6, 8, 4, -10],
# 	[5, 4, 8, -5],
# 	[0, -4, 4, 4],
# 	[2, 8, 4, -6]
# ], np.array([
# 	[1, 2, 0, 1],
# 	[-4, -4, 1, -4]
# ]).transpose(), 6)
#

# W, 3
compute_restriction_ranks_for_powers([
	[-2, 2, -4, -4],
	[10, -4, 10, 8],
	[-2, 2, -4, -4],
	[4, -4, 10, 8]
], np.array([
	[0, 2, 0, 1],
	[2, 16, 6, 1]
]).transpose(), 6)

