# Ignore (don't compile) README.md files
# tex and md files in {./DIR/}, DIR in decryption directories are committed separately for each directory with message about being conspect
# files in subdirs of dirs in «decryption» dict are committed in groups by full directory paths, the paths participate in messages
# Other paths are committed together. If there are .py files, it's written «…including python scripts».
# If there (not in DIR € decryption or its subdirs) are almost only python files (n_python ≈100%n_files and no files are .tex or .md), it's
import itertools
from typing import Tuple

from git import Repo

import compile_latex
import compile_md
import compile_typst
from scripts import compilation_interface
from scripts.script_commons import *

################################################					Settings: 			##############################

subject_decryption = {
    "Analgorithms": "Algorithms and data structures",
    "CUMputerAAAAAAAAH": "Computer architecture",
    "DICKreteMath": "Discrete mathematics",
    "LinAnalgebra": "Linear algebra",
    "MathAnal": "Mathematics anal",
    "DiffECation": "Differential equations",
    "Fistory": "History (reforms and reformers in russian history)",
    "MathCOQ": "Math logic",
    "BillyTheory": "Probability theory",
    "CockumberTheory": "Number theory"
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
    ".typ": "Typst source",
    ".pdf": "Compiled conspect",
    ".png": "Image"
}

compiling_script_by_extension = {
    ".tex": "compile_latex.py",
    ".md": "compile_md.py",
    ".typ": "compile_typst.py"
}

compiling_function_by_extension = {
    ".tex": compile_latex.compile_one_file,
    ".md": compile_md.compile_one_file,
    ".typ": compile_typst.compile_one_file
}

compilation_filter_by_extension = {
    ".tex": compile_latex.latex_file_should_be_compiled,
    ".md": compile_md.md_file_should_be_compiled,
    ".typ": compile_typst.typst_file_should_be_compiled
}

updating_phrases = [
    "Update",
    "Work on",
    "Modify",
    "Commit changes into",
    "Edit",
    "Change",
    "Improve",
]


def try_add_file_to_git(path: str, repository):
    try:
        repository.index.add(path)
    except Exception as e:
        colored_print(console_colors.WARNING, f"Can't add file (probably, it doesn';'t exist anymore): {path}")
        print("The exception:", e)


def try_add_many_files_to_git(file_paths: List[str], repository):
    for p in file_paths:
        try_add_file_to_git(p, repository)


def try_commit(repository, m):
    try:
        repository.git.commit(m=m)
    except Exception as e:
        colored_print(console_colors.WARNING, "Failed to commit with message: {m}… Probably, there are no files left")
        print("The exception:", e)


def compile_file(path) -> Tuple[bool, float]:
    ext = Path(path).suffix
    assert ext in compiling_function_by_extension

    compiler_function = compiling_function_by_extension[ext]
    compilation_output = compiler_function(path, False)
    if not compilation_output[0]:
        colored_print(console_colors.FAIL, f"[Committer] STRONG WARNING: Couldn't compile {ext} file \"{path}\"")
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
    return file_in_subj_subdir(path) and Path(path).suffix in compiling_script_by_extension


def file_is_conspect_source_in_decryption(path: str):
    return file_is_conspect_source_in_decryption_subfolder(path) and len(Path(path).parts) == 2


def in_template_subdir(path):
    p = Path(path).parts
    return p and Path(p[0]).is_dir() and p[0] == "LatexGloves"


def is_pdf_associated_with_source(path: str):
    p = Path(path)
    return p.suffix == ".pdf" and \
        p.stem in [pretendent.stem for pretendent in p.parent.iterdir() if
                   pretendent.suffix in compiling_script_by_extension]


rep = Repo(conspects_root_dir)
last_commit_before_launch = rep.commit()

rep.git.add(all=True)
changed_files = [item.b_path for item in rep.head.commit.diff(None) if not is_pdf_associated_with_source(item.b_path)]

# Filter only files for compilation:
files_to_compile = [
    file
    for file in changed_files
    if Path(file).suffix in compilation_filter_by_extension and compilation_filter_by_extension[Path(file).suffix](file)
]
print_green(f"[Committer] Changed files: {changed_files}")
print_green(f"[Committer] Files to (re)compile: {files_to_compile}")

# COMPILE files:
successful_files, all_files = compilation_interface.compile_file_set(files_to_compile, compile_file)
successfully_compiled_files_n = len(successful_files)

print_green(
    f"[Committer] Compiled everything possible and required ({successfully_compiled_files_n}/{len(files_to_compile)} successful)")

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
    try_commit(rep, m=commit_message)

else:
    user_commit_message = sys.argv[1] if len(sys.argv) > 1 else None

    def commit_with_user_message(description):
        try_commit(rep, m=f"{description}: {user_commit_message}" if user_commit_message is not None else description)


    # Subsequently processing different file categories
    # Those thing have special meaning:
    # - DIR € decryption
    # - ./DIR/.../.../... DIR € decryption
    # - .py files in other places

    # 1. Conspect source files in DIR € decryption
    primary_conspects, changed_files = split(changed_files, lambda path: file_is_conspect_source_in_decryption(path))
    # Split by starting folder:
    for group, ps in it.groupby(primary_conspects, lambda p: Path(p).parts[0]):
        paths = list(ps)
        try_add_many_files_to_git(paths, rep)
        # print(describe_file_formats(paths))
        commit_with_user_message(f"{random.choice(updating_phrases)} {subject_decryption[group]} conspect ({describe_file_formats(paths)})")

    # 2. Conspects in subdirectories is ones in decryption:
    secondary_conspects, changed_files = split(changed_files,
                                               lambda path: file_is_conspect_source_in_decryption_subfolder(path))
    for group, ps in it.groupby(secondary_conspects, lambda p: Path(p).parent):
        paths = list(ps)
        subj_folder, topic_folders = Path(group).parts[0], Path(*Path(group).parts[1:]).as_posix()

        try_add_many_files_to_git(paths, rep)
        commit_with_user_message(f"{random.choice(updating_phrases)} {subject_decryption[subj_folder]} conspect with topic: \"{topic_folders}\" ({describe_file_formats(paths)})")

    # 3. Python scripts «for compiling and committing»:
    changed_scripts, changed_files = split(changed_files, lambda path: Path(path).suffix == ".py")
    if changed_scripts:
        try_add_many_files_to_git(changed_scripts, rep)
        commit_with_user_message(f"{random.choice(updating_phrases)} python scripts for compilation and committing")

    # 4. Latex/typst templates and demonstration:
    templates, changed_files = split(changed_files, lambda path: in_template_subdir(path))
    if templates:
        try_add_many_files_to_git(templates, rep)
        commit_with_user_message(f"{random.choice(updating_phrases)} LaTeX/Typst templates/demonstrations")

    # 5. Supporting materials (non-connected pdfs; images and etc.) by directory (if it's subject's subdir):
    # TODO: Mark only certain file extensions as supporting materials:
    #  non-connected pdfs; images and something else
    #  (observe actual practice for it)
    supporting_materials, changed_files = split(changed_files, lambda path: file_in_subj_subdir(path))

    for subj_folder, path_it in it.groupby(supporting_materials, lambda p: Path(p).parts[0]):
        paths = list(path_it)
        try_add_many_files_to_git(paths, rep)
        commit_with_user_message(f"Add supporting materials for {subject_decryption[subj_folder]} ({describe_file_formats(paths)})")

    # 6. Font-connected stuff:
    changed_fonts, changed_files = split(changed_files,
                                         lambda path: Path(path).suffix == ".ttf" or file_in_topic_subdir(path,
                                                                                                          ["Fonts"]))
    if changed_fonts:
        try_add_many_files_to_git(changed_scripts, rep)
        commit_with_user_message(f"{random.choice(updating_phrases)} python scripts for compilation and committing")

    # 7. Unknown files by directory (or empty)…
    if changed_files:
        try_add_many_files_to_git(changed_files, rep)
        commit_with_user_message(f"{random.choice(updating_phrases)} some unknown files: {', '.join(changed_files)}")

# ***All the other files appeared before we started compilation***

# Separate commit for compiled files:
if successful_files:
    compiled_pdfs = [item.b_path for item in rep.head.commit.diff(None) if Path(item.b_path).suffix == ".pdf"]
    compiled_names = [Path(path).stem for path in compiled_pdfs]

    rep.git.add(all=True)
    try_commit(rep, m=f"Compile these conspects: {', '.join(compiled_names)}")

# Print commits made during this script's work:

blue_divider()
print_green("[Committer] Finished committing successfully")
# if

print_green("These commits have been made:")
blue_divider()

commits_made = reversed(list(itertools.takewhile(lambda c: c.hexsha != last_commit_before_launch.hexsha,
                                                 itertools.chain([rep.commit()], rep.commit().iter_parents()))))

run_command(f"git show --name-only {' '.join(map(lambda c: c.hexsha, commits_made))}")
