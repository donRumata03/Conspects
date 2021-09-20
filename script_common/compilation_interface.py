from script_common.script_commons import *
import glob

def collect_files(extension: str) -> list:
    files_to_compile = []
    if len(sys.argv) == 1:
        user_answer = ""

        all_files_cached = False

        while user_answer.lower() not in ["y", "n"]:
            if not all_files_cached:
                files_to_compile = list(map(str, this_dir.rglob("*" + extension)))
                all_files_cached = True

            colored_print(bcolors.WARNING, f"Name of file to compile isn't provided!\n"
                                           f"Are you sure that you really want to re-compile "
                                           f"ALL the \"{extension}\" files in ./ and its subdirs: {files_to_compile}? [Y/N]: ", end="")
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
    errors = 0

    for filename in files_to_compile:
        OK = compiling_function(filename)
        if not OK:
            errors += 1

    color = bcolors.OKGREEN if errors == 0 else (bcolors.FAIL if errors == len(files_to_compile) else bcolors.WARNING)
    colored_print(color, f"Сompiled {len(files_to_compile)} files with {errors} errors…")


