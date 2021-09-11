import sys
import os

from script_common.script_commons import *


decryption = {
	"Algorithms": "Algorithms and data structures",
	"CompArch": "Computer architecture",
	"DiscreteMath": "Discrete mathematics",
	"LinearAlgebra": "Linear algebra",
	"MathAnal": "Mathematics anal"
}


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
