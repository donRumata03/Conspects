# latexmk  -synctex=1 -interaction=nonstopmode -file-line-error -lualatex 
# -outdir=d:/Projects/Tests/Chaotic_tests/VS_latex d:/Projects/Tests/Chaotic_tests/VS_latex/main

# lualatex -synctex=1 -interaction=nonstopmode -file-line-error -outdir=d:/Projects/Tests/Chaotic_tests/VS_latex d:/Projects/Tests/Chaotic_tests/VS_latex/main


import glob

from script_common.compilation_interface import collect_files, compile_file_set
from script_common.script_commons import *

compiler = 'xelatex'


def compile_one_file(path) -> bool:
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
		f"-outdir={file_dir}",
		f"{path}"
	]

	compiling_command = f"latexmk -{compiler} " + " ".join(latex_args)
	colored_print(bcolors.OKGREEN, f"Compiling with command: {compiling_command}")

	comp_start = time.perf_counter()
	exit_code = run_command(compiling_command)
	comp_time = time.perf_counter() - comp_start
	if exit_code != 0:
		colored_print(bcolors.FAIL, f"Error at compiling latex file: {Path(path).name}!")
		# return False
	else:
		colored_print(bcolors.OKGREEN, f"Successfully compiled with {compiler} in {round(comp_time, 1)} seconds!")


	print("__________________________________________________________________")
	# Clear typical latex tempFiles:
	# print([f"{file_dir}/{ext}" for ext in latex_temp_extensions])
	temp_files = sum([glob.glob(f"{file_dir}/{ext}") for ext in latex_temp_extensions], [])
	print(f"'{file_name}' LaTeX file's compilation finished ==> clearing temp files:", temp_files)
	for tf in temp_files:
		os.remove(tf)

	return exit_code == 0


if __name__ == '__main__':
	files_to_compile = collect_files(".tex")
	compile_file_set(files_to_compile, compile_one_file)

# compile_one_file("D:/Projects/Education/Conspects/LinAnalgebra/LinearAlgebra.tex")



# compile_command = f"latexmk -{compiler} " + " ".join(latex_args)
#
# colored_print(bcolors.OKGREEN, f"Compiling with command: {compile_command}")
#
# exit_data_compile = run_command(compile_command)
# exit_data_clear = run_command("latexmk -c")
#
# if exit_data_compile == 0 and exit_data_clear == 0:
# 	colored_print(bcolors.OKGREEN, f"Successfully compiled!")
# 	exit(0)
# else:
# 	error_source = "?…"
# 	exit_data = 0
# 	if exit_data_compile != 0:
# 		error_source = "compile"
# 		exit_data = exit_data_compile
# 	elif exit_data_clear != 0:
# 		error_source = "clear temp files"
# 		exit_data = exit_data_clear
#
# 	colored_print(bcolors.FAIL, f"Failed to {error_source}! Exit code: {exit_data}")
# 	exit(1)
