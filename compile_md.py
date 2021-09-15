from script_common.script_commons import *

# pandoc '02 - Sortings.md' -f markdown --to=latex --pdf-engine=lualatex -s -o test.pdf

if len(sys.argv) == 1:
	colored_print(bcolors.FAIL, "Provide file name as command line argument!")
	exit(1)

target_filename = sys.argv[1]
extension = Path(target_filename).suffix
# print(extension)
assert extension == ".md"
pure_name = Path(target_filename).stem
target_folder = Path(target_filename).parent

pandoc_args = [
	f"\"{target_filename}\"",
	f"--standalone",
	f"--from=markdown",
	f"--to=latex",
	f"--pdf-engine=lualatex",
	"-V mainfont='Kurale'",
	f"--output=\"{(target_folder / (pure_name + '.pdf')).as_posix()}\"",
]
command = f"pandoc {' '.join(pandoc_args)}"
print(command)

run_command(command)