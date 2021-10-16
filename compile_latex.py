# latexmk  -synctex=1 -interaction=nonstopmode -file-line-error -lualatex 
# -outdir=d:/Projects/Tests/Chaotic_tests/VS_latex d:/Projects/Tests/Chaotic_tests/VS_latex/main

# lualatex -synctex=1 -interaction=nonstopmode -file-line-error -outdir=d:/Projects/Tests/Chaotic_tests/VS_latex d:/Projects/Tests/Chaotic_tests/VS_latex/main


import glob
from typing import Optional, Union, Tuple

from scripts.compilation_interface import collect_files, compile_file_set
from scripts.script_commons import *

compiler = 'xelatex'


def compile_one_file(path, show_compiler_output=True) -> Tuple[bool, float]:
	file_dir = Path(path).parent.absolute()
	file_name = Path(path).name

	latex_temp_extensions = [
		"*.aux",
		"*.bbl",
		"*.blg",
		"*.idx",
		"*.ind",
		"*.lof",
		"*.lot",
		"*.out",
		"*.toc",
		"*.acn",
		"*.acr",
		"*.alg",
		"*.glg",
		"*.glo",
		"*.gls",
		"*.fls",
		"*.log",
		"*.fdb_latexmk",
		"*.snm",
		"*.synctex(busy)",
		"*.synctex.gz(busy)",
		"*.nav",
		"*.xdv",
		"*.dvi",
		".*ps",

		# Files with this extension can be useful after compilation
		# but can't be - for github users => remove it after commit

		"*.synctex",
		"*.synctex.gz"
	]

	latex_args = [
		"-synctex=1",
		"-interaction=nonstopmode",
		"-file-line-error",
		f"-outdir=\"{file_dir}\"",
		f"\"{path}\""
	]

	compiling_command = f"latexmk -{compiler} " + " ".join(latex_args)
	colored_print(console_colors.OKGREEN, f"Compiling with command: {compiling_command}")

	comp_start = time.perf_counter()
	exit_code = run_command(compiling_command)
	comp_time = time.perf_counter() - comp_start
	if exit_code != 0:
		colored_print(console_colors.FAIL, f"Error at compiling latex file: {Path(path).name}!")
		# return False
	else:
		colored_print(console_colors.OKGREEN, f"Successfully compiled with {compiler} in {round(comp_time, 1)} seconds!")

	blue_divider()

	# Clear typical latex tempFiles:
	# print([f"{file_dir}/{ext}" for ext in latex_temp_extensions])

	temp_files = sum([glob.glob(f"{file_dir}/{ext}") for ext in latex_temp_extensions], [])
	print(f"'{file_name}' LaTeX file's compilation finished ==> clearing temp files:", temp_files)
	for tf in temp_files:
		os.remove(tf)

	return exit_code == 0, comp_time


def latex_file_should_be_compiled(path: str):
	latex_template_files = [os.path.normpath(os.path.join(conspects_root_dir, p)) for p in [
		"LatexGloves/latex_math_header.tex",
	]]

	return os.path.normpath(path) not in latex_template_files


if __name__ == '__main__':
	files_to_compile = collect_files(".tex", latex_file_should_be_compiled)
	compile_file_set(files_to_compile, compile_one_file)
