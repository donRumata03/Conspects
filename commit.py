# Ignore (don't compile) README.md files
# tex and md files in {./DIR/}, DIR in decryption directories are committed separately for each directory with message about being conspect
# files in subdirs of dirs in «decryption» dict are committed in groups by full directory paths, the paths participate in messages
# Other paths are committed together. If there are .py files, it's written «…including python scripts».
# If there (not in DIR € decryption or its subdirs) are almost only python files (n_python ≈100%n_files and no files are .tex or .md), it's
import itertools
from typing import Tuple

from scripts import compilation_interface
from scripts.script_commons import *

from git import Repo

import compile_latex, compile_md

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
	".md": "Markdown source",
	".tex": "LaTeX source",
	".pdf": "Compiled conspect",
	".png": "Image"
}

compiling_script_by_extension = {
	".tex": "compile_latex.py",
	".md": "compile_md.py"
}
compiling_function_by_extension = {
	".tex": compile_latex.compile_one_file,
	".md": compile_md.compile_one_file
}

updating_phrases = [
	"Update",
	"Work on",
	"Modify",
	"Commit changes into",
	"Edit"
]


def compile_file(path) -> Tuple[bool, float]:
	ext = Path(path).suffix
	assert ext in compiling_function_by_extension

	compiler_function = compiling_function_by_extension[ext]
	compilation_output = compiler_function(path)
	if not compilation_output[0]:
		colored_print(bcolors.FAIL, f"[Committer] STRONG WARNING: Couldn't compile {ext} file \"{path}\"")
	return compilation_output



def describe_file_formats(file_list: List[str]):
	return ",".join([(extension_decryption[ext] if ext in extension_decryption else f"{ext} file")
	                 + ("s" if len(list(files)) > 1 else "")
	                 for ext, files in it.groupby(file_list, lambda path: Path(path).suffix)])


# Predicates for grouping files:

def file_in_topic_subdir(path, topic_dirs):
	p = Path(path).parts
	return p and Path(p[0]).is_dir() and p[0] in topic_dirs

def file_in_subj_subdir(path):
	return file_in_topic_subdir(path, subject_decryption)


def file_is_conspect_source_in_decryption_subfolder(path: str):
	return file_in_subj_subdir(path) and Path(path).suffix in {".tex", ".md"}


def file_is_conspect_source_in_decryption(path: str):
	return file_is_conspect_source_in_decryption_subfolder(path) and len(Path(path).parts) == 2


def in_template_subdir(path):
	p = Path(path)
	return p and Path(p[0]).is_dir() and p[0] == "LatexGloves"


def is_pdf_associated_with_source(path: str):
	p = Path(path)
	return p.suffix == ".pdf" and \
	       p.stem in [pretendent.stem for pretendent in p.parent.iterdir() if
	                  pretendent.suffix in compiling_script_by_extension]


# print(is_pdf_associated_with_source("LinAnalgebra/LinearAlgebra.pdf"))
# print(is_pdf_associated_with_source("LinAnalgebra/LinearAlgebra.tex"))
# print(is_pdf_associated_with_source("LinAnalgebra/PhysTech_vector_products.pdf"))


rep = Repo(conspects_root_dir)
last_commit_before_launch = rep.commit()

changed_files = [item.a_path for item in rep.head.commit.diff(None) if not is_pdf_associated_with_source(item.a_path)]

# Filter only files for compilation:
files_to_compile = [
	file
	for file in changed_files
	if Path(file).suffix in compiling_script_by_extension and Path(file).stem.upper() != Path(file).stem
]
print_green(f"[Committer] Changed files: {changed_files}")
print_green(f"[Committer] Files to (re)compile: {files_to_compile}")

# COMPILE files:
# TODO: use compilation_interface.compile_file_set function to compile!

# successfully_compiled_files = 0
# for source in files_to_compile:
# 	colored_print(bcolors.OKGREEN, f"Compiling {source}…")
# 	successfully_compiled_files += 1 if compile_file(source) else 0

successful_files, all_files = compilation_interface.compile_file_set(files_to_compile, compile_file)
successfully_compiled_files_n = len(successful_files)

print_green(f"[Committer] Compiled everything possible and required ({successfully_compiled_files_n}/{len(files_to_compile)} successful)")

if "--all" in sys.argv[1:]:  # Compile and commit all files at once with name provided:
	not_option_ids = [s for s in sys.argv[1:] if s and s[0] != "-"]
	if len(not_option_ids) != 1:
		print_red("[Committer] incorrect CLI arguments: regime --all chosen "
		                            "but there are more than one non-option arguments!")
		exit(1)
	elif not rep.head.commit.diff(None):
		print_red("[Committer] There are no changed files to compile!")
		exit(1)

	commit_message = not_option_ids[0]
	print_green("Committing all files with message:", commit_message)

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
	primary_conspects, changed_files = split(changed_files, lambda path: file_is_conspect_source_in_decryption(path))
	# Split by starting folder:
	for group, ps in it.groupby(primary_conspects, lambda p: Path(p).parts[0]):
		paths = list(ps)
		rep.index.add(paths)
		# print(describe_file_formats(paths))
		rep.git.commit(
			m=f"{random.choice(updating_phrases)} {subject_decryption[group]} conspect ({describe_file_formats(paths)})")

	# 2. Conspects in subdirectories is ones in decryption:
	secondary_conspects, changed_files = split(changed_files, lambda path: file_is_conspect_source_in_decryption_subfolder(path))
	for group, ps in it.groupby(secondary_conspects, lambda p: Path(p).parent):
		paths = list(ps)
		subj_folder, topic_folders = Path(group).parts[0], Path(*Path(group).parts[1:]).as_posix()

		rep.index.add(paths)
		rep.git.commit(
			m=f"{random.choice(updating_phrases)} {subject_decryption[subj_folder]} conspect with topic: \"{topic_folders}\" ({describe_file_formats(paths)})")

	# 3. Python scripts «for compiling and committing»:
	changed_scripts, changed_files = split(changed_files, lambda path: Path(path).suffix == ".py")
	if changed_scripts:
		rep.index.add(changed_scripts)
		rep.git.commit(m=f"{random.choice(updating_phrases)} python scripts for compilation and committing")

	# 4. Latex templates and demonstration:
	latex_templates, changed_files = split(changed_files, lambda path: in_template_subdir(path))
	if latex_templates:
		rep.index.add(latex_templates)
		rep.git.commit(m=f"{random.choice(updating_phrases)} latex templates")


	# 5. Supporting materials (non-connected pdfs; images and etc.) by directory (if it's subject's subdir):
	# TODO: Mark only certain file extensions as supporting materials:
	#  non-connected pdfs; images and something else
	#  (observe actual practice for it)
	supporting_materials, changed_files = split(changed_files, lambda path: file_in_subj_subdir(path))

	for subj_folder, path_it in it.groupby(supporting_materials, lambda p: Path(p).parts[0]):
		paths = list(path_it)
		rep.index.add(paths)
		rep.git.commit(
			m=f"Add supporting materials for {subject_decryption[subj_folder]} ({describe_file_formats(paths)})")

	# 6. Font-connected stuff:
	changed_fonts, changed_files = split(changed_files, lambda path: Path(path).suffix == ".ttf" or file_in_topic_subdir(path, ["Fonts"]))
	if changed_fonts:
		rep.index.add(changed_scripts)
		rep.git.commit(m=f"{random.choice(updating_phrases)} python scripts for compilation and committing")


	# 7. Unknown files by directory (or empty)…
	if changed_files:
		rep.index.add(changed_files)
		rep.git.commit(m=f"{random.choice(updating_phrases)} some unknown files: {', '.join(changed_files)}")

# ***All the other files appeared before we started compilation***

# Separate commit for compiled files:
if successful_files:
	compiled_pdfs = [item.a_path for item in rep.head.commit.diff(None) if Path(item.a_path).suffix == ".pdf"]
	compiled_names = [Path(path).stem for path in compiled_pdfs]

	rep.git.add(all=True)
	rep.git.commit(m=f"Compile these conspects: {', '.join(compiled_names)}")

# Print commits made during this script's work:

blue_divider()
print_green("[Committer] Finished committing successfully")
# if

print_green("These commits have been made:")
blue_divider()

commits_made = list(itertools.takewhile(lambda c: c.hexsha != last_commit_before_launch.hexsha,
                                        itertools.chain([rep.commit()], rep.commit().iter_parents())))
for p in commits_made:
	print(p)
# print(, "->", rep.commit().hexsha)

# print(last_commit_before_launch.hexsha)
