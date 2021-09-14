from script_common.script_commons import *

# pandoc '02 - Sortings.md' -f markdown --to=latex --pdf-engine=lualatex -s -o test.pdf

target_filename = sys.argv[1:]

pandoc_args = [
	""
]

run_command(f"pandoc {' '.join(arguments)}")