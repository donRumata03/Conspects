from scripts.compilation_interface import collect_files, compile_file_set
from scripts.script_commons import *

# pandoc '02 - Sortings.md' -f markdown --to=latex --pdf-engine=lualatex -s -o test.pdf

# if len(sys.argv) == 1:
# 	colored_print(bcolors.FAIL, "Provide file name as command line argument!")
# 	exit(1)
#
# target_filename = sys.argv[1]
# extension = Path(target_filename).suffix
# # print(extension)
# assert extension == ".md"
# pure_name = Path(target_filename).stem
# target_folder = Path(target_filename).parent


def compile_one_file(path) -> bool:
	compiler = "lualatex"

	extension = Path(path).suffix
	if extension != ".md":
		print(f"Extension is {extension}, should be md")
	assert extension == ".md"
	pure_name = Path(path).stem
	target_folder = Path(path).parent

	pandoc_args = [
		f"\"{path}\"",
		f"--standalone",
		f"--from=markdown",
		f"--to=latex",
		f"--pdf-engine={compiler}",
		"-V mainfont='Kurale'",
		f"--resource-path=\"{target_folder}\"",
		f"--output=\"{(target_folder / (pure_name + '.pdf')).as_posix()}\"",
	]
	compiling_command = f"pandoc {' '.join(pandoc_args)}"
	colored_print(bcolors.OKGREEN, f"Compiling {Path(path).name} file with command: {compiling_command}")

	comp_start = time.perf_counter()
	exit_code = run_command(compiling_command)
	if exit_code != 0:
		colored_print(bcolors.FAIL, f"Error at compiling Markdown file: {Path(path).name}!")
	else:
		comp_time = time.perf_counter() - comp_start
		colored_print(bcolors.OKGREEN, f"Successfully compiled with {compiler} in {round(comp_time, 1)} seconds!")

	return exit_code == 0


def md_file_should_be_compiled(path: str):
	path_obj = Path(path)
	name = path_obj.stem

	return name.upper() != name


if __name__ == '__main__':
	files_to_compile = collect_files(".md", md_file_should_be_compiled)

	compile_file_set(files_to_compile, compile_one_file)


