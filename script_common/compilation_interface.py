from script_common.script_commons import *


def collect_files(extension: str) -> list:
    files_to_compile = []
    if len(sys.argv) == 1:
        user_answer = ""

        while user_answer.lower() not in ["y", "n"]:
            colored_print(bcolors.WARNING, f"Name of file to compile isn't provided!\n"
                                           f"Are you sure that you really want to re-compile "
                                           f"ALL the \"{extension}\" files in ./ and its subdirs? [Y/N]: ", end="")
            user_answer = input()
            if user_answer.lower() == "y":
                print("OK, recompiling all files...")
                # files_to_compile.extend()
                break
            elif user_answer.lower() == "n":
                colored_print(bcolors.FAIL, "Recompiling all files CANCELLED")
                exit(-1)
            else:
                print()

        for path, subdirs, files in os.walk("./"):
            for name in files:
                path = Path(os.path.join(path, name))
                if path.suffix == extension:
                    files_to_compile.append(path)

    else:
        files_to_compile.extend(sys.argv[1:])

    return files_to_compile

