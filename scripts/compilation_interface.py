import os.path
from collections import namedtuple

from scripts.script_commons import *
import glob


def collect_files(extension: str, filtering_function: Callable = None) -> list:
    files_to_compile = []
    if len(sys.argv) == 1:
        user_answer = ""

        all_files_cached = False

        while user_answer.lower() not in ["y", "n"]:
            if not all_files_cached:
                files_to_compile = list(map(str, conspects_root_dir.rglob("*" + extension)))
                if filtering_function is not None:
                    files_to_compile = list(filter(filtering_function, files_to_compile))
                all_files_cached = True

            colored_print(bcolors.WARNING, f"Name of file to compile isn't provided!\n"
                                           f"Are you sure that you really want to re-compile "
                                           f"ALL the \"{extension}\" files in ./ and its subdirs: {[str(Path(os.path.relpath(f))) for f in files_to_compile]}? [Y/N]: ", end="")
            user_answer = input()
            if user_answer.lower() == "y":
                print("OK, recompiling all files...")
                break
            elif user_answer.lower() == "n":
                colored_print(bcolors.FAIL, "Recompiling all files CANCELLED")
                exit(-1)
            else:
                print()

    else:
        files_to_compile.extend(sys.argv[1:])

    return files_to_compile


def compile_file_set(files_to_compile, compiling_function):
    FileData = namedtuple("FileData", ['path', 'comp_time'])

    errors = 0
    successful_files = []
    files_with_errors = []

    for filename in files_to_compile:
        blue_divider()
        pretty_path = str(Path(os.path.relpath(filename, conspects_root_dir)).as_posix())

        OK, compilation_time = compiling_function(filename)
        this_file_data = FileData(path=pretty_path, comp_time=compilation_time)
        if not OK:
            files_with_errors.append(this_file_data)
        else:
            successful_files.append(this_file_data)

    color = bcolors.OKGREEN if errors == 0 else (bcolors.FAIL if errors == len(files_to_compile) else bcolors.WARNING)

    blue_divider()
    colored_print(bcolors.OKBLUE, "                     Compilation Report")

    colored_print(color, f"Conducted CUMpilation of {len(files_to_compile)} files: {len(successful_files)} - successfully, {len(files_with_errors)} - with errors…")

    blue_divider()
    if successful_files:
        print_green("These files were compiled successfully:")
        # print_green("\n".join(successful_files))
        for file_data in successful_files:
            print(file_data.path, end=' ')
            print_green("(" + str(file_data.comp_time) + ")")

    blue_divider()
    if files_with_errors:
        print_red(f"ERRORS occurred while compiling these files:")
        # print_red("\n".join(files_with_errors))
        for file_data in files_to_compile:
            print(file_data.path, end=' ')
            print_red("(" + str(file_data.comp_time) + ")")


if __name__ == '__main__':
    print(os.path.commonprefix([
        "/home/vova/dev/Education/Conspects",
        "/home/vova/dev/Education/Conspects/LinAnalgebra/RoutineCalculations/1.4 - AnalGeom_plane.tex"
    ]))
    print(os.path.relpath(
        "/home/vova/dev/Education/Conspects/LinAnalgebra/RoutineCalculations/1.4 - AnalGeom_plane.tex",
        "/home/vova/dev/Education/Conspects/"
    ))
