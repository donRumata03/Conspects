"""

Tensor index ordering notation:

Two there are types of them: internal and external ones.

External: they look on the screen when printed and written in code just like the ones in
mathematical notation by E. Kucheruk.

Internal: index order matches

"""
import math
from fractions import Fraction
from itertools import permutations

import numpy as np


def internalize(t):
	match len(t.shape):
		case 1 | 2:
			return t
		case 3:
			return t.transpose((1, 2, 0))
		case 4:
			return t.transpose()
		case _:
			raise RuntimeError()


def externalize(t):
	match len(t.shape):
		case 1 | 2:
			return t
		case 3:
			return t.transpose((2, 0, 1))
		case 4:
			return t.transpose()
		case _:
			raise RuntimeError()


def print_tensor(t):
	print(externalize(t))
	format_3d_matrix(t)



def input_tensor(t):
	return internalize(t)


S = np.array([[1, 2], [3, 4]])
# print(S.transpose((1, 0)), "\n\n")


M = np.array([  # Internal repr, shape: (1, 2, 3)
	[[1, 2, 3], [4, 5, 6]],
])
# M should look such that major coord is 3, rows are 1 and cols are 2
# But by default it's: major coord is 1, rows are 2 and cols are 3
# So, apply (2, 0, 1)


# print(internalize(externalize(M)), internalize(externalize(M)).shape)

# Mt = M.transpose((2, 0, 1))
# print(Mt, Mt.shape)

A = input_tensor(np.array([
	[
		[-2, 3, 4],
		[3, -1, -4],
		[-1, 2, 2]
	], [
		[3, 6, 0],
		[2, 4, -6],
		[1, -2, 3]
	], [
		[2, 1, 3],
		[1, 0, 2],
		[1, 0, 4]
	]
]))

example_tensor = input_tensor(np.array([
	[
		[1, 3, -4],
		[7, 3, -1],
		[-1, 5, 2]
	], [
		[0, 2, -1],
		[2, 4, 0],
		[-3, 3, 7]
	], [
		[5, -2, 5],
		[3, 2, 1],
		[-2, 1, 1]
	]
]))


def perm_parity(lst):
	"""
		Given a permutation of the digits 0...N in order as a list,
		returns its parity (or sign): +1 for even parity; -1 for odd.
	"""
	parity = 1
	for i in range(0, len(lst) - 1):
		if lst[i] != i:
			parity *= -1
			mn = min(range(i, len(lst)), key=lst.__getitem__)
			lst[i], lst[mn] = lst[mn], lst[i]
	return parity


# print(perm_parity(list((2, 1, 0))))

def symmetrize_tensor(t, ps=None):
	n = len(t.shape)
	if ps is None:
		ps = permutations(range(n))
	ps = list(ps)
	return Fraction(1, len(ps)) * sum([(t + Fraction()).transpose(p) for p in ps])


def alternate_tensor(t, ps=None):
	n = len(t.shape)
	if ps is None:
		ps = permutations(range(n))
	ps = list(ps)
	return Fraction(1, len(ps)) * \
	       sum([Fraction(perm_parity(list(p))) * (t + Fraction()).transpose(p) for p in ps])

def slice_around(indexes, n):
	# Create slices around indexes
	slice_between = [-1] + indexes + [n]
	slices = []
	for i in range(len(slice_between) - 1):
		slices.append(list(range(slice_between[i] + 1, slice_between[i + 1])))
	return slices

# print(slice_around([0, 3, 4], 6))

def interchange_arrays(first, second):
	res = [first[0]]
	for i in range(0, len(second)):
		res.append(second[i])
		res.append(first[i + 1])
	return res

def flatten(lst):
	return [item for sublist in lst for item in sublist]

def permute_index_set(n, permuting_index_set):
	slices = slice_around(permuting_index_set, n)

	raw_ps = permutations(permuting_index_set)
	for p in raw_ps:
		yield flatten(interchange_arrays(slices, [[v] for v in p]))

# print(list(permute_index_set(5, [1, 3, 4])))

def fraction_as_latex(f):
	if f.denominator == 1:
		return str(f.numerator)
	else:
		return f"\\frac{{{f.numerator}}}{{{f.denominator}}}"

# print(fraction_as_latex(Fraction(1, 2)))

def format_3d_matrix(m): # M's internal (right index sequence)
	s = m.shape
	for i in range(s[0]):
		line = []
		for k in range(s[2]):
			for j in range(s[1]):
				line.append(fraction_as_latex(m[i][j][k]))
		print(f"{' & '.join(line)}\\\\")

def solve_tensor(t):
	transposed = t.transpose((2, 1, 0))
	sym = symmetrize_tensor(t)
	alt = alternate_tensor(t)
	partially_sym = symmetrize_tensor(t, permute_index_set(3, [0, 2]))
	partially_alt = alternate_tensor(t, permute_index_set(3, [1, 2]))

	print("\nOriginal:")
	print_tensor(t)

	print("\nTransposed:")
	print_tensor(transposed)

	print("\nSymmetrized:")
	print_tensor(sym)

	print("\nAlternated:")
	print_tensor(alt)

	print("\nPartially symmetrized:")
	print_tensor(partially_sym)

	print("\nPartially alternated:")
	print_tensor(partially_alt)

solve_tensor(A)
print("\n\n\n\n\n")
solve_tensor(example_tensor)

# A = np.array([
# 	[
# 		[[1, 2], [3, 4]],
# 		[[5, 6], [7, 8]]
# 	], [
# 		[[9, 10], [11, 12]],
# 		[[13, 14], [15, 16]]
# 	]
# ])
#
# # print(A)
