# Ignore (don't compile) README.md files
# tex and md files in {./DIR/}, DIR in decryption directories are committed separately for each directory with message about being conspect
# files in subdirs of dirs in «decryption» dict are committed in groups by full directory paths, the paths participate in messages
# Other paths are committed together. If there are .py files, it's written «…including python scripts».
# If there (not in DIR € decryption or its subdirs) are almost only python files (n_python ≈100%n_files and no files are .tex or .md), it's


from scripts.script_commons import *

from git import Repo

################################################					Settings: 			##############################

subject_decryption = {
	"Analgorithms": "Algorithms and data structures",
	"CUMputerAAAAAAAAH": "Computer architecture",
	"DICKreteMath": "Discrete mathematics",
	"LinAnalgebra": "Linear algebra",
	"MathAnalgeBRUH": "Mathematics anal"
}

special_dir_decryption = {
	"LatexGloves": "templates for LaTeX",
	"Fonts": "some magic with fonts",
	"Docs": "documentation of something",
	"scripts": "compiling/committing script commons"
}

extension_decryption = {
	".py": "compiling/committing script",
	".md": "Markdown conspect",
	".tex": "LaTeX conspect",
	".pdf": "Compiled conspect",
	".png": "Image"
}

extensions_for_compilation = {
	".tex": "compile_latex.py",
	".md": "compile_md.py"
}

updating_phrases = [
	"Update",
	"Work on",
	"Modify",
	"Commit changes into",
	"Edit"
]


def compile_file(path) -> bool:
	ext = Path(path).suffix
	assert ext in extensions_for_compilation

	compiler_script = extensions_for_compilation[ext]
	exit_code = run_python_script(compiler_script, path)
	if exit_code != 0:
		colored_print(bcolors.FAIL, f"[Committer] STRONG WARNING: Couldn't compile {ext} file \"{path}\"")
	return exit_code == 0


rep = Repo(conspects_root_dir)

changed_files = [item.a_path for item in rep.head.commit.diff(None)]

# Filter only files for compilation:
files_to_compile = [
	file
	for file in changed_files
	if Path(file).suffix in extensions_for_compilation and Path(file).name != " README.md"
]
print(changed_files)
print(f"Files to (re)compile: {files_to_compile}")

# COMPILE files:
compiled_at_least_something_successfully = False
for source in files_to_compile:
	colored_print(bcolors.OKGREEN, f"Compiling {source}…")
	compiled_at_least_something_successfully |= compile_file(source) # Writing would trigger short-circuit and some files wouldn't be compiled :)


if "--all" in sys.argv[1:]:  # Compile and commit all files at once with name provided:
	not_option_ids = [s for s in sys.argv[1:] if s and s[0] != "-"]
	if len(not_option_ids) != 1:
		colored_print(bcolors.FAIL, "[Committer] incorrect CLI arguments: regime --all chosen "
		                            "but there are more than one non-option arguments!")
		exit(1)

	commit_message = not_option_ids[0]
	colored_print(bcolors.OKGREEN, "Committing all files with message:", commit_message)

	# Track all files:
	rep.git.add(all=True)
	# Commit with given message:
	rep.git.commit(m=commit_message)

else:
	# Subsequently processing different file categories
	# Those thing have special meaning:
	# - DIR € decryption
	# - ./DIR/.../.../... DIR € decryption
	# - .py files in other places


	# 1. MD and LaTeX files in DIR € decryption
	print(files_to_compile)
	print("Committing primary conspects: ")
	primary_conspects, changed_files = split(changed_files, lambda path: print(path))
	exit(0)

# Separate commit for compiled files:
if compiled_at_least_something_successfully:
	compiled_pdfs = [item.a_path for item in rep.head.commit.diff(None) if Path(item.a_path).suffix == ".pdf"]
	compiled_names = [Path(path).name for path in compiled_pdfs]

	rep.git.add(all=True)
	rep.git.commit(m=f"Compile these conspects: {','.join(compiled_names)}")
