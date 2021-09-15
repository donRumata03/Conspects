from script_common.script_commons import *

from git import Repo

decryption = {
	"Analgorithms": "Algorithms and data structures",
	"CUMputerArch": "Computer architecture",
	"DICKreteMath": "Discrete mathematics",
	"LinAnalgebra": "Linear algebra",
	"MathAnalgeBRUH": "Mathematics anal"
}

extensions_for_compilation = {
	".tex",
	".md"
}

rep = Repo(this_dir)

# Track all files:
rep.git.add(all=True)

# Filter only files for compilation:
print(len(rep.git.show("--pretty=", "--name-only")))
# print(rep.index.diff("HEAD")[1].path())
a_modified_files = [item.a_path for item in rep.index.diff("HEAD")]
b_modified_files = [item.b_path for item in rep.index.diff("HEAD")]

print(a_modified_files)
print(b_modified_files)

# print(f"{rep.untracked_files}")


exit()

# commit_message = " ".join(sys.argv[1:]) if len(sys.argv) > 1 else "Update MathAnalysis conspect"
commit_message = "Update MathAnalysis conspect"
if len(sys.argv) > 1:
	commit_message += ": " + " ".join(sys.argv[1:])
print(f"Commit message will be: \"{commit_message}\"")

# if not commit_message:
# 	say, which files are changed:
# 	commit_message = ""


print("Compiling…")

exit_data = run_python_script("compile.py")
if exit_data != 0:
	colored_print(bcolors.FAIL, "Failed to comile MathAnalysis conspect! Terminating…")
	exit(1)

colored_print(bcolors.OKGREEN, "Successfully compiled => commiting…")

os.system(f"git add -u ./")
os.system(f"git commit -m \"{commit_message}\"")
