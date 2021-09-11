# latexmk  -synctex=1 -interaction=nonstopmode -file-line-error -lualatex 
# -outdir=d:/Projects/Tests/Chaotic_tests/VS_latex d:/Projects/Tests/Chaotic_tests/VS_latex/main

# lualatex -synctex=1 -interaction=nonstopmode -file-line-error -outdir=d:/Projects/Tests/Chaotic_tests/VS_latex d:/Projects/Tests/Chaotic_tests/VS_latex/main

from script_common.script_commons import *


target_filename = "MathAnal.tex"

compiler = "pdflatex"


latex_args = [
	"-synctex=1",
	"-interaction=nonstopmode",
	"-file-line-error",
	f"-outdir={this_dir}",
	f"{this_dir}/{target_filename}"
]



compile_command = f"latexmk -{compiler} " + " ".join(latex_args)

colored_print(bcolors.OKGREEN, f"Compiling with command: {compile_command}")

exit_data_compile = run_command(compile_command)
exit_data_clear = run_command("latexmk -c")

if exit_data_compile == 0 and exit_data_clear == 0:
	colored_print(bcolors.OKGREEN, f"Successfully compiled!")
	exit(0)
else:
	error_source = "?…"
	exit_data = 0
	if exit_data_compile != 0:
		error_source = "compile"
		exit_data = exit_data_compile
	elif exit_data_clear != 0:
		error_source = "clear temp files"
		exit_data = exit_data_clear

	colored_print(bcolors.FAIL, f"Failed to {error_source}! Exit code: {exit_data}")
	exit(1)
