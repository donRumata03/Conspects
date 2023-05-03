# Just use `typst compile {path}`
import time
from pathlib import Path
from typing import Tuple

from scripts.script_commons import print_red, console_colors, colored_print, run_command, conspects_root_dir, \
    path_is_child


def compile_one_file(path, show_compilation_output=False) -> Tuple[bool, float]:
    extension = Path(path).suffix
    if extension != ".typ":
        print_red(f"Extension is: \"{extension}\", should be typ!!!")
    assert extension == ".typ"

    compiling_command = f"typst compile {path}"
    colored_print(console_colors.OKGREEN, f"Compiling {Path(path).name} file with command: {compiling_command}")

    comp_start = time.perf_counter()
    comp_time = time.perf_counter() - comp_start

    exit_code = run_command(compiling_command)

    if exit_code != 0:
        colored_print(console_colors.FAIL, f"Error at compiling Typst file: {Path(path).name}!")
    else:
        colored_print(console_colors.OKGREEN, f"Successfully compiled Typst in {round(comp_time, 1)} seconds!")

    return exit_code == 0, comp_time


def typst_file_should_be_compiled(path: str | Path):
    # Ignore only files in folder ./LatexGloves/typst and all subfolders except ./LatexGloves/typst/demo
    path = Path(path)

    is_in_gloves_typst = path_is_child(path, conspects_root_dir / "LatexGloves" / "typst")
    is_in_gloves_typst_demo = path_is_child(path, conspects_root_dir / "LatexGloves" / "typst" / "demo")

    return not is_in_gloves_typst or is_in_gloves_typst_demo
